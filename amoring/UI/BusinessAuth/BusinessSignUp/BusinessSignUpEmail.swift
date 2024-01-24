//
//  BusinessSignUpEmail.swift
//  amoring
//
//  Created by 이준녕 on 1/10/24.
//

import SwiftUI

struct BusinessSignUpEmail: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var controller: BusinessSignUpController
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("이메일을 입력해주세요")
                .font(bold32Font)
                .foregroundColor(.black)
                .padding(.horizontal, Size.w(14))
                .padding(.top, Size.w(56))
                .padding(.bottom, Size.w(10))
            
            Text("로그인 시 아이디로 사용됩니다.\n인증 코드 확인이 가능한 이메일로 작성해주세요.")
                .font(regular16Font)
                .foregroundColor(.black)
                .padding(.horizontal, Size.w(14))
                .padding(.bottom, Size.w(40))
            
            CustomTextField(placeholder: "이메일을 입력해주세요.", text: $controller.email, keyboardType: .emailAddress)
            
            Spacer()
            
            Text("인증코드 발송 전에\n이메일 주소가 틀리지 않았는지 확인해주세요.")
                .font(regular16Font)
                .foregroundColor(.black)
                .multilineTextAlignment(.trailing)
                .lineSpacing(5)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.horizontal, Size.w(14))
                .padding(.bottom, Size.w(30))
            
            HStack {
                NavigationLink(destination: {
                    BusinessSignUpPassword()
                }) {
                    BlackButton(title: "다음", enabled: controller.email.isEmailValid())
                }
                .disabled(!controller.email.isEmailValid())
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.bottom, Size.w(36))
        }
        .padding(.horizontal, Size.w(22))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.yellow300)
        .onTapGesture(perform: closeKeyboard)
        .navigationBarBackButtonHidden()
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
    BusinessSignUpEmail()
}
