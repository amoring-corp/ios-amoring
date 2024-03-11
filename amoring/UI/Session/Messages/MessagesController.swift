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
    @Published var reactions: [Reaction] = Dummy.reactions
    @Published var conversations: [Conversation] = []
    @Published var alertPresented = false
    @Published var selectedConversation: Conversation? = nil
    
    func delete(id: String) {
        withAnimation {
            // TODO: implement removing from backend
            self.conversations.removeAll(where: { $0.id == id })
        }
    }
    
    //TODO: implement this function. Send Conversation to admin
    func report() {
        
    }
}
