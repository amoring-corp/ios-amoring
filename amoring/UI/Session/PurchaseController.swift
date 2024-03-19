//
//  PurchaseController.swift
//  amoring
//
//  Created by 이준녕 on 12/18/23.
//

import SwiftUI
import StoreKit

class PurchaseController: ObservableObject {
    @Published var purchaseType: PurchaseModel.type? = nil
    
    @Published var purchasedLikes: Int = 1
    @Published var amoringCommunityIsOn: Bool = false
    @Published var isHidden: Bool = false
    @Published var likeListEnabled: Bool = false
    
    @Published var amoringCommunityIsOnTime: Date? = nil
    @Published var isHiddenTime: Date? = nil
    @Published var likeListEnabledTime: Date? = nil
    
    @Published var products: [Product] = []
    @Published var purchasedIDs: [String] = []
    
    func openPurchase(purchaseType: PurchaseModel.type) {
        withAnimation {
            self.purchaseType = purchaseType
        }
    }
    
    func fetchProducts() {
        Task.init(priority: .background) {
            do {
                // TODO: add all products in appstore and here
                let products = try await Product.products(for: ["amoring_likes_5"])
                DispatchQueue.main.async {
                    print("get products: \(products.map({ $0.displayName }))")
                    self.products = products
                }
                
                if let product = products.first {
                    await isPurchased(product: product)
                }
                
            } catch {
                print("There's an error fetching products. \(error.localizedDescription)")
            }
        }
    }
    
    func isPurchased(product: Product) async {
        guard let state = await product.currentEntitlement else { return }
        
        switch state {
        case .verified(let transaction):
            print("isPurchased")
            DispatchQueue.main.async {
                self.purchasedIDs.append(transaction.productID)
            }
        case .unverified(_, _):
            print("is not purchased")
            break
        }
    }
    
    func purchase(_ selectedPlan: Int) {
        Task.init(priority: .background) {
            guard let product = products.first else { return }
            
            do {
                let result = try await product.purchase()
                
                switch result {
                    
                case .success(let verification):
                    switch verification {
                    case .verified(let transaction):
                        DispatchQueue.main.async {
                            self.purchasedIDs.append(transaction.productID)
                            self.onPurchaseSuccess(selectedPlan)
                        }
                    case .unverified(_, _):
                        break
                    }
                case .userCancelled:
                    break
                case .pending:
                    break
                @unknown default:
                    break
                }
            } catch {
                print("There's an error purchasing products. \(error.localizedDescription)")
            }
        }
    }
    
    func onPurchaseSuccess(_ selectedPlan: Int) {
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
