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
   let rootViewModel : RootViewModel
    
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
        .navigationTitle("Sign In")
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
    func googlePress() {
//        viewModel.reduce(event: .onAuth)
//        Task {
//            do{
//                let result = try await viewModel.signInWithGoogle()
//                if(result) {
//                    isShowingSnackBar = false
//                    showSignInView = false
//                    
//                } else {
//                    showSnack()
//                }
//            }catch {
//                print("Error  viewModel.signInWithGoogle - \(error)")
//                showSnack()
//            }
//        }
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
        AuthenticationView(rootViewModel: RootViewModel())
    }
}

