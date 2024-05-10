//
//  ProfileViewModel.swift
//  PlaySentinel
//
//  Created by Никита Михайлов on 26.03.2024.
//

import Foundation


@MainActor
final class ProfileViewModel: ObservableObject {
    
    @Published private(set) var user : DBUser? = nil
    
    func loadCurrentUser() async throws {
        let firebaseUser = try AuthenticationRepository.shared.getAuthenticatedUser()
        let user = try await UserFirestoreService.shared.getUser(id: firebaseUser.uid)
        self.user = user
    }
    
}
