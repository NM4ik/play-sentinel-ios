//
//  PlayersListView.swift
//  PlaySentinel
//
//  Created by Никита Михайлов on 16.06.2024.
//

import SwiftUI

struct PlayersListView: View {
    let users : [AppUser]
    @Binding var selectableIds : [AppUser]
    
    
    var body: some View {
        List {
            ForEach(users) {
                user in
                PlayerCardView(user: user, isSelected: selectableIds.contains(where: { id in
                    user.id == id.id
                }))
                .onTapGesture {
                    let contains = selectableIds.contains(where: {
                        id in user.id == id.id
                    })
                    
                    if !contains {
                        selectableIds.append(user)
                    }else {
                        selectableIds.removeAll(where: { id in
                            user.id == id.id
                        })
                    }
                }
            }
        }
    }
}

#Preview {
    PlayersListView(
        users: [
            AppUser(id: "1", email: "myEmail@mail.com", photo: "https://www.simplilearn.com/ice9/free_resources_article_thumb/what_is_image_Processing.jpg", name: "Mikhailov Nikita"),
            AppUser(id: "2", email: "myEmail@mail.com", photo: "https://www.simplilearn.com/ice9/free_resources_article_thumb/what_is_image_Processing.jpg", name: nil),
            AppUser(id: "3", email: "myEmail@mail.com", photo: "https://www.simplilearn.com/ice9/free_resources_article_thumb/what_is_image_Processing.jpg", name: "TestoviyNickkName"),
            AppUser(id: "4", email: "qwfnoqsf@bk.com", photo: "https://www.simplilearn.com/ice9/free_resources_article_thumb/what_is_image_Processing.jpg", name: nil),
            AppUser(id: "5", email: "myEmail@mail.com", photo: "https://www.simplilearn.com/ice9/free_resources_article_thumb/what_is_image_Processing.jpg", name: "Mikhailov Nikita"),
        ], selectableIds: .constant([ AppUser(id: "5", email: "myEmail@mail.com", photo: "https://www.simplilearn.com/ice9/free_resources_article_thumb/what_is_image_Processing.jpg", name: "Mikhailov Nikita"),  AppUser(id: "2", email: "myEmail@mail.com", photo: "https://www.simplilearn.com/ice9/free_resources_article_thumb/what_is_image_Processing.jpg", name: nil),]))
}
