//
//  Interest.swift
//  amoring
//
//  Created by 이준녕 on 12/15/23.
//

import Foundation
import AmoringAPI

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
    
//    init(inter: BusinessInfo.ActiveCheckIn.Profile.Interest) {
//        self.id = inter.id
//        self.name = inter.name ?? ""
//        self.categoryId = inter.categoryId
//        self.category = inter.category
//        self.createdAt = inter.createdAt?.toDate(format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
//        self.updatedAt = inter.updatedAt?.toDate(format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
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
