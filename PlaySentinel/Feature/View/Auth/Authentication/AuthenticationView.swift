//
//  AuthenticationView.swift
//  PlaySentinel
//
//  Created by Никита Михайлов on 21.03.2024.
//

import Foundation
import SwiftUI
import GoogleSignInSwift



struct AuthenticationView : View {
    
    var body : some View {
        VStack{
            //            NavigationLink  {
            //                SignInEmailView(showSignInView: $showSignInView)
            //            } label: {
            //                Text("Sign In with email")
            //                    .font(.headline)
            //                    .foregroundColor(.white)
            //                    .frame(height: 55)
            //                    .frame(maxWidth: .infinity)
            //                    .background(Color.blue)
            //                    .cornerRadius(10)
            //            }
            
            
            GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(scheme: .dark, style: .wide, state: .normal), action: googlePress)
            //
            //
            //
            //            if isShowingSnackBar {
            //                SnackBar(message: "Authentication Failed")
            //                    .padding(.horizontal)
            //            }
        }
        .padding()
        .navigationTitle("Log In")
        .foregroundColor(.white)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            Image("AuthBg")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
        }
    }
    
    @MainActor
    func googlePress()  {
        Task {
            await RootViewModel.instance.reduce(event: .onAuth)
        }
    }
    
    //    func showSnack() {
    //        isShowingSnackBar = true
    //        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
    //            withAnimation {
    //                isShowingSnackBar = false
    //            }
    //        }
    //    }
}


#Preview {
    NavigationStack{
        AuthenticationView()
    }
}

