//
//  AuthenticationRepository.swift
//  PlaySentinel
//
//  Created by Никита Михайлов on 21.03.2024.
//

import Foundation
import FirebaseAuth



enum AuthProviderOption : String {
    case email = "password"
    case google = "google.com"
}


final class AuthenticationRepository {
    static let shared = AuthenticationRepository()
    
    func getAuthenticatedUser() throws -> AppUser{
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        
        return AppUser(fireUser: user)
    }
    
    func logOut() {
        try? Auth.auth().signOut()
    }
    
    func getProviders() throws -> [AuthProviderOption] {
        guard let providerData = Auth.auth().currentUser?.providerData else {
            throw URLError(.badServerResponse)
        }
        var providers : [AuthProviderOption] = []
        for item in providerData {
            if let option = AuthProviderOption(rawValue: item.providerID)  {
                providers.append(option)
            }else {
                assertionFailure("Provider option not found: \(item)")
            }
        }
        
        return providers
    }
}


@MainActor
extension AuthenticationRepository {
//    @discardableResult
//    func createUser(email : String, password: String) async throws -> AppUser {
//        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
//        return AppUser(fireUser: authDataResult.user)
//    }
    
//    @discardableResult
//    func authUser(email : String, password: String) async throws -> AppUser {
//        let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
//        return AppUser(fireUser: authDataResult.user)
//    }

    func resetPassword(email : String) async throws {
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }
}


extension AuthenticationRepository {
    func signInWithGoogle(data : GoogleSignInModel) async throws ->  AppUser {
        let credentinal = GoogleAuthProvider.credential(withIDToken: data.idToken, accessToken: data.accessToken)
        let user = try await  Auth.auth().signIn(with: credentinal)
        
        return AppUser(id: user.user.uid, email: user.user.email, photo: user.user.photoURL?.absoluteString, name: user.user.displayName)
    }
}
