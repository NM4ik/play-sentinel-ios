//
//  CreateHubViewModel.swift
//  PlaySentinel
//
//  Created by Никита Михайлов on 11.05.2024.
//

import Foundation

final class CreateHubViewModel : ObservableObject {
    @Published private(set) var state = State.loading
    var hubName: String = ""
    private var hubRepository = HubRepository.instance
    
    var games = [Game]()
    @Published var selectedGame = 0
    @Published var selectedUsers = [AppUser]()
    
    
    init() {
        print("CreateHubViewModel INITIDET")
    }
    
    enum State {
        case loading
        case loaded
        case error
        case noGames
        case notAvailableToCreateHub
    }
    
    enum Event {
        case onAppear
    }
    
    func reduce(event: Event) async {
        switch(event) {
        case .onAppear:
            await self.onAppear()
        }
    }
    
    @MainActor
    func onAppear() async {
        let isAvailableToCreateHub = await hubRepository.isAvaialbleToCreateHub(userId: RootViewModel.instance.user!.id)
        
        if !isAvailableToCreateHub {
            state = .notAvailableToCreateHub
            return
        }
        
        self.games = await hubRepository.getAvailableGames()
        if self.games.isEmpty {
            state = .noGames
            return
        }
        
        
        state = .loaded
    }
    
    func createHub() {
        print("hubName - \(hubName)")
        print("CurentGame - \(games[selectedGame])")
    }
    
}
