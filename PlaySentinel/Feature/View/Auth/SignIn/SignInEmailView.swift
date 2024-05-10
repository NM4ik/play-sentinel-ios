//
//  SignInEmailView.swift
//  PlaySentinel
//
//  Created by Никита Михайлов on 21.03.2024.
//

import Foundation
import SwiftUI


struct SignInEmailView: View {
    
    @StateObject private var viewModel : SignInEmailViewModel =  SignInEmailViewModel()
    @Binding var showSignInView : Bool
    
    
    var body : some View {
        VStack {
            TextField("Email...", text: $viewModel.email)
                .padding()
                .background(Color.gray.opacity(0.3))
                .cornerRadius(10)
            
            SecureField("Password...", text: $viewModel.password)
                .padding()
                .background(Color.gray.opacity(0.3))
                .cornerRadius(10)
            
            
            Button {
                Task {
                    do{
                        try await  viewModel.signIn()
                        showSignInView = false
                    }catch {
                        print("Error: \(error)")
                    }
                    
                    do{
                        try await  viewModel.signUp()
                        showSignInView = false
                    }catch {
                        print("Error: \(error)")
                    }
                }
                
            } label: {
                Text("Sign In")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.top, 20)
            
        }
        .padding(.horizontal, 10)
        .navigationTitle("Sign In With Email")
    }
}


#Preview {
    NavigationStack{
        SignInEmailView(showSignInView: .constant(false))
    }
}
