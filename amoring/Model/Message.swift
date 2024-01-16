//
//  Message.swift
//  amoring
//
//  Created by 이준녕 on 12/19/23.
//

import Foundation


struct Conversation: Hashable {
    static func == (lhs: Conversation, rhs: Conversation) -> Bool {
        lhs.id == rhs.id
    }
    
    let id: String   //@id @default(autoincrement())
    let participants: [User]
    var messages: [Message]
//    let status: ConversationStatus //@default(active)
    let createdAt: Date  //@default(now())
    let archivedAt: Date? //@default(now())
    let updatedAt: Date?  //@default(now())
}


struct Message: Hashable {
    static func == (lhs: Message, rhs: Message) -> Bool {
        lhs.id == rhs.id
    }
    
    let id: Int                //@id @default(autoincrement())
    let body: String
//    let meta: Json?
    let sender: User?              //@relation(fields: [senderId], references: [id])
    let senderId: String?
    var conversation: Conversation?      //@relation(fields: [conversationId], references: [id])
    var conversationId: Int?
    let recipients: [MessageRecipient]
    let createdAt: Date?          //@default(now())
    let updatedAt: Date?          //@default(now()) @updatedAt
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
