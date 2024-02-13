//
//  User.swift
//  amoring
//
//  Created by 이준녕 on 11/22/23.
//

import Foundation
import ApolloAPI
import AmoringAPI

struct User: Hashable {
    var id: String
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
                addressDetails: business.addressDetails,
                addressSigungu: business.addressSigungu,
                latitude: business.latitude,
                longitude: business.longitude,
                representativeTitle: business.representativeTitle,
                representativeName: business.representativeName,
                phoneNumber: business.phoneNumber,
                registrationNumber: business.registrationNumber,
                bio: business.bio,
                images: getImages(business.images),
                businessHours: getHours(business.businessHours)
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
                id: image?.id,
                file: File(url: image?.file.url)
            )
            userProfileImages.append(img)
        }
        return userProfileImages
    }
    
    func getImages(_ images: [QueryAuthenticatedUserQuery.Data.AuthenticatedUser.Business.Image?]?) -> [BusinessImage] {
        var businessImages: [BusinessImage] = []
        guard let images else { return businessImages }
            
        for image in images {
            let img = BusinessImage(
                id: image?.id,
                file: File(url: image?.file.url)
            )
            businessImages.append(img)
        }
        return businessImages
    }
    
    func getImages(_ images: [SignInWithGoogleMutation.Data.SignInWithGoogle.User.UserProfile.Image?]?) -> [UserProfileImage] {
        var userProfileImages: [UserProfileImage] = []
        guard let images else { return userProfileImages }
            
        for image in images {
            let img = UserProfileImage(
                id: image?.id,
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
    
    func getHours(_ data: [QueryAuthenticatedUserQuery.Data.AuthenticatedUser.Business.BusinessHour?]?) -> [BusinessHours] {
        var hours: [BusinessHours] = []
        guard let data else { return hours }
        for i in data {
            guard let day = DayOfWeek.withLabel(i?.day.rawValue ?? "") else { return hours }
            guard let openAt = i?.openAt.HMSStringtoDate() else { return hours }
            guard let closeAt = i?.closeAt.HMSStringtoDate() else { return hours }
            
            let businessHour = BusinessHours(day: day, openAt: openAt, closeAt: closeAt)
            hours.append(businessHour)
        }
        return hours
    }
}

enum UserStatus: Hashable {
    case unverified, active, inactive
}

enum UserRole: Hashable {
    case admin, user, business
}
