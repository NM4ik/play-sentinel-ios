//
//  SettingsView.swift
//  PlaySentinel
//
//  Created by Никита Михайлов on 21.03.2024.
//

import SwiftUI


final class SettingsViewModel: ObservableObject {
    
    func logOut() throws {
        try  AuthenticationRepository.shared.logOut()
    }
    
    func resetPassword() async throws {
        let authUser = try AuthenticationRepository.shared.getAuthenticatedUser()
        
        
        guard let email =  authUser.email else  {
            throw URLError(.fileDoesNotExist)
        }
        
        try await AuthenticationRepository.shared.resetPassword(email: email)
    }
}

struct SettingsView: View {
    
    @StateObject private var viewModel = SettingsViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        List {
            Button("LogOut"){
                Task {
                    do {
                        try viewModel.logOut()
                        showSignInView = true
                    } catch {
                        print("Error \(error)")
                    }
                }
            }
            
            Button("Reset Password"){
                Task {
                    do {
                        try  await viewModel.resetPassword()
                        showSignInView = true
                        
                        print("Password reseted")
                    } catch {
                        print("Error \(error)")
                    }
                }
            }
        }
        .navigationBarTitle("Settings")
    }
}

#Preview {
    NavigationStack{
        SettingsView(showSignInView: .constant(false))
    }
}
