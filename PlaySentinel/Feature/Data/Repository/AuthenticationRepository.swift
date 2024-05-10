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
    
    func getAuthenticatedUser() throws -> AuthDataResultModel{
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        
        return  AuthDataResultModel(user: user)
    }
    
    func logOut()  throws  {
        try Auth.auth().signOut()
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
    @discardableResult
    func createUser(email : String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    @discardableResult
    func authUser(email : String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
        let user = AuthDataResultModel(user: authDataResult.user)
        return user
    }
    
    func resetPassword(email : String) async throws {
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }
}


extension AuthenticationRepository {
    func signInWithGoogle(data : GoogleSignInModel) async throws ->  AuthDataResultModel {
        let credentinal = GoogleAuthProvider.credential(withIDToken: data.idToken, accessToken: data.accessToken)
        let authDataResult = try await  Auth.auth().signIn(with: credentinal)
        let user = AuthDataResultModel(user: authDataResult.user)
        return user
    }
}
