//
//  ContentView.swift
//  PlaySentinel
//
//  Created by Никита Михайлов on 20.03.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onTapGesture {
            print("qqweqwe")
        }
    }
}

#Preview {
    ContentView()
}
