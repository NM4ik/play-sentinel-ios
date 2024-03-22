//
//  AuthenticationView.swift
//  PlaySentinel
//
//  Created by Никита Михайлов on 21.03.2024.
//

import Foundation
import SwiftUI
import GoogleSignInSwift


@MainActor
final class AuthenticationViewModel: ObservableObject {
    func signInWithGoogle() async throws{
        let data = try await GoogleSignInService().signIn()
        try await AuthenticationRepository.shared.signInWithGoogle(data: data)
    }
}


struct AuthenticationView : View {
    @Binding var showSignInView : Bool
    @StateObject var viewModel = AuthenticationViewModel()
    
    var body : some View {
        VStack{
            NavigationLink  {
                SignInEmailView(showSignInView: $showSignInView)
            } label: {
                Text("Sign In with email")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            
            
            GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(scheme: .dark, style: .wide, state: .normal), action: {
                Task {
                    do{
                        try await viewModel.signInWithGoogle()
                        showSignInView = false
                    }catch {
                        print("Error  viewModel.signInWithGoogle - \(error)")
                    }
                }
            })
        }
        .padding()
        .navigationTitle("Sign In")
        
    }
}


#Preview {
    NavigationStack{
        AuthenticationView(showSignInView: .constant(false))
    }
}

