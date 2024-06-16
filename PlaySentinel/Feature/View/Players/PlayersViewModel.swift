//
//  PlayersViewModel.swift
//  PlaySentinel
//
//  Created by Никита Михайлов on 16.06.2024.
//

import Foundation


final class PlayersViewModel  : ObservableObject {
    enum PlayersState {
        case error(Error)
        case loading
        case loaded([AppUser])
        case noUsers
    }
    
    @Published private(set) var state : PlayersState  = .loading
    
    
    func initData() async {
        
        print("INIT DATA")
        let users = try? await UserFirestoreService.shared.getUsers()
        print("INIT DATA - \(users)")
        
        if users == nil {
            state = .error(URLError(.badServerResponse))
            return
        }
        
        
        if users!.isEmpty {
            state = .noUsers
        } else {
            state = .loaded(users!)
        }
        
        
    }
    
    //    PlayersState.loaded([
    //        AppUser(id: "1", email: "myEmail@mail.com", photo: "https://www.simplilearn.com/ice9/free_resources_article_thumb/what_is_image_Processing.jpg", name: "Mikhailov Nikita"),
    //        AppUser(id: "2", email: "myEmail@mail.com", photo: "https://www.simplilearn.com/ice9/free_resources_article_thumb/what_is_image_Processing.jpg", name: nil),
    //        AppUser(id: "3", email: "myEmail@mail.com", photo: "https://www.simplilearn.com/ice9/free_resources_article_thumb/what_is_image_Processing.jpg", name: "TestoviyNickkName"),
    //        AppUser(id: "4", email: "qwfnoqsf@bk.com", photo: "https://www.simplilearn.com/ice9/free_resources_article_thumb/what_is_image_Processing.jpg", name: nil),
    //        AppUser(id: "5", email: "myEmail@mail.com", photo: "https://www.simplilearn.com/ice9/free_resources_article_thumb/what_is_image_Processing.jpg", name: "Mikhailov Nikita"),
    //    ])
}
