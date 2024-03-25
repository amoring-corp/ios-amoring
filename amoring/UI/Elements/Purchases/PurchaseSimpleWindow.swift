//
//  PurchaseSimpleWindow.swift
//  amoring
//
//  Created by 이준녕 on 12/15/23.
//

import SwiftUI

struct PurchaseSimpleWindow: View {
    @EnvironmentObject var purchaseController: PurchaseController
    let purchaseType: PurchaseModel.type
    let emoji: String
    
    var body: some View {
        let plan = purchaseController.products.first(where: { $0.id == PurchaseModel.id(type: purchaseType) })
        
        VStack(spacing: 0) {
            Text(plan?.displayName ?? "")
                .font(semiBold18Font)
                .foregroundColor(.white)
                .padding(.vertical, Size.w(12))
                .frame(maxWidth: .infinity)
                .background(Color.black)
                
            Text(emoji)
                .font(bold36Font)
                .padding(.vertical, Size.w(18))
            
            Color.gray300.frame(width: Size.w(16), height: Size.w(2))
                .padding(.bottom, Size.w(18))
            
            Text(plan?.displayPrice ?? "")
                .tracking(-0.5)
                .font(semiBold24Font)
                .padding(.bottom, Size.w(20))
        }
        .background(Color.white)
        .cornerRadius(Size.w(12))
        .shadow(color: Color.black.opacity(0.2), radius: 15, y: Size.w(40))
        .padding(.horizontal, Size.w(19))
        .padding(.bottom, Size.w(16))
    }
}

//#Preview {
//    PurchaseSimpleWindow(emoji: "f")
//}
