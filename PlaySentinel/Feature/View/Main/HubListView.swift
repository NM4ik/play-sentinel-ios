//
//  HubListView.swift
//  PlaySentinel
//
//  Created by Никита Михайлов on 08.06.2024.
//

import SwiftUI

struct HubListView: View {
    var hubs : [Hub]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
        ScrollView {
            ForEach(hubs, id: \.self) { item in
                HubCardView(hub: item)
                    .padding(.vertical, 5)
            }
        }
    }
}

#Preview {
    HubListView(hubs: [
        Hub(title: "TestHubFirst", users: [], game: "FIFA", authorId: "", image: "https://hips.hearstapps.com/hmg-prod/images/lionel-messi-celebrates-after-their-sides-third-goal-by-news-photo-1686170172.jpg"),
        Hub(title: "TestHubSeond", users: [], game: "FIFA", authorId: "", image: "https://hips.hearstapps.com/hmg-prod/images/lionel-messi-celebrates-after-their-sides-third-goal-by-news-photo-1686170172.jpg"),
        Hub(title: "TestHubThird", users: [], game: "FIFA", authorId: "", image: "https://hips.hearstapps.com/hmg-prod/images/lionel-messi-celebrates-after-their-sides-third-goal-by-news-photo-1686170172.jpg"),
        Hub(title: "TestHubFourth", users: [], game: "FIFA", authorId: "", image: "https://hips.hearstapps.com/hmg-prod/images/lionel-messi-celebrates-after-their-sides-third-goal-by-news-photo-1686170172.jpg"),
        Hub(title: "TestHubFifth", users: [], game: "FIFA", authorId: "", image: "https://hips.hearstapps.com/hmg-prod/images/lionel-messi-celebrates-after-their-sides-third-goal-by-news-photo-1686170172.jpg"),
        Hub(title: "TestHubFifth", users: [], game: "FIFA", authorId: "", image: "https://hips.hearstapps.com/hmg-prod/images/lionel-messi-celebrates-after-their-sides-third-goal-by-news-photo-1686170172.jpg"),
        Hub(title: "TestHubFifth", users: [], game: "FIFA", authorId: "", image: "https://hips.hearstapps.com/hmg-prod/images/lionel-messi-celebrates-after-their-sides-third-goal-by-news-photo-1686170172.jpg"),
        Hub(title: "TestHubFifth", users: [], game: "FIFA", authorId: "", image: "https://hips.hearstapps.com/hmg-prod/images/lionel-messi-celebrates-after-their-sides-third-goal-by-news-photo-1686170172.jpg"),
        Hub(title: "TestHubFifth", users: [], game: "FIFA", authorId: "", image: "https://hips.hearstapps.com/hmg-prod/images/lionel-messi-celebrates-after-their-sides-third-goal-by-news-photo-1686170172.jpg"),
    ])
}
