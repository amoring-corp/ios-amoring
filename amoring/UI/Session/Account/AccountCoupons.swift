//
//  AccountCoupons.swift
//  amoring
//
//  Created by Sergey Li on 4/23/24.
//

import SwiftUI

struct AccountCoupons: View {
    @EnvironmentObject var userManager: UserManager
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var listOfCoupons: [String] = ["Coupon 1", "Coupon 2", "Coupon 3"]
    
    var body: some View {
            VStack(spacing: 0) {
//                CustomNavigationView(offset: $contentOffset, title: "쿠폰함", back: { self.presentationMode.wrappedValue.dismiss() }, foregroundColor: Color.yellow300, dividerColor: Color.gray900, bg: Color.gray1000)
                if listOfCoupons.isEmpty {
                    noCoupons()
                } else {
                    ScrollView(showsIndicators: false) {
//                    TrackableScrollView(showIndicators: false, contentOffset: $contentOffset) {
                        VStack(alignment: .leading, spacing: 0) {
                            
                            ForEach(listOfCoupons, id: \.self) { coupon in
                                Text(coupon)
                            }
                        }
                        .padding(.horizontal, Size.w(22))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    .background(Color.gray1000)
                }
            
        }
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
    
    @ViewBuilder
    private func noCoupons() -> some View {
        VStack(spacing: 16) {
            Spacer()
            Image("no-coupons")
                .resizable()
                .scaledToFit()
                .frame(width: 90, height: 90)
            
            Text("쿠폰함이 비어있습니다.")
                .font(medium22Font)
                .foregroundColor(.gray500)
            
            Text("다양한 이벤트에 참여하여 쿠폰을 받으세요.\n유효기간이 만료된 쿠폰은\n자동으로 목록에서 삭제됩니다.")
                .font(regular16Font)
                .foregroundColor(.gray600)
                .multilineTextAlignment(.center)
                .lineSpacing(6)
            Spacer()
        }
    }
}

#Preview {
    AccountCoupons()
}
