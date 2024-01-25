//
//  BusinessSettingsCertification.swift
//  amoring
//
//  Created by 이준녕 on 1/25/24.
//

import SwiftUI

struct BusinessSettingsCertification: View {
    @EnvironmentObject var userManager: UserManager
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        let business = userManager.user?.business
        
        VStack(spacing: 0) {
            CustomNavigationView(offset: .constant(400), title: "기본정보", back: { presentationMode.wrappedValue.dismiss() })
            TrackableScrollView(showIndicators: false, contentOffset: .constant(400)) {
                VStack(alignment: .center, spacing: 0) {
                    Text("인증된 정보의 불가피한 수정이 필요하신 경우\n서비스지원 > 문의하기 이용 바랍니다.")
                        .font(regular16Font)
                        .foregroundColor(.yellow600)
                        .lineSpacing(6)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, Size.w(14))
                        .padding(.top, Size.w(40))
                        .padding(.bottom, Size.w(10))
                    
                    DisabledMenuLine(title: "매장명", text: business?.businessName)
                    DisabledMenuLine(title: "대표자명", text: business?.representativeName)
                    DisabledMenuLine(title: "업태", text: business?.businessType)
                    DisabledMenuLine(title: "종목", text: business?.businessIndustry)
                    DisabledMenuLine(title: "주소", text: business?.address)
                    DisabledMenuLine(title: "사업자등록번호", text: business?.registrationNumber)
                    
                    VStack(alignment: .leading, spacing: Size.w(10)) {
                        Text("사업자등록증 첨부")
                            .font(regular16Font)
                            .foregroundColor(.black)
                            .padding(.horizontal, Size.w(14))
                            .padding(.top, Size.w(30))
                        
                        ZStack(alignment: .center) {
                            HStack {
                                Image(systemName: "checkmark.circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: Size.w(32), height: Size.w(32))
                                    .foregroundStyle(.green200, .green900)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(Size.w(10))
                            
                            Text("인증완료")
                                .font(medium18Font)
                                .foregroundColor(.green200)
                                .padding(.vertical, Size.w(16))
                        }
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 12).fill(Color.green800))
                    }
                    
                    Spacer().frame(height: 200)
                }
                .padding(.horizontal, Size.w(22))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            
        }
        .background(Color.yellow300)
        .navigationBarHidden(true)
    }
}

#Preview {
    BusinessSettingsCertification()
}
