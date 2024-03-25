//
//  PurchaseModel.swift
//  amoring
//
//  Created by 이준녕 on 12/15/23.
//

import Foundation

struct PurchaseModel {
    enum type: Int {
        case like = 0
        case lounge
        case transparent
        case list
    }
    
    func id() -> String {
        switch self.type {
        case .like:
            return  "amoring_likes_5"
        case .lounge:
            return "lounge_extension_pass"
        case .transparent:
            return "hidden_mode_pass"
        case .list:
            return "list_view_pass"
        }
    }
    
    let barTitle: String
    let title: String
    var titleImage: String?
    let subtitle: String
    let description: String
    let description2: String
    var description3: String?
    var description4: String?
    let type: type
}
