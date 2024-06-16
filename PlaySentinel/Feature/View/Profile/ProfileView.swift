//
//  ProfileView.swift
//  PlaySentinel
//
//  Created by Никита Михайлов on 25.03.2024.
//

import SwiftUI


struct ProfileView: View {
    let user : AppUser?
    
    init(user: AppUser?) {
        print("user - \(String(describing: user))")
        self.user = user
    }
    
    var body: some View {
        VStack {
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
                
                Section {
                    Text("Выйти из аккаунта").foregroundColor(.red).onTapGesture {
                        RootViewModel.instance.logout()
                    }
                }
            }
            .task {
                print("TASK INIT")
                //                try? await profileViewModel.loadCurrentUser()
                //                isLoading = false
            }
            .onAppear {
                print("APPEAR INIT")
            } .background(Color(.systemBackground))
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
            
            //            Text("Выйти из аккаунта").foregroundColor(.red)
            //            Button(action: {
            //                print("qweqwe")
            //            }) {
            //                Text("Выйти из аккаунта")
            //                    .frame(maxWidth: .infinity, maxHeight: 20)
            //                    .padding()
            //                    .background(Color.white)
            //                    .foregroundColor(.red)
            //                    .cornerRadius(10)
            //                    .padding(.horizontal, 20)
            //            }
        }
    }
}

#Preview {
    NavigationStack {
        ProfileView(user: AppUser(id: "123", email: "mockUserMail@mail.com", photo: "https://h5p.org/sites/default/files/h5p/content/1209180/images/file-6113d5f8845dc.jpeg", name: nil))
    }
}
