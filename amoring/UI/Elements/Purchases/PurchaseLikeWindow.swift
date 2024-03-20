//
//  PurchaseLikeWindow.swift
//  amoring
//
//  Created by 이준녕 on 12/15/23.
//

import SwiftUI

struct PurchaseLikeWindow: View {
    @Binding var selectedPlan: String
    
    var body: some View {
        HStack(spacing: 0) {
            PurchaseLikePlan(discount: "최소금액", count: "5", price: "₩ 10,000", selectedPlan: $selectedPlan, planId: Constants.products[0])
            PurchaseLikePlan(discount: "25% 할인", count: "10", price: "₩ 15,000", selectedPlan: $selectedPlan, planId: Constants.products[1])
            PurchaseLikePlan(discount: "50% 할인", count: "50", price: "₩ 50,000", selectedPlan: $selectedPlan, planId: Constants.products[2])
        }
        .padding(.top, Size.w(23))
    }
}

struct PurchaseLikePlan: View {
    let discount: String
    let count: String
    let price: String
    
    @Binding var selectedPlan: String
    let planId: String
    
    var body: some View {
        VStack(spacing: 0) {
            Text(discount)
                .font(semiBold18Font)
                .foregroundColor(.white)
                .opacity(selectedPlan == planId ? 1 : 0.4)
                .padding(.vertical, Size.w(12))
                .frame(maxWidth: .infinity)
                .background(Color.black.opacity(selectedPlan == planId ? 1 : 0.1))
                
            (Text(count)
                    .font(bold40Font)
                + Text("개")
                    .font(medium16Font)
            )
            .padding(.top, Size.w(16))
            .padding(.bottom, Size.w(12))
            
            Color.gray1000.opacity(0.2).frame(width: Size.w(16), height: Size.w(2))
                .padding(.bottom, Size.w(12))
            
            Text(price)
                .tracking(-0.5)
                .font(semiBold20Font)
                .padding(.bottom, Size.w(20))
        }
        .background(Color.white.opacity(selectedPlan == planId ? 1 : 0.1))
        .cornerRadius(Size.w(12))
        .shadow(color: Color.black.opacity(selectedPlan == planId ? 0.2 : 0), radius: 15, y: Size.w(40))
        .offset(y: Size.w(selectedPlan == planId ? -21 : 0))
        .onTapGesture {
            withAnimation(.bouncy) {
                selectedPlan = planId
            }
        }
    }
}

#Preview {
    PurchaseLikeWindow(selectedPlan: .constant(Constants.products[1]))
}
