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
    
    @State var listOfCoupons: [CouponModel] = [
        CouponModel(image: "voucher-free-drink", title: "무료 드링크 교환권", subtitle: "아모링 | 웰컴쿠폰", expirationDate: Date().addingTimeInterval(259200), description: "반가워요 회원님!\n아모링 가맹 매장에서 해당 쿠폰을 제시해주세요.\n환영의 의미로 아모링이 무료로 술 한잔 쏩니다!", body: "유의사항\n• 본 쿠폰은 신규회원에게 1회 지급되는 쿠폰입니다.\n• 다른 쿠폰과 중복사용 불가합니다.\n• 유효기간이 지난 쿠폰은 재발행 되지 않으니 유효기간 내에 사용해 주시기 바랍니다.\n• 쿠폰 사용 하기 버튼을 누르면 사용된 쿠폰은 회수할 수 없습니다. 꼭 매장에서 제시하여 사용해주세요."),
        CouponModel(image: "voucher-free-ticket", title: "무료 입장권", subtitle: "유로포차 | 신규입점", expirationDate: Date().addingTimeInterval(159200), description: "반가워요 회원님!\n아모링 가맹 매장에서 해당 쿠폰을 제시해주세요.\n환영의 의미로 아모링이 무료로 술 한잔 쏩니다!", body: "유의사항\n• 본 쿠폰은 신규회원에게 1회 지급되는 쿠폰입니다.\n• 다른 쿠폰과 중복사용 불가합니다.\n• 유효기간이 지난 쿠폰은 재발행 되지 않으니 유효기간 내에 사용해 주시기 바랍니다.\n• 쿠폰 사용 하기 버튼을 누르면 사용된 쿠폰은 회수할 수 없습니다. 꼭 매장에서 제시하여 사용해주세요."),
        CouponModel(image: "voucher-gift", title: "무료 드링크 교환권", subtitle: "아모링 | 생일쿠폰", expirationDate: Date().addingTimeInterval(9200), description: "반가워요 회원님!\n아모링 가맹 매장에서 해당 쿠폰을 제시해주세요.\n환영의 의미로 아모링이 무료로 술 한잔 쏩니다!", body: "유의사항\n• 본 쿠폰은 신규회원에게 1회 지급되는 쿠폰입니다.\n• 다른 쿠폰과 중복사용 불가합니다.\n• 유효기간이 지난 쿠폰은 재발행 되지 않으니 유효기간 내에 사용해 주시기 바랍니다.\n• 쿠폰 사용 하기 버튼을 누르면 사용된 쿠폰은 회수할 수 없습니다. 꼭 매장에서 제시하여 사용해주세요.")
    ]
    
    var body: some View {
            VStack(spacing: 0) {
//                CustomNavigationView(offset: $contentOffset, title: "쿠폰함", back: { self.presentationMode.wrappedValue.dismiss() }, foregroundColor: Color.yellow300, dividerColor: Color.gray900, bg: Color.gray1000)
                Color.gray900
                    .frame(height: 1)
                    .frame(maxWidth: .infinity)
                    .padding(.top, 21)
                
                if listOfCoupons.isEmpty {
                    noCoupons()
                } else {
                    ScrollView(showsIndicators: false) {
//                    TrackableScrollView(showIndicators: false, contentOffset: $contentOffset) {
                        VStack(alignment: .leading, spacing: 0) {
                            ForEach(listOfCoupons, id: \.self) { coupon in
                                NavigationLink(destination: {
                                    CouponDetailsView(coupon: coupon)
                                }) {
                                    CouponRow(coupon: coupon)
                                }
                            }
                        }
                        .padding(.horizontal, Size.w(22))
                        .padding(.top, 21)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }
            
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
 
    @ViewBuilder
    private func CouponRow(coupon: CouponModel) -> some View {
        HStack(alignment: .center, spacing: 12) {
            Image(coupon.image)
                .resizable()
                .scaledToFit()
                .frame(width: 90, height: 90)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(coupon.subtitle)
                    .font(regular16Font)
                    .foregroundColor(.gray600)
                
                Text(coupon.title)
                    .font(semiBold20Font)
                    .foregroundColor(.gray200)
                
                Text(coupon.expirationDate.toString(format: nil) + " 까지")
                    .font(regular16Font)
                    .foregroundColor(.gray600)
            }
            
            Spacer()
        }
        .padding(.vertical, 11)
    }
}

struct CouponModel: Hashable {
    let image: String
    let title: String
    let subtitle: String
    let expirationDate: Date
    let description: String
    let body: String
}

#Preview {
    AccountCoupons()
}
