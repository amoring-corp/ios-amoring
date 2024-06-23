//
//  PurchaseLikeWindow.swift
//  amoring
//
//  Created by 이준녕 on 12/15/23.
//

import SwiftUI
import StoreKit

struct PurchaseLikeWindow: View {
    @EnvironmentObject var userManager: UserManager
    
    var body: some View {
        HStack(spacing: 0) {
            let likePlans = userManager.products.filter({ $0.id.contains("like") }).sorted{ $0.price < $1.price }
            ForEach(likePlans) { plan in
                PurchaseLikePlan(product: plan)
            }
        }
        .padding(.top, Size.w(23))
    }
}

struct PurchaseLikePlan: View {
    @EnvironmentObject var userManager: UserManager
    let product: Product
    @State var discount: String = ""
    @State var numberOfLikes: String = ""

    var body: some View {
        VStack(spacing: 0) {
            Text(discount)
                .font(semiBold18Font)
                .foregroundColor(.white)
                .opacity(userManager.selectedPlan.rawValue == product.id ? 1 : 0.4)
                .padding(.vertical, Size.w(12))
                .frame(maxWidth: .infinity)
                .background(Color.black.opacity(userManager.selectedPlan.rawValue == product.id ? 1 : 0.1))
                .onAppear {
                    if let range = product.description.range(of: " / ") {
                        self.discount = String(product.description[range.upperBound...])
                    }
                    self.numberOfLikes = product.description.components(separatedBy: " /")[0]
                }
            
            (Text(numberOfLikes)
                    .font(bold40Font)
                + Text("개")
                    .font(medium16Font)
            )
            .padding(.top, Size.w(16))
            .padding(.bottom, Size.w(12))
            
            Color.gray1000.opacity(0.2).frame(width: Size.w(16), height: Size.w(2))
                .padding(.bottom, Size.w(12))
            
            Text(product.displayPrice)
                .tracking(-0.5)
                .font(semiBold20Font)
                .padding(.bottom, Size.w(20))
        }
        .background(Color.white.opacity(userManager.selectedPlan.rawValue == product.id ? 1 : 0.1))
        .cornerRadius(Size.w(12))
        .shadow(color: Color.black.opacity(userManager.selectedPlan.rawValue == product.id ? 0.2 : 0), radius: 15, y: Size.w(40))
        .offset(y: Size.w(userManager.selectedPlan.rawValue == product.id ? -21 : 0))
        .onTapGesture {
            withAnimation(.bouncy) {
                userManager.selectedPlan = PurchaseProduct(rawValue: product.id) ?? .test_likes_5
            }
        }
    }
}

#Preview {
    PurchaseLikeWindow()
}
