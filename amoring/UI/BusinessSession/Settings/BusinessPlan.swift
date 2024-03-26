//
//  BusinessPlan.swift
//  amoring
//
//  Created by 이준녕 on 1/25/24.
//

import SwiftUI

struct BusinessPlan: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Text("회원님이 이용중이신 멤버십 플랜과\n청구내역이 나타납니다.")
                .font(regular16Font)
                .foregroundColor(.yellow600)
                .multilineTextAlignment(.center)
                .lineSpacing(5)
                .padding(.horizontal, Size.w(36))
                .padding(.top, Size.w(40))
                .padding(.bottom, Size.w(40))
            
            VStack(alignment: .leading, spacing: Size.w(10)) {
                Text("플랜과 청구내역")
                    .font(regular16Font)
                    .foregroundColor(.black)
                    .padding(.horizontal, Size.w(14))
                
                VStack(spacing: 0) {
                    HStack {
                        Text("플랜")
                        Spacer()
                            // MARK: pass real plan from revenue cat when needed
                        Text("Basic")
                    }
                        .font(regular16Font)
                        .foregroundColor(.yellow900)
                        .padding(.vertical, Size.w(22))
                        .padding(.horizontal, Size.w(20))
                        .frame(maxWidth: .infinity)
                    
                    Color.yellow350.frame(maxWidth: .infinity).frame(height: 1)
                    
                    HStack {
                        Text("월 청구 비용")
                        Spacer()
                            // MARK: pass real price from revenue cat when needed
                        Text("₩ 100,000")
                    }
                        .font(regular16Font)
                        .foregroundColor(.yellow900)
                        .padding(.vertical, Size.w(22))
                        .padding(.horizontal, Size.w(20))
                        .frame(maxWidth: .infinity)
                    
                    Color.yellow350.frame(maxWidth: .infinity).frame(height: 1)
                    
                    HStack {
                        Text("갱신 예정일")
                        Spacer()
                            // MARK: pass real expiration date from revenue cat when needed
                        Text("2024.05.03")
                    }
                        .font(regular16Font)
                        .foregroundColor(.yellow900)
                        .padding(.vertical, Size.w(22))
                        .padding(.horizontal, Size.w(20))
                        .frame(maxWidth: .infinity)
                }
                    .background(RoundedRectangle(cornerRadius: 12).fill(Color.yellow200))
            }
            .padding(.bottom, Size.w(22))
            
            HStack {
                Button(action: {}) {
                    HStack {
                        Image("ic-arrow-out-from-box")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 18, height: 18)
                        Text("취소")
                            .font(regular14Font)
                            .foregroundColor(.yellow800)
                    }
                }
            }
            .padding(.horizontal, Size.w(14))
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.bottom, Size.w(22))
            
            Text("갱신일 최소 하루 전까지 설정 > Apple ID에서 언제든지 취소할 수 있습니다. 취소할 때까지 요금제가 자동 갱신됩니다.")
                .font(medium15Font)
                .foregroundColor(.yellow600)
                .lineSpacing(6)
                .padding(.horizontal, Size.w(16))
            
            Spacer()
        }
        .padding(.horizontal, Size.w(22))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.yellow300)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("멤버십")
                    .font(medium20Font)
                    .foregroundColor(.black)
            }
        }
        .navigationBarItems(leading:
                                BackButton(action: back, color: Color.black)
        )
        
    }
    
    private func back() {
        self.presentationMode.wrappedValue.dismiss()
    }
}

#Preview {
    BusinessPlan()
}
