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
    static var user : DBUser?
    
    func reduce(event: Event) async {
        switch event {
        case .onAppear:
            await onAppear()
        case .onAuth:
            onAuth()
        }
    }
    
    
    private func onAppear() async {
        guard let authUser = try?  AuthenticationRepository.shared.getAuthenticatedUser() else {
            state =  State.unAuthenticated
            return
        }
        
        guard let firestoreUserExists = try? await UserFirestoreService.shared.getUser(id: authUser.uid) else {
            state =  State.unAuthenticated
            return
        }
        
        RootViewModel.user = firestoreUserExists
        state =  State.authenticated
    }
    
    private func onAuth() {
        state = State.authenticated
    }
    
    
    func signInWithGoogle() async throws -> Bool {
        let data = try await GoogleSignInService().signIn()
        let user = try await AuthenticationRepository.shared.signInWithGoogle(data: data)
        return try await UserFirestoreService.shared.createNewUser(user: DBUser(auth: user))
    }
}
