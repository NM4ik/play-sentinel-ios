//
//  ProfileView.swift
//  PlaySentinel
//
//  Created by Никита Михайлов on 25.03.2024.
//

import SwiftUI


struct GeneralView: View {
    @State private var currentTab = 0
    
    var body: some View {
        TabView(selection: $currentTab) {
            MainView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Профиль")
                }.tag(0)
            
            ProfileView(user: RootViewModel.instance.user)
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("Профиль")
                }.tag(1)
        }
    }
}

#Preview {
    NavigationStack {
        GeneralView()
    }
}
