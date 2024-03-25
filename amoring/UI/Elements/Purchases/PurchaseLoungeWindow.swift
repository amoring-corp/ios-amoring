//
//  PurchaseLoungeWindow.swift
//  amoring
//
//  Created by 이준녕 on 12/15/23.
//

import SwiftUI

struct PurchaseLoungeWindow: View {
    @EnvironmentObject var purchaseController: PurchaseController
    @State var isOn = false
    @State var timer: Timer? = nil
    
    var body: some View {
        let plan = purchaseController.products.first(where: { $0.id == "lounge_extension_pass" })
        VStack(spacing: 0) {
            Text(plan?.displayName ?? "")
                .font(semiBold18Font)
                .foregroundColor(.white)
                .padding(.vertical, Size.w(12))
                .frame(maxWidth: .infinity)
                .background(Color.black)
                
            CoctailToggle(isOn: $isOn)
                .disabled(true)
                .padding(.vertical, Size.w(20))
                .onAppear {
                    self.timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { _ in
                        withAnimation {
                            isOn.toggle()
                        }
                    }
                }
                .onDisappear {
                    self.timer?.invalidate()
                }
            
            Color.gray300.frame(width: Size.w(16), height: Size.w(2))
                .padding(.bottom, Size.w(20))
            
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

#Preview {
    PurchaseLoungeWindow()
}
