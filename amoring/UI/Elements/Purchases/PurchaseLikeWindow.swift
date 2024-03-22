//
//  PurchaseLikeWindow.swift
//  amoring
//
//  Created by 이준녕 on 12/15/23.
//

import SwiftUI
import StoreKit

struct PurchaseLikeWindow: View {
    @EnvironmentObject var purchaseController: PurchaseController
    @Binding var selectedPlan: String
    
    var body: some View {
        HStack(spacing: 0) {
            let likePlans = purchaseController.products.filter({ $0.id.contains("like") }).sorted{ $0.price < $1.price }
            ForEach(likePlans) { plan in
                PurchaseLikePlan(selectedPlan: $selectedPlan, product: plan)
            }
        }
        .padding(.top, Size.w(23))
    }
}

struct PurchaseLikePlan: View {
    @Binding var selectedPlan: String
    let product: Product
    @State var discount: String = ""
    @State var numberOfLikes: String = ""

    var body: some View {
        VStack(spacing: 0) {
            Text(discount)
                .font(semiBold18Font)
                .foregroundColor(.white)
                .opacity(selectedPlan == product.id ? 1 : 0.4)
                .padding(.vertical, Size.w(12))
                .frame(maxWidth: .infinity)
                .background(Color.black.opacity(selectedPlan == product.id ? 1 : 0.1))
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
        .background(Color.white.opacity(selectedPlan == product.id ? 1 : 0.1))
        .cornerRadius(Size.w(12))
        .shadow(color: Color.black.opacity(selectedPlan == product.id ? 0.2 : 0), radius: 15, y: Size.w(40))
        .offset(y: Size.w(selectedPlan == product.id ? -21 : 0))
        .onTapGesture {
            withAnimation(.bouncy) {
                selectedPlan = product.id
            }
        }
    }
}

#Preview {
    PurchaseLikeWindow(selectedPlan: .constant(PurchaseController.products[1]))
}
