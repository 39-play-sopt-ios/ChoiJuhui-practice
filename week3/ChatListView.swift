//
//  ChatListView.swift
//  SOPT39-Seminar
//
//  Created by h2e on 10/17/26.
//

import SwiftUI

struct ChatListView: View {
    @State private var viewModel = ChatListViewModel()
    
    var body: some View {
        List(viewModel.exampleChat) { message in
            ChatCardView(profile: Image(message.profileImageName), nickname: message.username, text: message.chatcaption, time: message.time)
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 0))
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .background(.white)
    }
}

#Preview {
    ChatListView()
}
