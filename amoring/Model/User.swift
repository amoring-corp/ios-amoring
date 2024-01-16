//
//  User.swift
//  amoring
//
//  Created by 이준녕 on 11/22/23.
//

import Foundation
import ApolloAPI
import AmoringAPI

//public struct User: Codable, Equatable, Hashable {
//    public static func == (lhs: User, rhs: User) -> Bool {
//        lhs.id == rhs.id
//    }
//
//    public func hash(into hasher: inout Hasher) {
//        hasher.combine(id)
//    }
//
//    var id: String
//
//    var name: String?
//    var birthYear: Int?
//    var age: Int?
//    var bio: String?
//    var gender: String?
//    var height: Int?
//    var weight: Int?
//    var mbti: mbtiE?
//    var education: String?
//
//    var pictures: [String]?
//    var interests: [Interest]
//    var job: String?
//    var isOnline: Bool?
//
//// TODO: remove me after tests
//    var fakeImage: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case name
//        case birthYear
//        case bio
//        case gender
//        case pictures
//        case fakeImage
//        case interests
//        case height
//        case weight
//        case mbti
//        case job
//        case education
//        case isOnline
//    }
//    // FIXME: after deploy 'height'
//    var data: InputDict {
//        return InputDict([
//            "name": name,
//            "age": age,
//            "birthYear": birthYear,
//            "height": height,
//            "weight": weight,
//            "mbti": mbti?.rawValue,
//            "education": education,
//            "bio": bio,
//            "gender": gender
//        ])
//    }
//}

struct User: Hashable {
    let id: String
    var email: String?
    var status: UserStatus?
    var role: UserRole?
    var userProfile: UserProfile?
    var business: Business?
    var createdAt: Date?
    var updatedAt: Date?
    
    func from(_ authUser: AmoringAPI.QueryAuthenticatedUserQuery.Data.AuthenticatedUser) -> User {
        return User(
            id: authUser.id,
            email: authUser.email,
//            status: authUser.status,
            role: getRolefrom(authUser.role),
            userProfile: getUserProfilefrom(authUser.userProfile),
            business: getBusinessfrom(authUser.business)
//            createdAt: authUser.createdAt,
//            updatedAt: authUser.updatedAt
        )
    }
    
    func from(_ authUser: SignInWithGoogleMutation.Data.SignInWithGoogle.User) -> User {
        return User(
            id: authUser.id,
            email: authUser.email,
//            status: authUser.status,
            role: getRolefrom(authUser.role),
            userProfile: getUserProfilefrom(authUser.userProfile),
            business: getBusinessfrom(authUser.business)
//            createdAt: authUser.createdAt,
//            updatedAt: authUser.updatedAt
        )
    }
    
    
    func getRolefrom(_ role: GraphQLEnum<AmoringAPI.UserRole>?) -> UserRole? {
        switch role {
        case .case(let t):
            switch t {
            case AmoringAPI.UserRole.admin: return .admin
            case AmoringAPI.UserRole.user: return .user
            case AmoringAPI.UserRole.business: return .business
            }
            
        case .unknown(let string):
            return nil
        case .none:
            return nil
        }
    }
    
    func getBusinessfrom(_ business: QueryAuthenticatedUserQuery.Data.AuthenticatedUser.Business?) -> Business? {
        if let business {
            return Business(
                id: business.id,
//                ownerId: business.ownerId,
                businessName: business.businessName,
                businessType: business.businessType,
                businessIndustry: business.businessIndustry,
                businessCategory: business.businessCategory,
                address: business.address,
                latitude: business.latitude,
                longitude: business.longitude,
                representativeTitle: business.representativeTitle,
                representativeName: business.representativeName,
                phoneNumber: business.phoneNumber,
                registrationNumber: business.registrationNumber,
                bio: business.bio
//                createdAt: profile.createdAt,
//                updatedAt: profile.updatedAt
            )
        } else {
            return nil
        }
    }
    
    func getBusinessfrom(_ business: SignInWithGoogleMutation.Data.SignInWithGoogle.User.Business?) -> Business? {
        ///        return nil because there shouldn't be any user with Google sign in
        return nil
    }
    
