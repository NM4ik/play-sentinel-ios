//
//  Snack.swift
//  PlaySentinel
//
//  Created by Никита Михайлов on 07.05.2024.
//

import SwiftUI

struct SnackBar: View {
    var message: String
    @State private var isShowing = true
    
    var body: some View {
        VStack {
            if isShowing {
                Text(message)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.gray)
                    .cornerRadius(10)
                    .transition(.slide)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                isShowing = false
                            }
                        }
                    }
            }
        }
    }
}
