//
//  MessagesView.swift
//  amoring
//
//  Created by 이준녕 on 11/20/23.
//

import SwiftUI

struct MessagesView: View {
    @EnvironmentObject var controller: MessagesController
    @EnvironmentObject var userManager: UserManager
    
    @State var torchIsOn = false
    @State var haveTable = false
    @State var resultString: String? = nil
    
    var body: some View {
            VStack(alignment: .center, spacing: 0) {
                if !controller.reactions.isEmpty {
                    NavigationLink(destination: {
                        PeopleLikesView()
                    }) {
                        ListOfPeopleLikesLink()
                    }
                }
                
                ListOfConversations()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(.gray1000)
            .navigationBarTitleDisplayMode(.inline)
     

//            .onChange(of: userManager.newMessage) { newMessage in
//                // MARK: New message from subscription
//                if let newMessage {
//                    if let row = self.controller.conversations.firstIndex(where: { $0.id == newMessage.conversationId }) {
//                        self.controller.conversations[row].messages.insert(Message(messageInfo: newMessage), at: 0)
//                    }
//                }
//            }
    }
}

#Preview {
    CheckInView()
}
