//
//  BusinessHours.swift
//  amoring
//
//  Created by Sergey Li on 3/7/24.
//

import Foundation
import AmoringAPI

struct BusinessHours: Hashable {
    var day: DayOfWeek
    var openAt: Date
    var closeAt: Date
    
    var data: BusinessHoursInput {
        return BusinessHoursInput(InputDict([
            "day": day.rawValue,
            "openAt": openAt.toHMS(),
            "closeAt": closeAt.toHMS()
        ]))
        
    }
    
    init(day: DayOfWeek, openAt: Date, closeAt: Date) {
        self.day = day
        self.openAt = openAt
        self.closeAt = closeAt
    }
    
    init(data: UserInfo.Business.BusinessHour) {
        self.day = DayOfWeek.withLabel(data.day.rawValue) ?? .sunday
        self.openAt = data.openAt.HMSStringtoDate()
        self.closeAt = data.closeAt.HMSStringtoDate()
    }
    
    init(data: BusinessInfo.BusinessHour) {
        self.day = DayOfWeek.withLabel(data.day.rawValue) ?? .sunday
        self.openAt = data.openAt.HMSStringtoDate()
        self.closeAt = data.closeAt.HMSStringtoDate()
    }
    
}

enum DayOfWeek: String, CaseIterable {
    case sunday, monday, tuesday, wednesday, thursday, friday, saturday
    
    static func withLabel(_ label: String) -> DayOfWeek? {
        return self.allCases.first{ "\($0)" == label }
    }
    
    static func byIndex(_ index: Int) -> DayOfWeek {
        switch index {
        case 0: return .sunday
        case 1: return .monday
        case 2: return .tuesday
        case 3: return .wednesday
        case 4: return .thursday
        case 5: return .friday
        default: return .saturday
        }
    }
}
