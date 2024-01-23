//
//  CoctailToggle.swift
//  amoring
//
//  Created by 이준녕 on 11/30/23.
//

import SwiftUI

struct CoctailToggle: View {
    @EnvironmentObject var purchaseController: PurchaseController
    @Binding var isOn: Bool
//    @State var isOn: Bool = false
    
    var body: some View {
        ZStack(alignment: self.isOn ? .trailing : .leading) {
            self.isOn ?
            LinearGradient(colors: toggleGradient, startPoint: .topTrailing, endPoint: .bottomLeading) :
            LinearGradient(colors: [Color.gray700], startPoint: .topTrailing, endPoint: .bottomLeading)
            
            ZStack {
                Color.gray900
                self.isOn ?
                    Image("ic-heart-empty-rotated")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.yellow200)
                        .frame(width: 15, height: 13)
                :
                    Image("ic-coctail")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.yellow200)
                        .frame(width: 12, height: 14)
                
            }
            .rotationEffect(.degrees(self.isOn ? 180 : 0))
            .frame(width: 30, height: 30)
            .cornerRadius(18)
            .padding(.horizontal, 1)
        }
        .frame(width: 62, height: 32)
        .cornerRadius(18)
        .onTapGesture {
            if purchaseController.amoringCommunityIsOn {
                withAnimation {
                    self.isOn.toggle()
                }
            } else {
                purchaseController.openPurchase(purchaseType: .lounge)
            }
        }
    }
}

#Preview {
    VStack {
//        CoctailToggle()
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.gray1000)
}
