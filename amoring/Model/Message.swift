//
//  Message.swift
//  amoring
//
//  Created by 이준녕 on 12/19/23.
//

import Foundation
import AmoringAPI


struct Conversation: Hashable {
    static func == (lhs: Conversation, rhs: Conversation) -> Bool {
        lhs.id == rhs.id
    }
    
    let id: String
    let participants: [User]
    var messages: [Message]
//    let status: ConversationStatus
    let createdAt: Date
    let archivedAt: Date?
    let updatedAt: Date?
    
//    static func fromData(data: ConversationsQuery.Data.Conversation) -> Conversation {
//        let participants = data.participants.map({ User.fromData(data.participants) })
//        return Conversation(id: data.id, participants: <#T##[User]#>, messages: <#T##[Message]#>, createdAt: <#T##Date#>, archivedAt: <#T##Date?#>, updatedAt: <#T##Date?#>)
//    }
}

struct Message: Hashable {
    static func == (lhs: Message, rhs: Message) -> Bool {
        lhs.id == rhs.id
    }
    
    let id: Int
    let body: String
    let sender: User?
    let senderId: String?
    var conversation: Conversation?
    let createdAt: Date?
    let updatedAt: Date?
}

struct MessageRecipient: Hashable {
    let id: Int    //@id @default(autoincrement())
    let recipientId: Int
    let messageId: Int
//    let status: ConversationStatus //@default(active)
    let createdAt: Date  //@default(now())
    let readdAt: Date? //@default(now())
    let updatedAt: Date?  //@default(now())
}
