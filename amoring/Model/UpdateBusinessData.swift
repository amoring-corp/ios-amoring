//
//  UpdateBusinessData.swift
//  amoring
//
//  Created by Sergey Li on 3/7/24.
//

import Foundation
import AmoringAPI

struct UpdateBusinessData {
    var businessInfo: BusinessInfo?
    var business: Business?
    
    var data: InputDict {
        if let business = business {
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
        } else if let business = businessInfo  {
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
