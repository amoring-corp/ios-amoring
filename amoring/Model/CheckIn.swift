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
    static func fromData(data: UpdateCheckInStatusMutation.Data.UpdateCheckInStatus?) -> CheckIn? {
        if let business = Business.fromData(data: data?.business) {
            // TODO: check and refactor status here
            return CheckIn(business: business, businessId: business.id, checkedInAt: Date(), createdAt: Date(), profileId: data?.profileId, status: CheckInStatus.withLabel(data?.status.rawValue ?? ""))
        } else {
            return nil
        }
    }
    // TODO: parse
    static func fromData(data: ActiveCheckInQuery.Data.ActiveCheckIn?) -> CheckIn? {
        if let business = Business.fromData(data: data?.business) {
            // TODO: check and refactor status here
            return CheckIn(business: business, businessId: business.id, checkedInAt: Date(), createdAt: Date(), profileId: data?.profileId, status: CheckInStatus.withLabel(data?.status.rawValue ?? ""))
        } else {
            return nil
        }
    }
    
}

enum CheckInStatus: String, CaseIterable {
    case pending, confirmed, rejected
    
    static func withLabel(_ label: String) -> CheckInStatus? {
        return self.allCases.first{ "\($0)" == label }
    }
}
