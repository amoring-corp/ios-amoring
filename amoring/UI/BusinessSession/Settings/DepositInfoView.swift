//
//  DepositInfoView.swift
//  amoring
//
//  Created by 이준녕 on 2/13/24.
//

import SwiftUI

struct DepositInfoView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @EnvironmentObject var businessSessionController: BusinessSessionController
    @State var animation: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                XButton(action: back)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(height: 44)
            .padding(.horizontal, Size.w(22))

            ZStack {
                HStack(spacing: 0) {
                    ForEach(0..<8) { _ in
                        Text("AMORING")
                            .frame(width: UIScreen.main.bounds.width / 4)
                    }
                }
                .fixedSize(horizontal: true, vertical: false)
                .padding(.vertical, 12)
                .font(semiBold14Font)
                .foregroundColor(.gray1000)
                .background(Color.yellow800)
                .offset(x: animation ? UIScreen.main.bounds.width / 2 : -(UIScreen.main.bounds.width / 2) )
                .onAppear {
                    withAnimation(.linear(duration: 10).repeatForever(autoreverses: false)) {
                        animation = true
                    }
                }
                
                
                Image("LOGO")
                    .resizable()
                    .scaledToFit()
                    .frame(width: Size.w(84), height: Size.w(84))
            }

            .frame(maxWidth: UIScreen.main.bounds.width)
            .clipped()
            .frame(height: Size.w(84))
            .padding(.top, Size.w(25))
            .padding(.bottom, Size.w(23))
            
            Text("비즈니스 멤버십")
                .font(bold28Font)
                .foregroundColor(.gray150)
                .padding(.bottom, Size.w(10))
            
            Text("라운지 확장을 위해서는\n비즈니스 멤버십 구독이 필요합니다.")
                .font(medium14Font)
                .foregroundColor(.gray600)
                .multilineTextAlignment(.center)
//                .padding(.bottom, Size.w(40))
            
            Spacer(minLength: Size.w(20))
            
            VStack(spacing: 0) {
                Text("이용안내")
                    .font(semiBold18Font)
                    .foregroundColor(.black)
                    .padding(.vertical, Size.w(16))
                    .frame(maxWidth: .infinity)
                    .background(Color.yellow200)
                
                Text("보증금이 필요합니다.\n아래의 금액을 입금 후 입금내역을\ntj@amoring.info 로 보내주세요.")
                    .font(medium14Font)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.horizontal, Size.w(20))
                    .padding(.top, Size.w(36))
                    .padding(.bottom, Size.w(26))
                

                HStack {
                    Text("은행명")
                        .font(regular16Font)
                        .foregroundColor(.gray700)
                    Spacer()
                    
                    Text("KB 국민은행")
                        .font(regular16Font)
                        .foregroundColor(.black)
                }
                .padding(.horizontal, Size.w(20))
                .padding(.vertical, Size.w(10))
                
                HStack {
                    Text("예금주")
                        .font(regular16Font)
                        .foregroundColor(.gray700)
                    Spacer()
                    
                    Text("주식회사 아모링")
                        .font(regular16Font)
                        .foregroundColor(.black)
                }
                .padding(.horizontal, Size.w(20))
                .padding(.vertical, Size.w(10))
                
                HStack {
                    Text("계좌번호")
                        .font(regular16Font)
                        .foregroundColor(.gray700)
                    Spacer()
                    
                    Text("102-001128-711")
                        .font(regular16Font)
                        .foregroundColor(.black)
                }
                .padding(.horizontal, Size.w(20))
                .padding(.vertical, Size.w(10))
                
                HStack {
                    Text("보증금")
                        .font(regular16Font)
                        .foregroundColor(.gray700)
                    Spacer()
                    
                    Text("₩ 250,000")
                        .font(bold22Font)
                        .foregroundColor(.black)
                }
                .padding(.horizontal, Size.w(20))
                .padding(.vertical, Size.w(10))
                
                Color.gray200
                    .frame(maxWidth: .infinity)
                    .frame(height: 1)
                    .padding(.vertical, Size.w(10))
                
                VStack(alignment: .leading, spacing: Size.w(10)) {
                    Text("안내사항")
                        .font(semiBold14Font)
                        .foregroundColor(.gray700)
                    Text("보증금은 원활한 서비스 이용을 위한 태블릿 및 광고배너 제공 기반 비용입니다. 서비스 해지 시 보증금은 이용약관에 따라 환급 될 예정입니다.")
                        .font(regular14Font)
                        .foregroundColor(.gray600)
                        .lineSpacing(6)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding(.top, Size.w(12))
                .padding(.horizontal, Size.w(22))
                .padding(.bottom, Size.w(22))
            }
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .padding(.horizontal, Size.w(22))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.gray1000)
    }
    
    private func back() {
        withAnimation {
            businessSessionController.showDepositInfo = false
        }
        self.presentationMode.wrappedValue.dismiss()
    }
}


#Preview {
    DepositInfoView()
}
