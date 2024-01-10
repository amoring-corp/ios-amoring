//
//  Business.swift
//  amoring
//
//  Created by 이준녕 on 11/22/23.
//

import Foundation

public struct Business: Codable, Equatable {
    var id: String?
    var name: String?
    var email: String?
    var address: String?
    var type: String?
    var category: String?
    var representative: String?
    var contact: String?
    var number: String?
    var registration: String?
    var images: [String]?
    var terms: Bool?
    
    var district: String?
    var open: Date?
    var close: Date?
    var description: String?
    var phone: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case email
        case address
        case type
        case category
        case representative
        case contact
        case number
        case registration
        case images
        case terms
        case open
        case close
        case description
        case phone
        case district
    }
}
