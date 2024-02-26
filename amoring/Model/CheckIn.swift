//
//  CheckIn.swift
//  amoring
//
//  Created by 이준녕 on 12/22/23.
//

import Foundation
import AmoringAPI

struct CheckIn {
    var business: Business
    var businessId: String?
    let checkedInAt: Date
    var checkedOutAt: Date?
    var createdAt: Date?
    var id: String?
    var profile: Profile?
    var profileId: String?
    var status: CheckInStatus?
    var updatedAt: Date?
    
    // TODO: parse
    static func fromData(data: UpdateCheckInStatusMutation.Data.UpdateCheckInStatus?) -> CheckIn {
        let business = data?.business
        return CheckIn(business: Business(), checkedInAt: Date())
    }
    // TODO: parse
    static func fromData(data: ActiveCheckInQuery.Data.ActiveCheckIn?) -> CheckIn {
        return CheckIn(business: Business(), checkedInAt: Date())
    }
    
}

enum CheckInStatus {
    case pending, confirmed, rejected
}
