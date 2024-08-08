//
//  CouponDetailsView.swift
//  amoring
//
//  Created by Sergey Li on 4/23/24.
//

import SwiftUI
import AmoringAPI

struct CouponDetailsView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var userManager: UserManager
    @EnvironmentObject var notificationController: NotificationController
    @State var showAlert: Bool = false
    let coupon: UserInfo.ActiveCoupon?
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Color.gray900
                .frame(height: 1)
                .frame(maxWidth: .infinity)
                .padding(.top, 21)
            
            ScrollView(showsIndicators: false) {
                Image("voucher-free-drink")
//                Image(coupon.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 90, height: 90)
                    .padding(.top, 40)
                    .padding(.bottom, 30)
                
                VStack(alignment: .center, spacing: 8) {
                    (Text("아모링") + Text(" | ") + Text(NSLocalizedString(coupon?.coupon.category ?? "", comment: "")))
                        .font(regular18Font)
                        .foregroundColor(.gray600)
                    
                    Text(NSLocalizedString(coupon?.coupon.name ?? "", comment: ""))
                        .font(medium28Font)
                        .foregroundColor(.gray200)
                    
                    let expiredAt = coupon?.expiredAt?.toDate(format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
                    
                    Text("\(expiredAt?.toString(format: nil) ?? "") 까지")
//                    Text("\(coupon.expiredAt) 까지")
//                    Text("\(coupon.expirationDate.toString(format: nil)) 까지")
                        .font(regular18Font)
                        .foregroundColor(.gray600)
                }
                .padding(.bottom, 30)
                
                VStack(spacing: 40) {
                    Text(NSLocalizedString(coupon?.coupon.shortDescription ?? "", comment: ""))
                        .font(regular16Font)
                        .foregroundColor(.gray200)
                        .multilineTextAlignment(.center)
                        .lineSpacing(6)
                    
                    Text(NSLocalizedString(coupon?.coupon.description ?? "", comment: ""))
                        .font(regular16Font)
                        .foregroundColor(.gray600)
                        .multilineTextAlignment(.leading)
                        .lineSpacing(6)
                }
                .padding(.bottom, 100)
                
                YellowBorderButton(title: "쿠폰 사용 하기") {
                    showAlert = true
                }
                .alertPatched(isPresented: $showAlert) {
                    Alert(title: Text("Are you sure you want to use this Coupon?"), primaryButton: .default(Text("Yes"), action: {
                        if let coupon {
                            userManager.useCoupon(id: coupon.id) { error in
                                if let error {
                                    notificationController.setNotification(text: error, type: .error)
                                } else {
                                    withAnimation {
                                        userManager.user?.activeCoupons = []
                                    }
//                                    self.presentationMode.wrappedValue.dismiss()
                                }
                            }
                        }
                    }), secondaryButton: .cancel())
                }
                
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
