//
//  BusinessSignUpPrepare.swift
//  amoring
//
//  Created by 이준녕 on 1/8/24.
//

import SwiftUI

struct BusinessSignUpPrepare: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var controller: BusinessSignUpController
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("가입 전 준비해주세요")
                .font(bold32Font)
                .foregroundColor(.black)
                .padding(.horizontal, Size.w(14))
                .padding(.top, Size.w(56))
                .padding(.bottom, Size.w(10))
            
            Text("아래의 내용을 미리 준비해두시면\n아주 빠르게 가입을 완료할 수 있어요.")
                .font(regular16Font)
                .foregroundColor(.black)
                .padding(.horizontal, Size.w(14))
                .padding(.bottom, Size.w(40))
           
            
            Text("❶ 인증 가능한 이메일\n❷ 사업자등록증\n❸ 매장의 사진 (최소 3장)")
                .multilineTextAlignment(.leading)
                .lineSpacing(10)
                .font(bold20Font)
                .foregroundColor(.gray1000)
            
            Spacer()
            
            Text("준비되셨으면,\n계속해서 진행해주세요.")
                .font(regular16Font)
                .foregroundColor(.black)
                .multilineTextAlignment(.trailing)
                .lineSpacing(5)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.horizontal, Size.w(14))
                .padding(.bottom, Size.w(30))
            
            HStack {
                NavigationLink(destination: {
                    BusinessSignUpEmail()
                }) {
                    BlackButton(title: "다음", enabled: true)
                }
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.bottom, Size.w(36))
        }
        .padding(.horizontal, Size.w(22))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.yellow300)
        .navigationBarBackButtonHidden()
        .onTapGesture(perform: closeKeyboard)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("")
                    .font(medium20Font)
                    .foregroundColor(.black)
            }
        }
        .navigationBarItems(leading:
            BackButton(action: { presentationMode.wrappedValue.dismiss() })
        )
    }
}

#Preview {
    BusinessSignUpPrepare()
}
