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
    var address: String?
    var type: String?
    var representative: String?
    var contact: String?
    var number: String?
    var registration: String?
    var images: [String]?
    var terms: Bool?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case address
        case type
        case representative
        case contact
        case number
        case registration
        case images
        case terms
    }
}