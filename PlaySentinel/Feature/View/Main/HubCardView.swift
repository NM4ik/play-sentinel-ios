//
//  HubCardView.swift
//  PlaySentinel
//
//  Created by Никита Михайлов on 11.06.2024.
//

import SwiftUI


struct HubCardView: View {
    let hub : Hub
    
    var body: some View {
        ZStack(alignment: .center) {
            HStack {
                Text(hub.title)
                    .frame(
                        maxWidth: .infinity,
                        alignment: .leading)
//                Text("# \(hub.id)")
                VStack {}
                    .frame(width: 100, height: 100)
                    .background {
                        AsyncImage(url: URL(string: hub.image)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        } placeholder: {
                            ProgressView()
                        }
                    }
                    .background(.gray.tertiary)
                    .cornerRadius(10)
            } .padding()
                .frame(maxWidth: .infinity)
                .background(.white)
                .foregroundColor(.black)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
            
        }.padding(.horizontal, 10)
            .frame(maxWidth: .infinity)
            .onTapGesture {
                print("Open Hub")
            }
        
        
    }
}

#Preview {
    HubCardView(hub: Hub(title: "Mega Fifa Hub", users: [], game: "FIFA", authorId: "123", image: "https://hips.hearstapps.com/hmg-prod/images/lionel-messi-celebrates-after-their-sides-third-goal-by-news-photo-1686170172.jpg", id: UUID()))
}
