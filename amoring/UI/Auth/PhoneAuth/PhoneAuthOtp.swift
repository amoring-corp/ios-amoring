//
//  PhoneAuthOtp.swift
//  amoring
//
//  Created by Sergey Li on 7/20/24.
//

import SwiftUI

struct PhoneAuthOtp: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var controller: PhoneAuthController
    @EnvironmentObject var sessionManager: SessionManager
    @EnvironmentObject var notificationController: NotificationController
    
    @State var bordersColor: Color = Color.clear
    @State var error: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("인증번호를 확인하세요")
                .font(bold32Font)
                .foregroundColor(.black)
                .padding(.horizontal, Size.w(14))
                .padding(.top, Size.w(56))
                .padding(.bottom, Size.w(10))
            
            Text("아래의 번호로 인증코드가 전송되었습니다.\n\(controller.phone ?? "")")
                .font(regular16Font)
                .foregroundColor(.black)
                .padding(.horizontal, Size.w(14))
                .padding(.bottom, Size.w(40))
            
            
            CodeInputView(text: $controller.otp, modifierColor: bordersColor)
                .padding(.bottom, Size.w(10))
                .onTapGesture {
                    onTapInput()
                }
                .onChange(of: controller.otp) { _ in
                    onTapInput()
                }
            
            if let confirmationNumber = sessionManager.confirmationNumber {
                Text(confirmationNumber)
                    .font(semiBold18Font)
                    .foregroundColor(.black)
                    .padding(.leading, Size.w(14))
                    .padding(.bottom, Size.w(42))
            }
            
            Text(error)
                .font(regular16Font)
                .foregroundColor(.red700)
                .padding(.leading, Size.w(14))
                .padding(.bottom, Size.w(42))
            
            HStack {
                Spacer()
                Button(action: {
                    // TODO: Implement OTP resending
                }) {
                    Image("ic-refresh")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.yellow900)
                        .frame(width: Size.w(24), height: Size.w(24))
                    
                    Text("인증번호 재전송")
                        .underline()
                        .font(regular16Font)
                        .foregroundColor(.gray900)
                }
            }
            
            Spacer()
            
            Text("인증번호 수신까지 3분 정도 소요될 수 있습니다.\n수신되지 않을 경우 아래 고객센터로 연락주세요.\ncontact@amoring.info")
                .font(regular16Font)
                .foregroundColor(.black)
                .multilineTextAlignment(.trailing)
                .lineSpacing(5)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.horizontal, Size.w(14))
                .padding(.bottom, Size.w(30))
            
            HStack {
//                Button(action: {
                
//                }) {
//                    BlackButton(title: "확인", enabled: !(controller.otp.count < 6 || controller.otp.contains(" ")), isLoading: sessionManager.isLoading)
//                }
//                .disabled((controller.otp.count < 6 || controller.otp.contains(" ")))
                
                // TODO: Implement OTP sending and remove nav link
                NavigationLink(destination: {
                    PhoneAuthSuccess()
                }) {
                    BlackButton(title: "확인", enabled: !(controller.otp.count < 6 || controller.otp.contains(" ")), isLoading: sessionManager.isLoading)
                }
                .disabled((controller.otp.count < 6 || controller.otp.contains(" ")))
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
    
    private func signIn() {
//        sessionManager.verifyEmail(code: controller.otp, email: controller.email, password: controller.password) { success, error in
//            if !success {
//                withAnimation {
//                    notificationController.setNotification(text: error, type: .error)
//                }
//            }
//        }
    }
}

#Preview {
    BusinessSignUpOTP()
}

