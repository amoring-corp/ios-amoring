//
//  MessagesController.swift
//  amoring
//
//  Created by 이준녕 on 12/18/23.
//

import SwiftUI
import AmoringAPI

class MessagesController: ObservableObject {
//    @Published var reactions: [Reaction] = []
    @Published var reactions: [ReactionInfo] = []
    @Published var conversations: [Conversation] = []
    @Published var alertPresented = false
    @Published var selectedConversation: Conversation? = nil
    @Published var goToConversation: Bool = false
    
    func delete(id: String) {
        withAnimation {
            self.conversations.removeAll(where: { $0.id == id })
        }
    }
}
