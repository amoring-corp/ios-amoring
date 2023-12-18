//
//  PurchaseSimpleWindow.swift
//  amoring
//
//  Created by 이준녕 on 12/15/23.
//

import SwiftUI

struct PurchaseSimpleWindow: View {
    let title: String = "라운지 확장 패스"
    // FIXME: price from revenue cat
    let price: String = "₩ 10,000"
    let emoji: String
    
    var body: some View {
        VStack(spacing: 0) {
            Text(title)
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
            
            Text(price)
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

#Preview {
    PurchaseSimpleWindow(emoji: "f")
}
