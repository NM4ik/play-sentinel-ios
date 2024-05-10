//
//  ProfileView.swift
//  PlaySentinel
//
//  Created by Никита Михайлов on 25.03.2024.
//

import SwiftUI


struct GeneralView: View {
    let user : DBUser?
    @State private var currentTab = 0
    
    var body: some View {
        TabView(selection: $currentTab) {
            Text("Home")
                .tabItem {
                    Image(systemName: "house")
                    Text("Профиль")
                }.tag(0)
            
            ProfileView(user: user)
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("Профиль")
                }.tag(1)
        }
    }
}

#Preview {
    NavigationStack {
        GeneralView(user: DBUser(id: "123", email: "TEST", photo: "test"))
    }
}
