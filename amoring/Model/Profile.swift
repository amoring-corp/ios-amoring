//
//  Profile.swift
//  amoring
//
//  Created by 이준녕 on 1/26/24.
//

import Foundation
import AmoringAPI

struct Profile: Hashable {
    var id: String
    var userId: String?
    var name: String?
    var birthYear: Int?
    var height: Int?
    var weight: Int?
    var mbti: String?
    var education: String?
    var occupation: String?
    var bio: String?
    var gender: Gender?
    var images: [MutatingImage]
    var interests: [Interest]
    var age: Int?
    var createdAt: Date?
    var updatedAt: Date?
    var avatarUrl: String?
    
    init() {
        self.id = ""
        self.images = []
        self.interests = []
    }
    
    init(profile: UserInfo.Profile) {
        self.id = profile.id
        self.userId = profile.userId
        self.name = profile.name
        self.birthYear = profile.birthYear
        self.height = profile.height
        self.weight = profile.weight
        self.mbti = profile.mbti
        self.education = profile.education
        self.occupation = profile.occupation
        self.bio = profile.bio
        self.gender = profile.gender?.value
        self.images = profile.images == nil ? [] : profile.images!.compactMap{
            MutatingImage(image: $0!)
        }
        self.interests = profile.interests == nil ? [] : profile.interests!.compactMap{ Interest(inter: $0!) }
        self.age = profile.age
        self.createdAt = profile.createdAt?.toDate(format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
        self.updatedAt = profile.updatedAt?.toDate(format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
        self.avatarUrl = profile.avatarUrl
    }
    
    init(profile: ProfileInfo) {
        self.id = profile.id
        self.userId = profile.userId
        self.name = profile.name
        self.birthYear = profile.birthYear
        self.height = profile.height
        self.weight = profile.weight
        self.mbti = profile.mbti
        self.education = profile.education
        self.occupation = profile.occupation
        self.bio = profile.bio
        self.gender = profile.gender?.value
        self.images = profile.images == nil ? [] : profile.images!.compactMap{
            MutatingImage(image: $0!)
        }
        self.interests = profile.interests == nil ? [] : profile.interests!.compactMap{ Interest(inter: $0!) }
        self.age = profile.age
        self.createdAt = profile.createdAt?.toDate(format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
        self.updatedAt = profile.updatedAt?.toDate(format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
        self.avatarUrl = profile.avatarUrl
    }
    
    init(profile: BusinessInfo.ActiveCheckIn.Profile) {
        self.id = profile.id
        self.userId = profile.userId
        self.name = profile.name
        self.birthYear = profile.birthYear
        self.height = profile.height
        self.weight = profile.weight
        self.mbti = profile.mbti
        self.education = profile.education
        self.occupation = profile.occupation
        self.bio = profile.bio
        self.gender = profile.gender?.value
        self.images = profile.images == nil ? [] : profile.images!.compactMap{
            MutatingImage(image: $0!)
        }
        self.interests = profile.interests == nil ? [] : profile.interests!.compactMap{ Interest(inter: $0!) }
        self.age = profile.age
        self.avatarUrl = profile.avatarUrl
    }
    
    init(profile: ConversationInfo.Participant.Profile) {
        self.id = profile.id
        self.userId = profile.userId
        self.name = profile.name
        self.birthYear = profile.birthYear
        self.height = profile.height
        self.weight = profile.weight
        self.mbti = profile.mbti
        self.education = profile.education
        self.occupation = profile.occupation
        self.bio = profile.bio
        self.gender = profile.gender?.value
        self.images = profile.images == nil ? [] : profile.images!.compactMap{
            MutatingImage(image: $0!)
        }
        self.interests = profile.interests == nil ? [] : profile.interests!.compactMap{ Interest(inter: $0!) }
        self.age = profile.age
        self.avatarUrl = profile.avatarUrl
    }
    
}

struct ProfileData {
    var profileInfo: ProfileInfo?
    var profile: Profile?
    
    var data: InputDict {
        if let profile {
            return InputDict([
                "name": profile.name,
//                "age": profile.age,
                "birthYear": profile.birthYear,
                "height": profile.height,
                "weight": profile.weight,
                "mbti": profile.mbti,
                "education": profile.education,
                "occupation": profile.occupation,
                "bio": profile.bio,
                "gender": profile.gender
            ])
        } else if let profileInfo {
            return InputDict([
                "name": profileInfo.name,
//                "age": profileInfo.age,
                "birthYear": profileInfo.birthYear,
                "height": profileInfo.height,
                "weight": profileInfo.weight,
                "mbti": profileInfo.mbti,
                "education": profileInfo.education,
                "occupation": profileInfo.occupation,
                "bio": profileInfo.bio,
                "gender": profileInfo.gender
            ])
        } else {
            return InputDict([:])
        }
    }
}
