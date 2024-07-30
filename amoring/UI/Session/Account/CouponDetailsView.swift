//
//  CouponDetailsView.swift
//  amoring
//
//  Created by Sergey Li on 4/23/24.
//

import SwiftUI

struct CouponDetailsView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let coupon: CouponModel
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Color.gray900
                .frame(height: 1)
                .frame(maxWidth: .infinity)
                .padding(.top, 21)
            
            ScrollView(showsIndicators: false) {
                Image(coupon.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 90, height: 90)
                    .padding(.top, 40)
                    .padding(.bottom, 30)
                
                VStack(alignment: .center, spacing: 8) {
                    Text(NSLocalizedString(coupon.subtitle, comment: ""))
                        .font(regular18Font)
                        .foregroundColor(.gray600)
                    
                    Text(NSLocalizedString(coupon.title, comment: ""))
                        .font(medium28Font)
                        .foregroundColor(.gray200)
                    
                    Text("\(coupon.expirationDate.toString(format: nil)) 까지")
                        .font(regular18Font)
                        .foregroundColor(.gray600)
                }
                .padding(.bottom, 30)
                
                VStack(spacing: 40) {
                    Text(NSLocalizedString(coupon.description, comment: ""))
                        .font(regular16Font)
                        .foregroundColor(.gray200)
                        .multilineTextAlignment(.center)
                        .lineSpacing(6)
                    
                    Text(NSLocalizedString(coupon.body, comment: ""))
                        .font(regular16Font)
                        .foregroundColor(.gray600)
                        .multilineTextAlignment(.leading)
                        .lineSpacing(6)
                }
                .padding(.bottom, 100)
                
                YellowBorderButton(title: "쿠폰 사용 하기") {}
                
                Spacer(minLength: 100)
            }
            .padding(.horizontal, 22)
        }
        .background(Color.gray1000)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("쿠폰함")
                    .font(medium20Font)
                    .foregroundColor(.yellow300)
            }
        }
        .navigationBarItems(leading:
                                BackButton(action: {
            self.presentationMode.wrappedValue.dismiss()
        }, color: Color.yellow300)
        )
    }
}

//#Preview {
//    CouponDetailsView()
//}
