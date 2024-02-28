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
    var activeCheckIns: [CheckIn]
    
    static func fromData(data: UpdateCheckInStatusMutation.Data.UpdateCheckInStatus?) -> CheckIn? {
        if let business = Business.fromData(data: data?.business) {
            return CheckIn(business: business, businessId: business.id, checkedInAt: Date(), createdAt: Date(), profileId: data?.profileId, status: CheckInStatus.confirmed, activeCheckIns: getCheckIns(data: data))
        } else {
            return nil
        }
    }
    
    static func fromData(data: ActiveCheckInQuery.Data.ActiveCheckIn?) -> CheckIn? {
        if let business = Business.fromData(data: data?.business) {
            return CheckIn(business: business, businessId: business.id, checkedInAt: Date(), createdAt: Date(), profileId: data?.profileId, status: CheckInStatus.withLabel(data?.status.rawValue ?? ""), activeCheckIns: getCheckIns(data:  data))
        } else {
            return nil
        }
    }
    
    static func getCheckIns(data: UpdateCheckInStatusMutation.Data.UpdateCheckInStatus?) -> [CheckIn] {
        if let activeCheckIns = data?.business?.activeCheckIns {
            return getCheckIns(activeCheckIns)
        } else {
            return []
        }
    }
    
    static func getCheckIns(data: ActiveCheckInQuery.Data.ActiveCheckIn?) -> [CheckIn] {
        if let activeCheckIns = data?.business?.activeCheckIns {
            return getCheckIns(activeCheckIns)
        } else {
            return []
        }
    }
    
    static func getCheckIns(_ checks: [UpdateCheckInStatusMutation.Data.UpdateCheckInStatus.Business.ActiveCheckIn?]?) -> [CheckIn] {
        var checkIns: [CheckIn] = []
        guard let checks else { return checkIns }
            
        for check in checks {
            let profile = Profile.fromData(data: check?.profile)
            let checkIn = CheckIn(business: Business(), checkedInAt: Date(), profile: profile, activeCheckIns: [])
            
            checkIns.append(checkIn)
        }
        return checkIns
    }
    
    static func getCheckIns(_ checks: [ActiveCheckInQuery.Data.ActiveCheckIn.Business.ActiveCheckIn?]?) -> [CheckIn] {
        var checkIns: [CheckIn] = []
        guard let checks else { return checkIns }
            
        for check in checks {
            let profile = Profile.fromData(data: check?.profile)
            let checkIn = CheckIn(business: Business(), checkedInAt: Date(), profile: profile, activeCheckIns: [])
            
            checkIns.append(checkIn)
        }
        return checkIns
    }
}

enum CheckInStatus: String, CaseIterable {
    case pending, confirmed, rejected
    
    static func withLabel(_ label: String) -> CheckInStatus? {
        return self.allCases.first{ "\($0)" == label }
    }
}
