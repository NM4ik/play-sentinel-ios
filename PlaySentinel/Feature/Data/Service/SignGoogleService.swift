//
//  SignGoogleService.swift
//  PlaySentinel
//
//  Created by Никита Михайлов on 21.03.2024.
//

import Foundation
import GoogleSignIn



final class GoogleSignInService {
    
    @MainActor
    func signIn() async throws -> GoogleSignInModel {
        guard let topVC = Utils.shared.topViewController() else {
            throw URLError(.cannotFindHost)
        }
        let result = try await GIDSignIn.sharedInstance.signIn(withPresenting: topVC)
        let user = result.user
        guard let idToken = user.idToken?.tokenString else {
            throw URLError(.badServerResponse)
        }
        let accessToken = result.user.accessToken.tokenString
        
        return GoogleSignInModel(idToken: idToken, accessToken: accessToken, name: user.profile?.name, email: user.profile?.email)
    }
}
