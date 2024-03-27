//
//  Conversation.swift
//  amoring
//
//  Created by 이준녕 on 3/11/24.
//

import Foundation
import AmoringAPI

struct Conversation: Hashable {
    var id: String
    var status: GraphQLEnum<ConversationStatus>?
    var participants: [MutatingUser]
    var checkIns: [CheckInInfo]
    var messages: [Message]
    var createdAt: Date?
    var updatedAt: Date?
    var archivedAt: Date?
    
    init(id: String, status: GraphQLEnum<ConversationStatus>? = nil, participants: [MutatingUser], checkIns: [CheckInInfo], messages: [Message], createdAt: Date? = nil, updatedAt: Date? = nil, archivedAt: Date? = nil) {
        self.id = id
        self.status = status
        self.participants = participants
        self.messages = messages
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.archivedAt = archivedAt
        self.checkIns = checkIns
    }
    
    init(conversationInfo: ConversationInfo) {
        self.id = conversationInfo.id
        self.status = conversationInfo.status
        self.participants = conversationInfo.participants.compactMap({ MutatingUser(userInfo: $0!) })
        self.checkIns = conversationInfo.checkIns.map({ $0!.fragments.checkInInfo })
        self.messages = conversationInfo.messages.compactMap({ Message(messageInfo: $0!) })
        self.createdAt = conversationInfo.createdAt?.toDate(format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
        self.updatedAt = conversationInfo.updatedAt?.toDate(format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
        self.archivedAt = conversationInfo.archivedAt?.toDate(format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
    }
}

struct Message: Hashable {
    var id: String
    var body: String
    var senderId: String?
    var sender: AmoringAPI.UserInfo?
    var conversation: Conversation?
    var createdAt: Date?
    var updatedAt: Date?
    
    init(messageInfo: ConversationInfo.Message) {
        self.id = messageInfo.id
        self.body = messageInfo.body
        self.senderId = messageInfo.senderId
        // FIXME: IF NEEDED
        self.sender = nil
        // FIXME: IF NEEDED
        self.conversation = nil
        self.createdAt = messageInfo.createdAt?.toDate(format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
        self.updatedAt = messageInfo.updatedAt?.toDate(format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
    }
    
    init(messageInfo: MessageInfo) {
        self.id = messageInfo.id
        self.body = messageInfo.body
        self.senderId = messageInfo.senderId
        // FIXME: IF NEEDED
        self.sender = nil
        // FIXME: IF NEEDED
        self.conversation = nil
        self.createdAt = messageInfo.createdAt?.toDate(format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
        self.updatedAt = messageInfo.updatedAt?.toDate(format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
    }
}
