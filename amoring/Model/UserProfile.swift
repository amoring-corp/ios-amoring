//
//  UserProfile.swift
//  amoring
//
//  Created by 이준녕 on 1/26/24.
//

import Foundation
import ApolloAPI
import AmoringAPI

struct UserProfile: Hashable {
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
    var gender: String?
    var images: [UserProfileImage]
    var interests: [Interest]
    var age: Int?
    var createdAt: Date?
    var updatedAt: Date?
    
    func from(data: UserProfilesQuery.Data.UserProfile?) -> UserProfile? {
        if let data {
            var userProfile = UserProfile(id: data.id, images: [], interests: [])
            
            userProfile.name = data.name
            userProfile.birthYear = data.birthYear
            userProfile.age = data.age
            userProfile.height = data.height
            userProfile.weight = data.weight
            userProfile.mbti = data.mbti
            userProfile.education = data.education
            userProfile.occupation = data.occupation
            userProfile.bio = data.bio
            userProfile.gender = data.gender?.rawValue
            userProfile.images = getImages(data.images)
            userProfile.interests = getInterests(data.interests)

            return userProfile
        } else {
            return nil
        }
    }
    
    func getInterests(_ interests: [UserProfilesQuery.Data.UserProfile.Interest?]?) -> [Interest] {
        var inters: [Interest] = []
        guard let interests else { return inters }
            
        for interest in interests {
            let inter = Interest(
                id: interest?.id ?? "", name: interest?.name ?? ""
            )
            inters.append(inter)
        }
        return inters
    }
    
    func getImages(_ images: [UserProfilesQuery.Data.UserProfile.Image?]?) -> [UserProfileImage] {
        var userProfileImages: [UserProfileImage] = []
        guard let images else { return userProfileImages }
            
        for image in images {
            let img = UserProfileImage(
                file: File(url: image?.file.url)
            )
            userProfileImages.append(img)
        }
        return userProfileImages
    }
}

struct UserProfileData {
    let userProfile: UserProfile?
    
    var data: InputDict {
        if let userProfile {
            return InputDict([
                "name": userProfile.name,
//                "age": userProfile.age,
                "birthYear": userProfile.birthYear,
                "height": userProfile.height,
                "weight": userProfile.weight,
                "mbti": userProfile.mbti,
                "education": userProfile.education,
                "occupation": userProfile.occupation,
                "bio": userProfile.bio,
                "gender": userProfile.gender
            ])
        } else {
            return InputDict([:])
        }
    }
}

struct UserProfileImage: Hashable {
    var id: String?
    var profileId: String?
    var field: Int?
    var sort: Int?
    var file: File?
    var createdAt: Date?
    var updatedAt: Date?
}
