//
//  BusinessSignUpOTP.swift
//  amoring
//
//  Created by 이준녕 on 1/10/24.
//

import SwiftUI

struct BusinessSignUpOTP: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var controller: BusinessSignUpController
    @EnvironmentObject var sessionManager: SessionManager
    
    @State var bordersColor: Color = Color.clear
    @State var error: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("인증코드를 확인하세요")
                .font(bold32Font)
                .foregroundColor(.black)
                .padding(.horizontal, Size.w(14))
                .padding(.top, Size.w(56))
                .padding(.bottom, Size.w(10))
            
            Text("아래의 메일주소로 인증코드가 전송되었습니다.\n\(controller.email)")
                .font(regular16Font)
                .foregroundColor(.black)
                .padding(.horizontal, Size.w(14))
                .padding(.bottom, Size.w(40))
            
            
            CodeInputView(text: $controller.confirmCode, modifierColor: bordersColor)
                .padding(.bottom, Size.w(10))
                .onTapGesture {
                    onTapInput()
                }
                .onChange(of: controller.confirmCode) { _ in
                    onTapInput()
                }
            
            Text(error)
                .font(regular16Font)
                .foregroundColor(.red700)
                .padding(.leading, Size.w(14))
                .padding(.bottom, Size.w(42))
            
            HStack {
                Spacer()
                Button(action: {
                    print("resend OTP code")
                }) {
                    Image("ic-refresh")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.yellow900)
                        .frame(width: Size.w(24), height: Size.w(24))
                    
                    Text("인증코드 재전송")
                        .underline()
                        .font(regular16Font)
                        .foregroundColor(.gray900)
                }
            }
            
            Spacer()
            
            Text("이메일이 수신되지 않은 경우\n메일함 용량 부족 또는 스팸 메일함을 확인해주세요.")
                .font(regular16Font)
                .foregroundColor(.black)
                .multilineTextAlignment(.trailing)
                .lineSpacing(5)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.horizontal, Size.w(14))
                .padding(.bottom, Size.w(30))
            
            HStack {
                Button(action: {
                    signUp()
                }) {
                    NextBlackButton(enabled: !(controller.confirmCode.count < 6 || controller.confirmCode.contains(" ")))
                }
                .disabled((controller.confirmCode.count < 6 || controller.confirmCode.contains(" ")))
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
    
    private func onTapInput() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            withAnimation {
                bordersColor = Color.clear
                self.error = ""
            }
        }
    }
    
    private func signUp() {
        if controller.confirmCode == "123456" {
            DispatchQueue.main.async {
                withAnimation {
                    sessionManager.goToBusinessOnboarding = true
                    sessionManager.businessSignedIn = true
                }
            }
        } else {
            self.bordersColor = Color.red700
            self.error = "인증번호가 일치하지 않습니다."
        }
    }
}

#Preview {
    BusinessSignUpOTP()
}
