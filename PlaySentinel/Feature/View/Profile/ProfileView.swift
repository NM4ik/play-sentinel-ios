//
//  ProfileView.swift
//  PlaySentinel
//
//  Created by Никита Михайлов on 25.03.2024.
//

import SwiftUI


struct ProfileView: View {
    let user : DBUser?
    
    init(user: DBUser?) {
        self.user = user
        print("init lava view")
    }
    
    var body: some View {
        
        ZStack {
            List {
                if user != nil {
                    HStack {
                        AsyncImage(
                            url: URL(string: user?.photo ?? ""
                                    ),
                            content: { image in
                                image.resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .clipShape(.circle)
                            },
                            placeholder: {
                                ProgressView()
                            }
                        )
                        .frame(maxWidth: 30, maxHeight: .infinity)
                        .padding(.trailing, 5)
                        Text("Email: \(user?.email ?? "No data")")
                    }.listRowInsets(EdgeInsets(top: 15, leading: 10, bottom: 15, trailing: 10))
                }
            }
            .task {
                print("TASK INIT")
                //                try? await profileViewModel.loadCurrentUser()
                //                isLoading = false
            }
            .onAppear {
                print("APPEAR INIT")
            }
            //            .toolbar{
            //                ToolbarItem(placement: .navigationBarTrailing, content: {
            //                    NavigationLink {
            //                        SettingsView(showSignInView: $showSignInView)
            //                    } label: {
            //                        Image(systemName: "gear")
            //                            .font(.headline)
            //                    }
            //                })
            //            }
            //
            //            if isLoading {
            //                LoadingIndicatorView()
            //            }
        }
    }
}

#Preview {
    NavigationStack {
        ProfileView(user: DBUser(id: "123", email: "mockUserMail@mail.com", photo: "https://h5p.org/sites/default/files/h5p/content/1209180/images/file-6113d5f8845dc.jpeg"))
    }
}
