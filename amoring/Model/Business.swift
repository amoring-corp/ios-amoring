//
//  Business.swift
//  amoring
//
//  Created by 이준녕 on 11/22/23.
//

import Foundation
import ApolloAPI
import AmoringAPI

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
