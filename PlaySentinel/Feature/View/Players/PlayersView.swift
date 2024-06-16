//
//  PlayersView.swift
//  PlaySentinel
//
//  Created by Никита Михайлов on 16.06.2024.
//

import SwiftUI

struct PlayersView: View {
    @StateObject private var vm : PlayersViewModel = PlayersViewModel()
    @Binding var selectableIdsState: [AppUser]
    @State var selectableIds: [AppUser] = []
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Button("Отменить") {
                    presentationMode.wrappedValue.dismiss()
                }
                
                Spacer()
                
                Button("Выбрать (\(selectableIds.count))") {
                    selectableIdsState = selectableIds
                    presentationMode.wrappedValue.dismiss()
                }
            }.padding(.horizontal)
                .padding(.vertical,10)
            
            contentView()
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity,alignment: .center)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
        .onAppear {
            Task {
                await vm.initData()
            }
        }
    }
    
    
    @ViewBuilder func contentView() -> some View {
        switch vm.state {
        case .error(let error) :
            Text("Произошла ошибка - \(error)")
            
        case .loading :
            ProgressView()
            
        case .noUsers:
            Text("Нет данных об игроках")
            
        case .loaded(let players):
            PlayersListView(users: players, selectableIds: $selectableIds)
        }
        
    }
}

#Preview {
    NavigationStack {
        PlayersView(selectableIdsState: .constant([]))
    }
}
