//
//  AuthenticationRepository.swift
//  PlaySentinel
//
//  Created by Никита Михайлов on 21.03.2024.
//

import Foundation
import FirebaseAuth


struct AuthDataResultModel {
    let uid: String
    let email: String?
    let photoUrl: String?
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.photoUrl = user.photoURL?.absoluteString
    }
}

enum AuthProviderOption : String {
    case email = "password"
    case google = "google.com"
}


final class AuthenticationRepository {
    static let shared = AuthenticationRepository()
    
    private init() {
        
    }
    
    func getAuthenticatedUser() throws -> AuthDataResultModel{
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        
        return AuthDataResultModel(user: user)
    }
    
    func logOut()  throws  {
        try Auth.auth().signOut()
    }
    
    func getProviders() throws -> [AuthProviderOption] {
        guard let providerData = Auth.auth().currentUser?.providerData else {
            throw URLError(.badServerResponse)
        }
        var providers : [AuthProviderOption] = []
        
        print(providerData)
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

extension AuthenticationRepository {
    @discardableResult
    func createUser(email : String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    func authUser(email : String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    func resetPassword(email : String) async throws {
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }
}


extension AuthenticationRepository {
    
    @discardableResult
    func signInWithGoogle(data : GoogleSignInModel) async throws ->  AuthDataResultModel{
        let credentinal = GoogleAuthProvider.credential(withIDToken: data.idToken, accessToken: data.accessToken)
        let authDataResult = try await  Auth.auth().signIn(with: credentinal)
        return AuthDataResultModel(user: authDataResult.user)
    }
}
