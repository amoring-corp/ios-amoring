//
//  PurchaseController.swift
//  amoring
//
//  Created by 이준녕 on 12/18/23.
//

import SwiftUI

class PurchaseController: ObservableObject {
    @Published var purchaseType: PurchaseModel.type? = nil
    
    @Published var purchasedLikes: Int = 1
    @Published var amoringCommunityIsOn: Bool = false
    @Published var isHidden: Bool = false
    @Published var likeListEnabled: Bool = false
    
    @Published var amoringCommunityIsOnTime: Date? = nil
    @Published var isHiddenTime: Date? = nil
    @Published var likeListEnabledTime: Date? = nil
    
    func openPurchase(purchaseType: PurchaseModel.type) {
        withAnimation {
            self.purchaseType = purchaseType
        }
    }
    
    func purchase(_ selectedPlan: Int) {
        print("purchase...")
        switch purchaseType {
        case .like:
            switch selectedPlan {
            case 0: self.purchasedLikes += 5
            case 1: self.purchasedLikes += 10
            case 2: self.purchasedLikes += 50
            default: return
            }
        case .lounge:
            self.amoringCommunityIsOn = true
            amoringCommunityIsOnTime = Date()
        case .transparent:
            self.isHidden = true
            isHiddenTime = Date()
        case .list:
            self.likeListEnabled = true
            likeListEnabledTime = Date()
        case nil:
            return
        }
        
        //TODO: buy and close
        withAnimation {
            self.purchaseType = nil
        }
    }
    
    func communityExpiredTime() -> TimeInterval {
        if let amoringCommunityIsOnTime {
            // MARK: 12 hours - amoringCommunityIsOnTime
            return (amoringCommunityIsOnTime.addingTimeInterval(12 * 60 * 60) - Date())
        } else {
            return 0
        }
    }
    
    func isHiddenExpiredTime() -> TimeInterval {
        if let isHiddenTime {
            // MARK: 12 hours - isHiddenTime
            return (isHiddenTime.addingTimeInterval(12 * 60 * 60) - Date())
        } else {
            return 0
        }
    }
    
    func likeListEnabledExpiredTime() -> TimeInterval {
        if let likeListEnabledTime {
            // MARK: 12 hours - likeListEnabledTime
            return (likeListEnabledTime.addingTimeInterval(12 * 60 * 60) - Date())
        } else {
            return 0
        }
    }
}
