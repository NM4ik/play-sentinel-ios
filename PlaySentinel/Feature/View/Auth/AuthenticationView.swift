//
//  AuthenticationView.swift
//  PlaySentinel
//
//  Created by Никита Михайлов on 21.03.2024.
//

import Foundation
import SwiftUI


struct AuthenticationView : View {
    @Binding var showSignInView : Bool
    
    var body : some View {
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
        }.padding()
    }
}


#Preview {
    NavigationStack{
        AuthenticationView(showSignInView: .constant(false))
    }
}

