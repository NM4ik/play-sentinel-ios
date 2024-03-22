//
//  SettingsView.swift
//  PlaySentinel
//
//  Created by Никита Михайлов on 21.03.2024.
//

import SwiftUI


final class SettingsViewModel: ObservableObject {
    
    @Published var authProviders : [AuthProviderOption] = []
    
    func loadProviders () {
        if let providers = try? AuthenticationRepository.shared.getProviders() {
            authProviders = providers
            
            print(authProviders)
        }
    }
    
    
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
            if(!viewModel.authProviders.contains(.google)) {
                Section(content: {
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
                }, header: {
                    Text("Account actions")
                })
            }
            
            
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
            
            
        }
        .navigationBarTitle("Settings")
        .onAppear {
            viewModel.loadProviders()
        }
    }
}

#Preview {
    NavigationStack{
        SettingsView(showSignInView: .constant(false))
    }
}
