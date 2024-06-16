//
//  AuthenticationViewModel.swift
//  PlaySentinel
//
//  Created by Никита Михайлов on 26.03.2024.
//

import Foundation
import Firebase


@MainActor
final class RootViewModel: ObservableObject {
    
    static let instance = RootViewModel()
    
    enum State {
        case loading
        case authenticated
        case unAuthenticated
        case error
    }
    
    enum Event {
        case onAppear
        case onAuth
    }
    
    @Published private(set) var state = State.loading
    private(set) var user : AppUser?
    
    
    func reduce(event: Event) async {
        switch event {
        case .onAppear:
            await onAppear()
        case .onAuth:
            await onAuth()
        }
    }
    
    
    private func onAppear() async {
        guard let authUser = try?  AuthenticationRepository.shared.getAuthenticatedUser(),
              let firestoreUserExists = try? await UserFirestoreService.shared.getUser(id: authUser.id)
        else {
            state =  State.unAuthenticated
            return
        }
        
        user = firestoreUserExists
        state =  State.authenticated
    }
    
    private func onAuth() async {
        let result = try? await signInWithGoogle()
        if result == true {
            guard let authUser = try?  AuthenticationRepository.shared.getAuthenticatedUser() else {
                print("authUser")
                state =  State.unAuthenticated
                return
            }
            
            guard let firestoreUserExists = try? await UserFirestoreService.shared.getUser(id: authUser.id) else {
                print("firestoreUserExists - \(authUser)")
                state =  State.unAuthenticated
                return
            }
            user = firestoreUserExists
            state = State.authenticated
        }
    }
    
    func logout() {
        AuthenticationRepository.shared.logOut()
        user = nil
        state = State.unAuthenticated
    }
    
    
    func signInWithGoogle() async throws -> Bool {
        let data = try await GoogleSignInService().signIn()
        let user = try await AuthenticationRepository.shared.signInWithGoogle(data: data)
        return try await UserFirestoreService.shared.createNewUser(user: AppUser(id: user.id, email: user.email, photo: nil, name: user.name))
    }
}