    func getUserProfilefrom(_ profile: QueryAuthenticatedUserQuery.Data.AuthenticatedUser.UserProfile?) -> UserProfile? {
        if let profile {
            return UserProfile(
                id: profile.id,
//                userId: profile.userId,
                name: profile.name,
                birthYear: profile.birthYear,
                height: profile.height,
                weight: profile.weight,
                mbti: profile.mbti,
                education: profile.education,
                occupation: profile.occupation,
                bio: profile.bio,
                gender: profile.gender?.rawValue,
                images: getImages(profile.images),
                interests: getInterests(profile.interests),
                age: profile.age
//                createdAt: profile.createdAt,
//                updatedAt: profile.updatedAt
            )
        } else {
            return nil
        }
    }
    
    func getUserProfilefrom(_ profile: SignInWithGoogleMutation.Data.SignInWithGoogle.User.UserProfile?) -> UserProfile? {
        if let profile {
            return UserProfile(
                id: profile.id,
//                userId: profile.userId,
                name: profile.name,
                birthYear: profile.birthYear,
                height: profile.height,
                weight: profile.weight,
                mbti: profile.mbti,
                education: profile.education,
                occupation: profile.occupation,
                bio: profile.bio,
                gender: profile.gender?.rawValue,
                images: getImages(profile.images),
                interests: getInterests(profile.interests),
                age: profile.age
//                createdAt: profile.createdAt,
//                updatedAt: profile.updatedAt
            )
        } else {
            return nil
        }
    }
    
    func getImages(_ images: [QueryAuthenticatedUserQuery.Data.AuthenticatedUser.UserProfile.Image?]?) -> [UserProfileImage] {
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
    
    func getImages(_ images: [SignInWithGoogleMutation.Data.SignInWithGoogle.User.UserProfile.Image?]?) -> [UserProfileImage] {
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
    
    func getInterests(_ interests: [QueryAuthenticatedUserQuery.Data.AuthenticatedUser.UserProfile.Interest?]?) -> [Interest] {
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
    
    func getInterests(_ interests: [SignInWithGoogleMutation.Data.SignInWithGoogle.User.UserProfile.Interest?]?) -> [Interest] {
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
}

enum UserStatus: Hashable {
    case unverified, active, inactive
}

enum UserRole: Hashable {
    case admin, user, business
}

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
}

struct UserProfileData {
    let userProfile: UserProfile?
    
    var data: InputDict {
        if let userProfile {
            return InputDict([
                "name": userProfile.name,
                "age": userProfile.age,
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

struct File: Hashable {
    var id: String?
    var name: String?
    var mimetype: String?
    var url: String?
    var path: String?
    var width: String?
    var height: String?
    var createdAt: Date?
    var updatedAt: Date?
}

struct Interest: Hashable {
    var id: String
    var name: String
    var categoryId: Int?
    var category: InterestCategory?
    var createdAt: Date?
    var updatedAt: Date?
}

struct InterestCategory: Hashable {
    var id: String?
    var name: String
    var interests: [Interest]?
    var createdAt: Date?
    var updatedAt: Date?
}

enum InterestCategoryEnum: String, CaseIterable {
    case interest, music, food, travel, movie, sport
    
    func title() -> String {
        switch self {
        case .interest:
            return "관심사"
        case .music:
            return "음악"
        case .food:
            return "푸드&음료"
        case .travel:
            return "여행"
        case .movie:
            return "영화&소설"
        case .sport:
            return "스포츠"
        }
    }
}

struct Business: Codable, Equatable, Hashable {
    var id: String?
    var ownerId: String?
//    var owner: User?
    var businessName: String?
    ///종목
    var businessType: String?
    ///업태
    var businessIndustry: String?
    var businessCategory: String?
    var address: String?
    var latitude: Double?
    var longitude: Double?
    var representativeTitle: String?
    var representativeName: String?
    var phoneNumber: String?
    var registrationNumber: String?
    var createdAt: Date?
    var updatedAt: Date?
    var bio: String?
    
    //TODO:  synch with backend
    var images: [String]?
    var district: String?
    var open: Date? /// from: String
    var close: Date? /// to: String
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case ownerId
//        case owner
        case businessName
        case businessType
        case businessIndustry
        case businessCategory
        case address
        case latitude
        case longitude
        case representativeTitle
        case representativeName
        case phoneNumber
        case registrationNumber
        case createdAt
        case updatedAt
//        case images
    }
}
