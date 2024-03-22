//
//  RootView.swift
//  PlaySentinel
//
//  Created by Никита Михайлов on 21.03.2024.
//

import SwiftUI

struct RootView: View {
    
    @State private var showSignInView : Bool = false
    
    var body: some View {
        ZStack{
            if !showSignInView {
                NavigationStack {
                    SettingsView(showSignInView: $showSignInView)
                }
            }
        }
        .onAppear {
            let authUser = try?  AuthenticationRepository.shared.getAuthenticatedUser()
            self.showSignInView = authUser == nil
        }
        .fullScreenCover(isPresented: $showSignInView, content: {
            NavigationStack {
                AuthenticationView(showSignInView: $showSignInView)
            }
        })
    }
}

#Preview {
    RootView()
}
