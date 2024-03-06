////
////  User.swift
////  amoring
////
////  Created by 이준녕 on 11/22/23.
////
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
    var addressBname: String?
    var addressDetails: String?
    var addressJibun: String?
    var addressSido: String?
    var addressSigungu: String?
    var addressSigunguCode: String?
    var addressSigunguEnglish: String?
    var addressZonecode: String?
    
    var latitude: Double?
    var longitude: Double?
    var representativeTitle: String?
    var representativeName: String?
    var phoneNumber: String?
    var registrationNumber: String?
    var createdAt: Date?
    var updatedAt: Date?
    var bio: String?
    
    var images: [MutatingImage]?
    var businessHours: [BusinessHours]?
    
    var checkedInProfiles: [Profile]?
    
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
    
    init(id: String? = nil, ownerId: String? = nil, businessName: String? = nil, businessType: String? = nil, businessIndustry: String? = nil, businessCategory: String? = nil, address: String? = nil, addressBname: String? = nil, addressDetails: String? = nil, addressJibun: String? = nil, addressSido: String? = nil, addressSigungu: String? = nil, addressSigunguCode: String? = nil, addressSigunguEnglish: String? = nil, addressZonecode: String? = nil, latitude: Double? = nil, longitude: Double? = nil, representativeTitle: String? = nil, representativeName: String? = nil, phoneNumber: String? = nil, registrationNumber: String? = nil, createdAt: Date? = nil, updatedAt: Date? = nil, bio: String? = nil, images: [MutatingImage]? = nil, businessHours: [BusinessHours]? = nil, checkedInProfiles: [Profile]? = nil) {
        self.id = id
        self.ownerId = ownerId
        self.businessName = businessName
        self.businessType = businessType
        self.businessIndustry = businessIndustry
        self.businessCategory = businessCategory
        self.address = address
        self.addressBname = addressBname
        self.addressDetails = addressDetails
        self.addressJibun = addressJibun
        self.addressSido = addressSido
        self.addressSigungu = addressSigungu
        self.addressSigunguCode = addressSigunguCode
        self.addressSigunguEnglish = addressSigunguEnglish
        self.addressZonecode = addressZonecode
        self.latitude = latitude
        self.longitude = longitude
        self.representativeTitle = representativeTitle
        self.representativeName = representativeName
        self.phoneNumber = phoneNumber
        self.registrationNumber = registrationNumber
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.bio = bio
        self.images = images
        self.businessHours = businessHours
        self.checkedInProfiles = checkedInProfiles
    }
    
    init(businessInfo: UserInfo.Business) {
        self.id = businessInfo.id
        self.ownerId = businessInfo.ownerId
        self.businessName = businessInfo.businessName
        self.businessType = businessInfo.businessType
        self.businessIndustry = businessInfo.businessIndustry
        self.businessCategory = businessInfo.businessCategory
        self.address = businessInfo.address
        self.addressBname = businessInfo.addressBname
        self.addressDetails = businessInfo.addressDetails
        self.addressJibun = businessInfo.addressJibun
        self.addressSido = businessInfo.addressSido
        self.addressSigungu = businessInfo.addressSigungu
        self.addressSigunguCode = businessInfo.addressSigunguCode
        self.addressSigunguEnglish = businessInfo.addressSigunguEnglish
        self.addressZonecode = businessInfo.addressZonecode
        self.latitude = businessInfo.latitude
        self.longitude = businessInfo.longitude
        self.representativeTitle = businessInfo.representativeTitle
        self.representativeName = businessInfo.representativeName
        self.phoneNumber = businessInfo.phoneNumber
        self.registrationNumber = businessInfo.registrationNumber
        self.createdAt = businessInfo.createdAt?.toDate(format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
        self.updatedAt = businessInfo.updatedAt?.toDate(format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
        self.bio = businessInfo.bio
        
        self.images = businessInfo.images == nil ? [] : businessInfo.images!.map {
            MutatingImage(image: $0!) }
        self.businessHours = businessInfo.businessHours == nil ? [] : businessInfo.businessHours!.map {
            BusinessHours(data: $0!) }
        self.checkedInProfiles = businessInfo.activeCheckIns.isEmpty ? [] : businessInfo.activeCheckIns.map({ Profile(profile: $0!.profile!) })
    }
    
    init(businessInfo: BusinessInfo) {
        self.id = businessInfo.id
        self.ownerId = businessInfo.ownerId
        self.businessName = businessInfo.businessName
        self.businessType = businessInfo.businessType
        self.businessIndustry = businessInfo.businessIndustry
        self.businessCategory = businessInfo.businessCategory
        self.address = businessInfo.address
        self.addressBname = businessInfo.addressBname
        self.addressDetails = businessInfo.addressDetails
        self.addressJibun = businessInfo.addressJibun
        self.addressSido = businessInfo.addressSido
        self.addressSigungu = businessInfo.addressSigungu
        self.addressSigunguCode = businessInfo.addressSigunguCode
        self.addressSigunguEnglish = businessInfo.addressSigunguEnglish
        self.addressZonecode = businessInfo.addressZonecode
        self.latitude = businessInfo.latitude
        self.longitude = businessInfo.longitude
        self.representativeTitle = businessInfo.representativeTitle
        self.representativeName = businessInfo.representativeName
        self.phoneNumber = businessInfo.phoneNumber
        self.registrationNumber = businessInfo.registrationNumber
        self.createdAt = businessInfo.createdAt?.toDate(format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
        self.updatedAt = businessInfo.updatedAt?.toDate(format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
        self.bio = businessInfo.bio
        
        self.images = businessInfo.images == nil ? [] : businessInfo.images!.map {
            MutatingImage(image: $0!) }
        self.businessHours = businessInfo.businessHours == nil ? [] : businessInfo.businessHours!.map {
            BusinessHours(data: $0!) }
        self.checkedInProfiles = businessInfo.activeCheckIns.isEmpty ? [] : businessInfo.activeCheckIns.map({ Profile(profile: $0!.profile!) })
    }
}

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
    }
}

struct MutatingImage: Hashable {
    var id: String?
    var profileId: String?
    var field: Int?
    var sort: Int?
    var file: File?
    var createdAt: Date?
    var updatedAt: Date?
    
    init(image: UserInfo.Profile.Image) {
        self.id = image.id
        self.file = File(file: image.file)
    }
    
    init(image: ProfileInfo.Image) {
        self.id = image.id
        self.file = File(file: image.file)
    }
    
    init(image: BusinessInfo.Image) {
        self.id = image.id
        self.file = File(file: image.file)
    }
    
    init(image: BusinessInfo.ActiveCheckIn.Profile.Image) {
        self.id = image.id
        self.file = File(file: image.file)
    }
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
    
    init(file: UserInfo.Profile.Image.File) {
        self.url = file.url
    }
    
    init(file: BusinessInfo.Image.File) {
        self.url = file.url
    }
}

struct Interest: Hashable {
    var id: String
    var name: String
    var categoryId: String?
    var category: ProfileInfo.Interest.Category?
    var createdAt: Date?
    var updatedAt: Date?
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
    
    init(inter: ProfileInfo.Interest) {
        self.id = inter.id
        self.name = inter.name ?? ""
        self.categoryId = inter.categoryId
        self.category = inter.category
        self.createdAt = inter.createdAt?.toDate(format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
        self.updatedAt = inter.updatedAt?.toDate(format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
    }
    
    init(inter: BusinessInfo.ActiveCheckIn.Profile.Interest) {
        self.id = inter.id
        self.name = inter.name ?? ""
//        self.categoryId = inter.categoryId
//        self.category = inter.category
//        self.createdAt = inter.createdAt?.toDate(format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
//        self.updatedAt = inter.updatedAt?.toDate(format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
    }
//    static func fromData(data: ConnectInterestsToMyProfileMutation.Data.ConnectInterestsToMyProfile.Interest) -> Interest {
//        return Interest(
//            id: data.id,
//            name: data.name ?? "",
//            categoryId: data.categoryId
//        )
//    }
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

enum DayOfWeek: String, CaseIterable {
    case sunday, monday, tuesday, wednesday, thursday, friday, saturday
    
    static func withLabel(_ label: String) -> DayOfWeek? {
        return self.allCases.first{ "\($0)" == label }
    }
    
    static func byIndex(_ index: Int) -> DayOfWeek {
        switch index {
        case 0: return .sunday
        case 1: return .monday
        case 2: return .tuesday
        case 3: return .wednesday
        case 4: return .thursday
        case 5: return .friday
        default: return .saturday
        }
    }
}

struct BusinessHours: Hashable {
    var day: DayOfWeek
    var openAt: Date
    var closeAt: Date
    
    var data: BusinessHoursInput {
        return BusinessHoursInput(InputDict([
            "day": day.rawValue,
            "openAt": openAt.toHMS(),
            "closeAt": closeAt.toHMS()
        ]))
        
    }
    
    init(day: DayOfWeek, openAt: Date, closeAt: Date) {
        self.day = day
        self.openAt = openAt
        self.closeAt = closeAt
    }
    
    init(data: UserInfo.Business.BusinessHour) {
        self.day = DayOfWeek.withLabel(data.day.rawValue) ?? .sunday
        self.openAt = data.openAt.HMSStringtoDate()
        self.closeAt = data.closeAt.HMSStringtoDate()
    }
    
    init(data: BusinessInfo.BusinessHour) {
        self.day = DayOfWeek.withLabel(data.day.rawValue) ?? .sunday
        self.openAt = data.openAt.HMSStringtoDate()
        self.closeAt = data.closeAt.HMSStringtoDate()
    }
    
}

//
//
//
//struct User: Hashable {
//    var id: String
//    var email: String?
//    var status: UserStatus?
//    var role: UserRole?
//    var profile: Profile?
//    var business: Business?
//    var createdAt: Date?
//    var updatedAt: Date?
//    
//    static func listFromData(_ data: [ConversationsQuery.Data.Conversation.Participant?]) -> [User] {
//        var users: [User] = []
//        for datum in data {
//            if let user: UserInfo = datum?.fragments.userInfo {
//                users.append(user)
//            }
//        }
//        return users
//    }
//    
//    static func listFromData(_ data: [ConversationQuery.Data.Conversation.Participant?]) -> [User] {
//        var users: [User] = []
//        for datum in data {
//            if let datum {
//                let user = User(
//                    id: datum.id,
//                    email: datum.email,
//                    role: getRoleFrom(datum.role),
//                    profile: getProfileForConversation(datum.profile)
//                )
//                users.append(user)
//            }
//        }
//        return users
//    }
//    
//    static func fromData(_ authUser: QueryAuthenticatedUserQuery.Data.AuthenticatedUser) -> User {
//        return User(
//            id: authUser.id,
//            email: authUser.email,
////            status: authUser.status,
//            role: getRoleFrom(authUser.role),
//            profile: getProfilefrom(authUser.profile),
//            business: getBusinessfrom(authUser.business)
////            createdAt: authUser.createdAt,
////            updatedAt: authUser.updatedAt
//        )
//    }
//    
//    static func fromData(_ authUser: SignInWithGoogleMutation.Data.SignInWithGoogle.User) -> User {
//        return User(
//            id: authUser.id,
//            email: authUser.email,
////            status: authUser.status,
//            role: getRoleFrom(authUser.role),
//            profile: getProfilefrom(authUser.profile),
//            business: getBusinessfrom(authUser.business)
////            createdAt: authUser.createdAt,
////            updatedAt: authUser.updatedAt
//        )
//    }
//    
//    
//    static func getRoleFrom(_ role: GraphQLEnum<AmoringAPI.UserRole>?) -> UserRole? {
//        switch role {
//        case .case(let t):
//            switch t {
//            case AmoringAPI.UserRole.admin: return .admin
//            case AmoringAPI.UserRole.user: return .user
//            case AmoringAPI.UserRole.business: return .business
//            }
//            
//        case .unknown(let string):
//            return nil
//        case .none:
//            return nil
//        }
//    }
//    
//    static func getBusinessfrom(_ business: QueryAuthenticatedUserQuery.Data.AuthenticatedUser.Business?) -> Business? {
//        if let business {
//            return Business(
//                id: business.id,
////                ownerId: business.ownerId,
//                businessName: business.businessName,
//                businessType: business.businessType,
//                businessIndustry: business.businessIndustry,
//                businessCategory: business.businessCategory,
//                address: business.address,
//                addressDetails: business.addressDetails,
//                addressSigungu: business.addressSigungu,
//                latitude: business.latitude,
//                longitude: business.longitude,
//                representativeTitle: business.representativeTitle,
//                representativeName: business.representativeName,
//                phoneNumber: business.phoneNumber,
//                registrationNumber: business.registrationNumber,
//                bio: business.bio,
//                images: getImages(business.images),
//                businessHours: getHours(business.businessHours)
////                createdAt: profile.createdAt,
////                updatedAt: profile.updatedAt
//            )
//        } else {
//            return nil
//        }
//    }
//    
//    static func getBusinessfrom(_ business: SignInWithGoogleMutation.Data.SignInWithGoogle.User.Business?) -> Business? {
//        ///        return nil because there shouldn't be any user with Google sign in
//        return nil
//    }
//    
//    static func getProfilefrom(_ profile: QueryAuthenticatedUserQuery.Data.AuthenticatedUser.Profile?) -> Profile? {
//        if let profile {
//            return Profile(
//                id: profile.id,
////                userId: profile.userId,
//                name: profile.name,
//                birthYear: profile.birthYear,
//                height: profile.height,
//                weight: profile.weight,
//                mbti: profile.mbti,
//                education: profile.education,
//                occupation: profile.occupation,
//                bio: profile.bio,
//                gender: profile.gender?.rawValue,
//                images: getImages(profile.images),
//                interests: getInterests(profile.interests),
//                age: profile.age
////                createdAt: profile.createdAt,
////                updatedAt: profile.updatedAt
//            )
//        } else {
//            return nil
//        }
//    }
//    
//    static func getProfilefrom(_ profile: SignInWithGoogleMutation.Data.SignInWithGoogle.User.Profile?) -> Profile? {
//        if let profile {
//            return Profile(
//                id: profile.id,
////                userId: profile.userId,
//                name: profile.name,
//                birthYear: profile.birthYear,
//                height: profile.height,
//                weight: profile.weight,
//                mbti: profile.mbti,
//                education: profile.education,
//                occupation: profile.occupation,
//                bio: profile.bio,
//                gender: profile.gender?.rawValue,
//                images: getImages(profile.images),
//                interests: getInterests(profile.interests),
//                age: profile.age
////                createdAt: profile.createdAt,
////                updatedAt: profile.updatedAt
//            )
//        } else {
//            return nil
//        }
//    }
//    
//    static func getProfileForConversation(_ profile: ConversationsQuery.Data.Conversation.Participant.Profile?) -> Profile? {
//        var img = ProfileImage()
//            
//        if let imageUrl = profile?.images?.first??.file.url {
//            img = ProfileImage(
//                file: File(url: imageUrl)
//            )
//        }
//        
//        if let profile {
//            return Profile(
//                id: profile.id,
//                name: profile.name,
//                images: [img],
//                interests: []
//            )
//        } else {
//            return nil
//        }
//    }
//    
//    static func getProfileForConversation(_ profile: ConversationQuery.Data.Conversation.Participant.Profile?) -> Profile? {
//        
//        if let profile {
//            return Profile(
//                id: profile.id,
//                name: profile.name,
//                images: [],
//                interests: []
//            )
//        } else {
//            return nil
//        }
//    }
//    
//    static func getImages(_ images: [QueryAuthenticatedUserQuery.Data.AuthenticatedUser.Profile.Image?]?) -> [ProfileImage] {
//        var profileImages: [ProfileImage] = []
//        guard let images else { return profileImages }
//            
//        for image in images {
//            let img = ProfileImage(
//                id: image?.id,
//                file: File(url: image?.file.url)
//            )
//            profileImages.append(img)
//        }
//        return profileImages
//    }
//    
//    static func getImages(_ images: [QueryAuthenticatedUserQuery.Data.AuthenticatedUser.Business.Image?]?) -> [BusinessImage] {
//        var businessImages: [BusinessImage] = []
//        guard let images else { return businessImages }
//            
//        for image in images {
//            let img = BusinessImage(
//                id: image?.id,
//                file: File(url: image?.file.url)
//            )
//            businessImages.append(img)
//        }
//        return businessImages
//    }
//    
//    static func getImages(_ images: [SignInWithGoogleMutation.Data.SignInWithGoogle.User.Profile.Image?]?) -> [ProfileImage] {
//        var profileImages: [ProfileImage] = []
//        guard let images else { return profileImages }
//            
//        for image in images {
//            let img = ProfileImage(
//                id: image?.id,
//                file: File(url: image?.file.url)
//            )
//            profileImages.append(img)
//        }
//        return profileImages
//    }
//    
//    static func getInterests(_ interests: [QueryAuthenticatedUserQuery.Data.AuthenticatedUser.Profile.Interest?]?) -> [Interest] {
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
//    static func getInterests(_ interests: [SignInWithGoogleMutation.Data.SignInWithGoogle.User.Profile.Interest?]?) -> [Interest] {
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
//    static func getHours(_ data: [QueryAuthenticatedUserQuery.Data.AuthenticatedUser.Business.BusinessHour?]?) -> [BusinessHours] {
//        var hours: [BusinessHours] = []
//        guard let data else { return hours }
//        for i in data {
//            guard let day = DayOfWeek.withLabel(i?.day.rawValue ?? "") else { return hours }
//            guard let openAt = i?.openAt.HMSStringtoDate() else { return hours }
//            guard let closeAt = i?.closeAt.HMSStringtoDate() else { return hours }
//            
//            let businessHour = BusinessHours(day: day, openAt: openAt, closeAt: closeAt)
//            hours.append(businessHour)
//        }
//        return hours
//    }
//}
//
//enum UserStatus: Hashable {
//    case unverified, active, inactive
//}
//
//enum UserRole: Hashable {
//    case admin, user, business
//}
