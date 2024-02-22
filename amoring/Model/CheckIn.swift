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
    var profile: Profile?
    var status: CheckInStatus?
    
    var userId: String?
    var businessId: String?
//    var place: String?  //??
    let checkedInAt: Date
    var checkedOutAt: Date?
    // TODO: parse
    static func fromData(data: UpdateCheckInStatusMutation.Data.UpdateCheckInStatus?) -> CheckIn {
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
