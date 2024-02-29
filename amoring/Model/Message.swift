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
    
    static func listFromData(_ data: [ConversationsQuery.Data.Conversation]) -> [Conversation] {
        var conversations: [Conversation] = []
        for datum in data {
            let conversation = Conversation.fromData(data: datum)
            if let conversation {
                conversations.append(conversation)
            }
        }
        return conversations
    }
    
    static func fromData(data: ConversationsQuery.Data.Conversation?) -> Conversation? {
        if let data {
            let participants = User.listFromData(data.participants)
            let messages = Message.listFromData(data.messages)
            
            return Conversation(id: data.id, participants: participants, messages: messages, createdAt: Date(), archivedAt: nil, updatedAt: nil)
        } else {
            return nil
        }
    }
    
    static func fromData(data: ConversationQuery.Data.Conversation?) -> Conversation? {
        print(data)
        print("abraca 0")
        if let data {
            let participants = User.listFromData(data.participants)
            let messages = Message.listFromData(data.messages)
            
            return Conversation(id: data.id, participants: participants, messages: messages, createdAt: Date(), archivedAt: nil, updatedAt: nil)
        } else {
            return nil
        }
    }
}

struct Message: Hashable {
    static func == (lhs: Message, rhs: Message) -> Bool {
        lhs.id == rhs.id
    }
    
    let id: String
    let body: String
    var sender: User?
    var senderId: String?
    var conversation: Conversation?
    let createdAt: Date?
    var updatedAt: Date?
    
    static func listFromData(_ data: [ConversationsQuery.Data.Conversation.Message?]) -> [Message] {
        var messages: [Message] = []
        for datum in data {
            if let datum {
                let message = Message(
                    id: datum.id,
                    body: datum.body,
                    createdAt: Date()
                )
                messages.append(message)
            }
        }
        return messages
    }
    
    static func listFromData(_ data: [ConversationQuery.Data.Conversation.Message?]) -> [Message] {
        var messages: [Message] = []
        print(data)
        print("abraca")
        for datum in data {
            if let datum {
                let message = Message(
                    id: datum.id,
                    body: datum.body,
                    createdAt: Date()
                )
                messages.append(message)
            }
        }
        return messages
    }
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
