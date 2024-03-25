//
//  PurchaseView.swift
//  amoring
//
//  Created by 이준녕 on 12/15/23.
//

import SwiftUI

struct PurchaseView: View {
    @EnvironmentObject var purchaseController: PurchaseController
    @Binding var purchaseType: PurchaseModel.type?
    let model: PurchaseModel
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                HStack {
                    XButton(action: { self.purchaseType = nil })
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack {
                    Text(model.barTitle)
                }
                .font(bold20Font)
                .foregroundColor(.yellow300)
                .frame(maxWidth: .infinity, alignment: .center)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 44)
            .padding(.horizontal, Size.w(22))
            
            VStack(spacing: 0) {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        HStack(spacing: 0) {
                            if let titleImage = model.titleImage {
                                Image(systemName: titleImage)
                            }
                            Text(model.title)
                        }
                            .font(medium22Font)
                            .foregroundColor(.yellow200)
                            .padding(.horizontal, Size.w(18))
                            .padding(.vertical, Size.w(10))
                            .background(Color.gray1000)
                            .clipShape(Capsule())
                            .padding(.top, Size.w(40))
                        
                        Text(model.subtitle)
                            .font(bold26Font)
                            .lineSpacing(5)
                            .multilineTextAlignment(.center)
                            .padding(.top, Size.w(34))
                        
                        Text(model.description)
                            .font(medium16Font)
                            .lineSpacing(7)
                            .multilineTextAlignment(.center)
                            .padding(.top, Size.w(22))
                        
                        ZStack {
                            switch model.type {
                            case .like:
                                PurchaseLikeWindow()
                            case .lounge:
                                PurchaseLoungeWindow(purchaseType: model.type)
                            case .transparent:
                                PurchaseSimpleWindow(purchaseType: model.type, emoji: "😶‍🌫️")
                            case .list:
                                PurchaseSimpleWindow(purchaseType: model.type, emoji: "🧡👀")
                            }
                        }
                            .padding(.top, Size.w(36))
                        
                        Text(model.description2)
                            .font(medium16Font)
                            .lineSpacing(7)
                            .multilineTextAlignment(.center)
                            .padding(.top, Size.w(42))
                        
                        if let description3 = model.description3 {
                            Text(description3)
                                .font(bold16Font)
                                .multilineTextAlignment(.center)
                                .padding(.top, Size.w(27))
                        }
                        if let description4 = model.description4 {
                            Text(description4)
                                .font(regular14Font)
                                .lineSpacing(8)
                                .multilineTextAlignment(.leading)
                                .padding(.top, Size.w(24))
                        }
                        
                        Spacer().frame(height: 100)
                    }
                    .padding(.horizontal, Size.w(13))
                }
                .frame(maxWidth: .infinity)
                .background(LinearGradient(colors: bg(), startPoint: .topTrailing, endPoint: .bottomLeading))
                Button(action: {
                    purchaseController.purchase()
                }) {
                    Text("구매하기")
                        .font(semiBold22Font)
                        .foregroundColor(.yellow200)
                        .padding(.vertical, Size.w(24))
                        .frame(maxWidth: .infinity)
                }
                .background(Color.black)
                
            }
            .clipShape(RoundedRectangle(cornerRadius: 24))
            .padding(.horizontal, Size.w(10))
            .padding(.top, Size.w(16))
        }
        .foregroundColor(.black)
        .background(Color.gray1000)
//        .onAppear {
//            if let firstPlan = purchaseController.products.map({ $0.id }).first {
//                self.selectedPlan = firstPlan
//            }
//        }
    }
    
    private func bg() -> [Color] {
        switch model.type {
        case .like:
            likeGradient
        case .lounge:
            toggleGradient
        case .transparent:
            transparentGradient
        case .list:
            likeGradient
        }
    }
}

#Preview {
    PurchaseView(purchaseType: .constant(.like), model: purchasesList.first!)
}
