//
//  MainViewModel.swift
//  PlaySentinel
//
//  Created by Никита Михайлов on 08.06.2024.
//

import Foundation

@MainActor
final class MainViewModel : ObservableObject {
    
    init() {
        Task  {
            await onStart()
        }
    }
    
    enum State {
        case loading
        case loaded
        case error
        case noHubs
    }
    
    func onStart()  async  {
        do {
            let data =  try await HubRepository.instance.getHubs(userId: RootViewModel.instance.user?.id ?? "")
            self.hubs = data
            
            if(self.hubs.isEmpty) {
                state = .noHubs
            }else {
                state = .loaded
            }
            
        }catch {
            state = .error
        }
        
    }
    
    func onRefresh() async {
        state = .loading
        await onStart();
    }
    
    private(set) var hubs : [Hub] = []
    @Published private(set) var state = State.loading
}
