////
////  Profile.swift
////  amoring
////
////  Created by 이준녕 on 1/26/24.
////
//
import Foundation
import AmoringAPI
//import ApolloAPI
//import AmoringAPI
//
//struct Profile: Hashable {
//    var id: String
//    var userId: String?
//    var name: String?
//    var birthYear: Int?
//    var height: Int?
//    var weight: Int?
//    var mbti: String?
//    var education: String?
//    var occupation: String?
//    var bio: String?
//    var gender: String?
//    var images: [ProfileImage]
//    var interests: [Interest]
//    var age: Int?
//    var createdAt: Date?
//    var updatedAt: Date?
//    
//    static func fromData(data: ProfilesQuery.Data.Profile?) -> Profile? {
//        if let data {
//            var profile = Profile(id: data.id, images: [], interests: [])
//            
//            profile.name = data.name
//            profile.birthYear = data.birthYear
//            profile.age = data.age
//            profile.height = data.height
//            profile.weight = data.weight
//            profile.mbti = data.mbti
//            profile.education = data.education
//            profile.occupation = data.occupation
//            profile.bio = data.bio
//            profile.gender = data.gender?.rawValue
//            profile.images = Profile.getImages(data.images)
//            profile.interests = getInterests(data.interests)
//
//            return profile
//        } else {
//            return nil
//        }
//    }
//    
//    static func fromData(data: UpdateCheckInStatusMutation.Data.UpdateCheckInStatus.Business.ActiveCheckIn.Profile?) -> Profile? {
//        if let data {
//            var profile = Profile(id: data.id, images: [], interests: [])
//            
//            profile.name = data.name
//            profile.birthYear = data.birthYear
//            profile.age = data.age
//            profile.height = data.height
//            profile.weight = data.weight
//            profile.mbti = data.mbti
//            profile.education = data.education
//            profile.occupation = data.occupation
//            profile.bio = data.bio
//            profile.gender = data.gender?.rawValue
//            profile.images = Profile.getImages(data.images)
//            profile.interests = getInterests(data.interests)
//
//            return profile
//        } else {
//            return nil
//        }
//    }
//    
//    static func fromData(data: ActiveCheckInQuery.Data.ActiveCheckIn.Business.ActiveCheckIn.Profile?) -> Profile? {
//        if let data {
//            var profile = Profile(id: data.id, images: [], interests: [])
//            
//            profile.name = data.name
//            profile.birthYear = data.birthYear
//            profile.age = data.age
//            profile.height = data.height
//            profile.weight = data.weight
//            profile.mbti = data.mbti
//            profile.education = data.education
//            profile.occupation = data.occupation
//            profile.bio = data.bio
//            profile.gender = data.gender?.rawValue
//            profile.images = Profile.getImages(data.images)
//            profile.interests = getInterests(data.interests)
//
//            return profile
//        } else {
//            return nil
//        }
//    }
//    
//    static func getInterests(_ interests: [ProfilesQuery.Data.Profile.Interest?]?) -> [Interest] {
//        var inters: [Interest] = []
//        guard let interests else { return inters }
//            
//        for interest in interests {
//            let inter = Interest(
//                id: interest?.id ?? "", name: interest?.name ?? ""
//            )
//            inters.append(inter)
//        }
//        return inters
//    }
//    
//    static func getInterests(_ interests: [UpdateCheckInStatusMutation.Data.UpdateCheckInStatus.Business.ActiveCheckIn.Profile.Interest?]?) -> [Interest] {
//        var inters: [Interest] = []
//        guard let interests else { return inters }
//            
//        for interest in interests {
//            let inter = Interest(
//                id: interest?.id ?? "", name: interest?.name ?? ""
//            )
//            inters.append(inter)
//        }
//        return inters
//    }
//    
//    static func getInterests(_ interests: [ActiveCheckInQuery.Data.ActiveCheckIn.Business.ActiveCheckIn.Profile.Interest?]?) -> [Interest] {
//        var inters: [Interest] = []
//        guard let interests else { return inters }
//            
//        for interest in interests {
//            let inter = Interest(
//                id: interest?.id ?? "", name: interest?.name ?? ""
//            )
//            inters.append(inter)
//        }
//        return inters
//    }
//    
//    static func getImages(_ images: [ProfilesQuery.Data.Profile.Image?]?) -> [ProfileImage] {
//        var profileImages: [ProfileImage] = []
//        guard let images else { return profileImages }
//            
//        for image in images {
//            let img = ProfileImage(
//                file: File(url: image?.file.url)
//            )
//            profileImages.append(img)
//        }
//        return profileImages
//    }
//    
//    static func getImages(_ images: [UpdateCheckInStatusMutation.Data.UpdateCheckInStatus.Business.ActiveCheckIn.Profile.Image?]?) -> [ProfileImage] {
//        var profileImages: [ProfileImage] = []
//        guard let images else { return profileImages }
//            
//        for image in images {
//            let img = ProfileImage(
//                file: File(url: image?.file.url)
//            )
//            profileImages.append(img)
//        }
//        return profileImages
//    }
//    
//    static func getImages(_ images: [ActiveCheckInQuery.Data.ActiveCheckIn.Business.ActiveCheckIn.Profile.Image?]?) -> [ProfileImage] {
//        var profileImages: [ProfileImage] = []
//        guard let images else { return profileImages }
//            
//        for image in images {
//            let img = ProfileImage(
//                file: File(url: image?.file.url)
//            )
//            profileImages.append(img)
//        }
//        return profileImages
//    }
//}
//
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
//
//struct ProfileImage: Hashable {
//    var id: String?
//    var profileId: String?
//    var field: Int?
//    var sort: Int?
//    var file: File?
//    var createdAt: Date?
//    var updatedAt: Date?
//}
//

