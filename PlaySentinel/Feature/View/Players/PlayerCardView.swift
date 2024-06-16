//
//  PlayerCardView.swift
//  PlaySentinel
//
//  Created by Никита Михайлов on 16.06.2024.
//

import SwiftUI

struct PlayerCardView: View {
    let user : AppUser
    let isSelected : Bool
    
    var body: some View {
        HStack {
            
            if user.photo != nil {
                VStack {
                }
                .frame(width: 25, height: 25)
                .background {
                    AsyncImage(url: URL(string: user.photo!)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        ProgressView()
                    }
                }
                .clipShape(.circle)
                
            }
            
            Text(user.name ?? user.email ?? "")
            
            Spacer()
            
            
            if !isSelected{
                Circle()
                    .stroke(Color.black, lineWidth: 1)
                    .frame(width: 20, height: 20)
            } else {
                Image(systemName: "checkmark")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 10)
                    .foregroundColor(.white)
                    .frame(width: 20, height: 20)
                    .background(Color(.green))
                    .clipShape(.circle)
            }
            //
            //            if !isSelected {
            //                Circle()
            //                    .stroke(Color.red, lineWidth: 1)
            //                    .background(Circle().foregroundColor(Color.clear))
            //                    .frame(width: 44, height: 44)
            //            } else {
            //                ZStack {
            //                    Circle()
            //                        .background(Circle().foregroundColor(Color.green))
            //                        .frame(width: 25, height: 25)
            //                }
            //            }
            //
            
            //            Image(systemName: "chevron.right")
        }
    }
}

#Preview {
    PlayerCardView(user: AppUser(id: "1", email: "myEmail@mail.com", photo: "https://www.simplilearn.com/ice9/free_resources_article_thumb/what_is_image_Processing.jpg", name: "Mikhailov Nikita"), isSelected: true)
}
