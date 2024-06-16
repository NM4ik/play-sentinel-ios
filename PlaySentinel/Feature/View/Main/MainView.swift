//
//  MainView.swift
//  PlaySentinel
//
//  Created by Никита Михайлов on 08.06.2024.
//

import SwiftUI

struct MainView: View {
    @StateObject private var mainViewModel = MainViewModel()
    
    var body: some View {
        contentView()
        
    }
    
    
    @ViewBuilder func contentView() ->  some View {
        switch mainViewModel.state {
        case .loading:
            LoadingIndicatorView()
        case .loaded:
            HubListView(hubs: mainViewModel.hubs).refreshable {
                Task {
                    await  mainViewModel.onRefresh()
                }
            }
        case .noHubs:
            VStack{
                Text("Нет активных хабов.")
                NavigationLink(destination: CreateHubView(), isActive: .constant(false)) {
                    Text("Создать хаб")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding()
            }
        case .error:
            Text("ERROR")
        }
        
    }
}

#Preview {
    MainView()
}
