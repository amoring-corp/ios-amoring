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
    
    @Published var likes: Int = 10
    @Published var maxLikes: Int = 10
    @Published var purchasedLikes: Int = 1
    @Published var amoringCommunityIsOn: Bool = false
    @Published var isHidden: Bool = false
    @Published var likeListEnabled: Bool = false
    
    @Published var amoringCommunityIsOnTime: Date? = nil
    @Published var isHiddenTime: Date? = nil
    @Published var likeListEnabledTime: Date? = nil
    
    @Published var products: [Product] = []
    @Published var purchasedIDs: [String] = []
    
    @Published var selectedPlan: String = PurchaseController.products[0]
    
    func openPurchase(purchaseType: PurchaseModel.type) {
        switch purchaseType {
        case .like:
            if !self.products.contains(where: { $0.displayName.contains("like") }) {
                return
            }
            self.selectedPlan = PurchaseController.products[1]
        case .lounge:
            if !self.products.contains(where: { $0.id == "lounge_extension_pass" }) {
//                self.sele
                return
            }
            self.selectedPlan = "lounge_extension_pass"
        case .transparent:
            if !self.products.contains(where: { $0.id == "hidden_mode_pass" }) {
                return
            }
            self.selectedPlan = "hidden_mode_pass"
        case .list:
            if !self.products.contains(where: { $0.id == "list_view_pass" }) {
                return
            }
            self.selectedPlan = "list_view_pass"
        }
        withAnimation {
            self.purchaseType = purchaseType
        }
    }
    
    static let products = ["amoring_likes_5", "amoring_likes_10", "amoring_likes_50", "hidden_mode_pass", "lounge_extension_pass", "list_view_pass"]
    
    func fetchProducts() {
        Task.init(priority: .background) {
            do {
                let products = try await Product.products(for: PurchaseController.products)
                DispatchQueue.main.async {
                    print("get products: \(products.map({ $0.id }))")
                    self.products = products
                }
                // MARK: use it for non-consumable products ?
//                if let product = products.first {
//                    await isPurchased(product: product)
//                }
            } catch {
                print("There's an error fetching products. \(error.localizedDescription)")
            }
        }
    }
    
//    func isPurchased(product: Product) async {
//        guard let state = await product.currentEntitlement else { return }
//        
//        switch state {
//        case .verified(let transaction):
//            print("isPurchased")
//            DispatchQueue.main.async {
//                self.purchasedIDs.append(transaction.productID)
//            }
//        case .unverified(_, _):
//            print("is not purchased")
//            break
//        }
//    }
    
    func purchase() {
        Task.init(priority: .background) {
            guard let product = products.first(where: { $0.id == self.selectedPlan }) else { return }
            
            do {
                let result = try await product.purchase()
                
                switch result {
                    
                case .success(let verification):
                    switch verification {
                    case .verified(let transaction):
                        DispatchQueue.main.async {
                            self.purchasedIDs.append(transaction.productID)
                            self.onPurchaseSuccess()
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
    
    // MARK: updating UI after purchase
    // TODO: need to work with backend
    func onPurchaseSuccess() {
        print("purchase...")
        switch purchaseType {
        case .like:
            switch self.selectedPlan {
            case PurchaseController.products[0]: self.purchasedLikes += 5
            case PurchaseController.products[1]: self.purchasedLikes += 10
            case PurchaseController.products[2]: self.purchasedLikes += 50
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
