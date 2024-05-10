//
//  RootView.swift
//  PlaySentinel
//
//  Created by Никита Михайлов on 21.03.2024.
//

import SwiftUI

struct RootView: View {
    @ObservedObject var rootViewModel : RootViewModel = RootViewModel()
    
    
    var body: some View {
        VStack {
            contentView()
        }.onAppear {
            Task {
                await rootViewModel.reduce(event: .onAppear)
            }
        }
    }
    
    
    @ViewBuilder func contentView() ->  some View {
        switch rootViewModel.state {
        case .authenticated:
            GeneralView(user: RootViewModel.user)
        case .loading:
            RootLoadingView()
        case .unAuthenticated:
            AuthenticationView(rootViewModel: rootViewModel)
        case .error:
            RootErrorView()
        }
    }
}


#Preview {
    RootView()
}
