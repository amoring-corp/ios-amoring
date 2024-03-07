//
//  MutatingUser.swift
//  amoring
//
//  Created by 이준녕 on 11/22/23.
//

import Foundation
import ApolloAPI
import AmoringAPI

struct MutatingUser {
    var id: ID
    var email: String?
    var status: GraphQLEnum<UserStatus>?
    var role: GraphQLEnum<UserRole>?
    var profile: Profile?
    var business: Business?
    var createdAt: Date?
    var updatedAt: Date?
    
    init(userInfo: UserInfo) {
        self.id = userInfo.id
        self.email = userInfo.email
        self.status = userInfo.status
        self.role = userInfo.role
        self.profile = userInfo.profile == nil ? nil : Profile(profile: userInfo.profile!)
        self.business = userInfo.business == nil ? nil : Business(businessInfo: userInfo.business!)
        self.createdAt = userInfo.createdAt?.toDate(format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
        self.updatedAt = userInfo.updatedAt?.toDate(format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
    }
}
