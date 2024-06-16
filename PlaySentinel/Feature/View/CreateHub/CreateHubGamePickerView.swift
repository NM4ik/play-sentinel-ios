//
//  CreateHubGamePicker.swift
//  PlaySentinel
//
//  Created by Никита Михайлов on 15.06.2024.
//

import SwiftUI

struct CreateHubGamePicker: View {
    let games : [Game]
    @Binding var selectedGame : Int
    
    var body: some View {
        Picker("Games", selection: $selectedGame) {
            ForEach(games.indices, id: \.self) { index in
                Text(games[index].name).tag(index)
            }
        }
        .onSubmit {
            print("selectedGame")
        }
        .pickerStyle(.segmented)
    }
}

#Preview {
    CreateHubGamePicker(
        games: [
            Game(id: 1, name: "FIFA", available: true),
            Game(id: 2, name: "RocketLeague", available: true),
            Game(id: 3, name: "Valorant", available: true),
        ], selectedGame: .constant(1)
    )
}
