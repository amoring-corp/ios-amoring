//
//  User.swift
//  amoring
//
//  Created by 이준녕 on 11/22/23.
//

import Foundation
import ApolloAPI

public struct User: Codable, Equatable, Hashable {
    public static func == (lhs: User, rhs: User) -> Bool {
        lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    var id: Int
    
    var name: String?
    var birthYear: Int?
    var age: Int?
    var bio: String?
    var gender: String?
    var height: Int?
    var weight: Int?
    var mbti: mbtiE?
    var education: String?
    
    var pictures: [String]?
    var interests: [Interest]
    var job: String?
    var isOnline: Bool?
    
// TODO: remove me after tests
    var fakeImage: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case birthYear
        case bio
        case gender
        case pictures
        case fakeImage
        case interests
        case height
        case weight
        case mbti
        case job
        case education
        case isOnline
    }
    // FIXME: after deploy 'height'
    var data: InputDict {
        return InputDict([
            "name": name,
            "age": age,
            "birthYear": birthYear,
            "height": height,
            "weight": weight,
            "mbti": mbti?.rawValue,
            "education": education,
            "bio": bio,
            "gender": gender
        ])
    }
}
