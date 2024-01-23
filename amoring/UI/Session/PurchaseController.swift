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
        case .transparent:
            self.isHidden = true
        case .list:
            self.likeListEnabled = true
        case nil:
            return
        }
        
        //TODO: buy and close
        withAnimation {
            self.purchaseType = nil
        }
    }
}
