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
    
    var images: [BusinessImage]?
    var businessHours: [BusinessHours]?
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
    
    func from(data: QueryBusinessesQuery.Data.Business?) -> Business? {
        if let data {
            var business = Business()
            business.id = data.id
            business.businessName = data.businessName
            business.businessCategory = data.businessCategory
            business.address = data.address
            business.phoneNumber = data.phoneNumber
            business.district = "강남"
            business.images = getImages(data.images)
            business.businessHours = getHours(data.businessHours)
            return business
        } else {
            return nil
        }
    }
    
    func getHours(_ data: [QueryBusinessesQuery.Data.Business.BusinessHour?]?) -> [BusinessHours] {
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
    
    func getImages(_ images: [QueryBusinessesQuery.Data.Business.Image?]?) -> [BusinessImage] {
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
}

struct BusinessData {
    let ownerId: Int
    let business: Business?
    
    var data: InputDict {
        if let business {
            return InputDict([
                "ownerId": ownerId,
                "businessName": business.businessName,
                "address": business.address,
                "businessType": business.businessType,
                "businessIndustry": business.businessIndustry,
                "businessCategory": business.businessCategory,
                "representativeTitle": business.representativeTitle,
                "representativeName": business.representativeName,
                "phoneNumber": business.phoneNumber,
                "registrationNumber": business.registrationNumber,
                "bio": business.bio,
                "latitude": business.latitude,
                "longitude": business.longitude,
            ])
        } else {
            return InputDict([:])
        }
    }
}

struct UpdateBusinessData {
    let business: Business?
    
    var data: InputDict {
        if let business {
            return InputDict([
                "businessName": business.businessName,
                "address": business.address,
                "addressBname": business.addressBname,
                "addressDetails": business.addressDetails,
                "addressJibun": business.addressJibun,
                "addressSido": business.addressSido,
                "addressSigungu": business.addressSigungu,
                "addressSigunguCode": business.addressSigunguCode,
                "addressSigunguEnglish": business.addressSigunguEnglish,
                "addressZonecode": business.addressZonecode,
                "businessType": business.businessType,
                "businessIndustry": business.businessIndustry,
                "businessCategory": business.businessCategory,
                "representativeTitle": business.representativeTitle,
                "representativeName": business.representativeName,
                "phoneNumber": business.phoneNumber,
                "registrationNumber": business.registrationNumber,
                "bio": business.bio,
                "latitude": business.latitude,
                "longitude": business.longitude,
            ])
        } else {
            return InputDict([:])
        }
    }
}

struct BusinessImage: Hashable {
    var id: String?
    var businessId: String?
    var field: Int?
    var sort: Int?
    var file: File?
    var createdAt: Date?
    var updatedAt: Date?
}
