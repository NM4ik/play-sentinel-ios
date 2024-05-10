//
//  LoadingIndicator.swift
//  PlaySentinel
//
//  Created by Никита Михайлов on 07.05.2024.
//

import SwiftUI

struct LoadingIndicatorView: View {
    var body: some View {
        ZStack {
            Color.black.opacity(0.3).edgesIgnoringSafeArea(.all)
            ProgressView()
        }
    }
}

