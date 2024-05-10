//
//  RootLoadingView.swift
//  PlaySentinel
//
//  Created by Никита Михайлов on 10.05.2024.
//

import SwiftUI

struct RootLoadingView: View {
    var body: some View {
        VStack {
            ProgressView().padding(10)
            Text("Загрузка...")
        }
    }
}

#Preview {
    RootLoadingView()
}
