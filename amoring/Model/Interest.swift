//
//  Interest.swift
//  amoring
//
//  Created by 이준녕 on 12/15/23.
//

import Foundation
import ApolloAPI
import AmoringAPI

struct Interest: Hashable {
    var id: String
    var name: String
    var categoryId: String?
    var category: InterestCategory?
    var createdAt: Date?
    var updatedAt: Date?
    
    static func fromData(data: ConnectInterestsToMyProfileMutation.Data.ConnectInterestsToMyProfile.Interest) -> Interest {
        return Interest(
            id: data.id,
            name: data.name ?? "",
            categoryId: data.categoryId
        )
    }
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
