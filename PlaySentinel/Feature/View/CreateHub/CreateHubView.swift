//
//  CreateHubView.swift
//  PlaySentinel
//
//  Created by Никита Михайлов on 11.05.2024.
//

import SwiftUI

struct SheetView: View {
    @Environment(\.dismiss) var dismiss
    
    init() {
        print("VIEW WAS INITED")
    }
    
    
    
    var body: some View {
        Button("Press to dismiss") {
            dismiss()
        }
        .font(.title)
        .padding()
        .background(.black)
    }
}

struct CreateHubView: View {
    @StateObject private var vm: CreateHubViewModel = CreateHubViewModel()
    @State private var showingSheet = false
    
    var body: some View {
        NavigationView {
            let state = vm.state
            
            if state == .loading {
                LoadingIndicatorView()
                    .frame(width: 70, height: 70)
                    .cornerRadius(15)
            }
            
            else if(state == .loaded) {
                VStack {
                    Form {
                        Section {
                            TextField("Название хаба", text: $vm.hubName)
                            CreateHubGamePicker(games: vm.games, selectedGame: $vm.selectedGame)
                                .padding(.vertical, 10)
                        } footer: {
                            Text("Пожалуйста, заполните все поля.")
                        }
                        .headerProminence(.increased)
                        
                        Section {
                            HStack {
                                Text("Пригласить участников")
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                            .sheet(isPresented: $showingSheet) {
                                PlayersView(selectableIdsState: $vm.selectedUsers).onDisappear() {
                                    print("selectedUser - \(vm.selectedUsers)")
                                }
                            }
                            .onTapGesture {
                                showingSheet.toggle()
                            }
                            
                            
                        }
                    }
                    Spacer()
                    Button("Создать", action: {
                        vm.createHub()
                    })
                    .frame(maxWidth: .infinity, alignment: .center)
                    
                }
            }
            
            else {
                VStack {
                    if state == .noGames {
                        Text("Невозможно созать хаб из-за отсутствия доступных игр.")
                    }
                    
                    if state == .notAvailableToCreateHub {
                        Text("Невозможно созать хаб из-за ограничения количества хабов на одного игрока. Попробуйте удалить один из существующих.")
                    }
                    
                    if state == .error {
                        Text("Произошла ошибка.")
                    }
                }.padding(.horizontal)
            }
            
            
            
            
        }
        
        .navigationTitle("Create Hub")
        .onAppear() {
            Task { @MainActor in
                await vm.reduce(event: .onAppear)
            }
        }
    }
}

#Preview {
    NavigationView {
        CreateHubView()
    }
}
