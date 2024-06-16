//
//  RootView.swift
//  PlaySentinel
//
//  Created by Никита Михайлов on 21.03.2024.
//

import SwiftUI

struct RootView: View {
    @ObservedObject var rootViewModel : RootViewModel = RootViewModel.instance
    
    
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
            GeneralView()
        case .loading:
            RootLoadingView()
        case .unAuthenticated:
            AuthenticationView()
        case .error:
            RootErrorView()
        }
    }
}


#Preview {
    RootView()
}
