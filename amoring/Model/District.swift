//
//  District.swift
//  amoring
//
//  Created by Sergey Li on 5/8/24.
//

import Foundation
import AmoringAPI

struct District: Equatable {
    let id: String
    let code: String
    let name: String
    let count: Int
    
    init(id: String, code: String, name: String, count: Int) {
        self.id = id
        self.code = code
        self.name = name.localized
        self.count = count
    }
    
    init(districtFragment: DistrictFragment) {
        self.id = districtFragment.id
        self.code = districtFragment.code
        self.name = districtFragment.name
        self.count = districtFragment.count
    }
    
    static var all = District(id: "0", code: "all", name: "전체", count: 0)
    static var other = District(id: "1", code: "other", name: "기타", count: 0)
    static var nearby = District(id: "2", code: "nearby", name: "내 주변", count: 0)
}
