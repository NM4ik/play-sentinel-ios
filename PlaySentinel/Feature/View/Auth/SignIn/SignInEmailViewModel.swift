//
//  SignInEmailViewModel.swift
//  PlaySentinel
//
//  Created by Никита Михайлов on 26.03.2024.
//

import Foundation
import Firebase


@MainActor
final class SignInEmailViewModel : ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    
    func signIn() async throws {
        guard !email.isEmpty || !password.isEmpty else {
            print("isEmpty")
            return
        }
        
        try await AuthenticationRepository.shared.authUser(email: email, password: password)
    }
    
    func signUp() async throws {
        guard !email.isEmpty || !password.isEmpty else {
            print("isEmpty")
            return
        }
        
        let user = try await AuthenticationRepository.shared.createUser(email: email, password: password)
        try await UserFirestoreService.shared.createNewUser(user: DBUser(auth: user))
    }
}
