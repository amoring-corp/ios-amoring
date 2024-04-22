//
//  MutatingUser.swift
//  amoring
//
//  Created by 이준녕 on 11/22/23.
//

import Foundation
import ApolloAPI
import AmoringAPI

struct MutatingUser: Hashable {
    var id: ID
    var email: String?
    var status: GraphQLEnum<UserStatus>?
    var role: GraphQLEnum<UserRole>?
    var profile: Profile?
    var business: Business?
    var createdAt: Date?
    var updatedAt: Date?
    
    var usedLikesCount: Int = 0
    var maxLikes: Int = 10
    var likesCredit: Int = 0

    var loungePassExpiredAt: Date?
    var invisiblePassExpiredAt: Date?
    var visibleReactionsPassExpiredAt: Date?
    
    
    init(userInfo: UserInfo) {
        self.id = userInfo.id
        self.email = userInfo.email
        self.status = userInfo.status
        self.role = userInfo.role
        self.profile = userInfo.profile == nil ? nil : Profile(profile: userInfo.profile!)
        self.business = userInfo.business == nil ? nil : Business(businessInfo: userInfo.business!)
        self.createdAt = userInfo.createdAt?.toDate(format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
        self.updatedAt = userInfo.updatedAt?.toDate(format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
        
        self.usedLikesCount = userInfo.usedLikesCount
        self.maxLikes = userInfo.maxLikes
        self.likesCredit = userInfo.likesCredit ?? 0
        
        self.loungePassExpiredAt = userInfo.loungePassExpiredAt?.toDate(format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
        self.invisiblePassExpiredAt = userInfo.invisiblePassExpiredAt?.toDate(format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
        self.visibleReactionsPassExpiredAt = userInfo.visibleReactionsPassExpiredAt?.toDate(format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
    }
    
    init(userInfo: ConversationInfo.Participant) {
        self.id = userInfo.id
        self.email = userInfo.email
        self.status = userInfo.status
        self.role = userInfo.role
        self.profile = userInfo.profile == nil ? nil : Profile(profile: userInfo.profile!)
        self.business = nil
        self.createdAt = userInfo.createdAt?.toDate(format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
        self.updatedAt = userInfo.updatedAt?.toDate(format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
    }
    
}
