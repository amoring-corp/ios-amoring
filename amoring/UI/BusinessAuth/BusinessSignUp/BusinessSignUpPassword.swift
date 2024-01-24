//
//  BusinessSignUpPassword.swift
//  amoring
//
//  Created by 이준녕 on 1/12/24.
//

import SwiftUI

struct BusinessSignUpPassword: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var controller: BusinessSignUpController
    @EnvironmentObject var sessionManager: SessionManager
    
    @State var goToOTP: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("비밀번호를 설정하세요")
                .font(bold32Font)
                .foregroundColor(.black)
                .padding(.horizontal, Size.w(14))
                .padding(.top, Size.w(56))
                .padding(.bottom, Size.w(10))
            
            Text("보안을 위해 대문자, 소문자, 숫자, 특수문자를 조합하여 8~16자 이내의 비밀번호로 설정해주세요.")
                .font(regular16Font)
                .foregroundColor(.black)
                .padding(.horizontal, Size.w(14))
                .padding(.bottom, Size.w(40))

            Text("비밀번호")
                .font(regular16Font)
                .foregroundColor(.black)
                .padding(.horizontal, Size.w(14))
                .padding(.vertical, Size.w(10))
            CustomSecureField(placeholder: "비밀번호를 설정해주세요.", text: $controller.password)
                .padding(.bottom, Size.w(20))
            
            if controller.password.isStrongPassword() {
                VStack(alignment: .leading, spacing: 0) {
                    Text("비밀번호 확인")
                        .font(regular16Font)
                        .foregroundColor(.black)
                        .padding(.horizontal, Size.w(14))
                        .padding(.vertical, Size.w(10))
                    CustomSecureField(placeholder: "비밀번호를 재입력 해주세요.", text: $controller.confirmPassword)
                }
            } else {
                checkList
            }
            
            Spacer()
            
            NavigationLink(isActive: $goToOTP, destination: {
                BusinessSignUpOTP()
            }) {
                EmptyView()
            }
            
            HStack {
                Button(action: {
                    sessionManager.signUp(email: controller.email, password: controller.password) { success in
                        goToOTP = success
                    }
                }) {
                    BlackButton(title: "다음", enabled: (controller.password == controller.confirmPassword) && controller.password.isStrongPassword(), isLoading: sessionManager.isLoading)
                }
                .disabled(!(controller.password.isStrongPassword()) || (controller.password != controller.confirmPassword))
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.bottom, Size.w(36))
        }
        .animation(.default, value: controller.password)
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
    
    var checkList: some View {
        VStack(alignment: .leading, spacing: Size.w(12)) {
            checkRow(title: "8-16 자의 문자구성", bool: controller.password.count >= 8)
            checkRow(title: "영문 대문자", bool: controller.password.containsUppercase())
            checkRow(title: "영문 소문자", bool: controller.password.containsLowercase())
            checkRow(title: "숫자", bool: controller.password.containsNumbers())
            checkRow(title: "특수문자", bool: controller.password.containsSpecialCharacters())
        }
        .padding(.leading, Size.w(14))
        .animation(.easeOut, value: controller.password)
    }
    
    @ViewBuilder
    func checkRow(title: LocalizedStringKey, bool: Bool) -> some View {
        HStack {
            Image(systemName: "checkmark.circle.fill")
                .resizable()
                .scaledToFit()
                .foregroundStyle(.green200, .green900)
                .frame(width: Size.w(18), height: Size.w(18))
                .opacity(bool ? 1 : 0.3)
            Text(title)
                .foregroundColor(.gray900)
                .font(regular14Font)
                .strikethrough(bool)
        }
    }
    
}

#Preview {
    BusinessSignUpPassword()
}
