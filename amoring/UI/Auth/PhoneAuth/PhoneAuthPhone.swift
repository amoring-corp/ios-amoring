//
//  PhoneAuthPhone.swift
//  amoring
//
//  Created by Sergey Li on 7/20/24.
//

import SwiftUI

struct PhoneAuthPhone: View {
    @StateObject var controller = PhoneAuthController()
    @EnvironmentObject var sessionManager: SessionManager
    @EnvironmentObject var notificationController: NotificationController
    @State var success: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 0) {
                Text("전화번호를 입력하세요")
                    .font(bold32Font)
                    .foregroundColor(.black)
                    .padding(.horizontal, Size.w(14))
                    .padding(.top, Size.w(56))
                    .padding(.bottom, Size.w(10))
                
                Text("먼저, 회원님의 원활한 서비스 이용을 위해\n인증할 휴대폰의 전화번호를 입력해주세요.")
                    .font(regular16Font)
                    .foregroundColor(.black)
                    .padding(.horizontal, Size.w(14))
                    .padding(.bottom, Size.w(40))
                
                CustomTextField(placeholder: "번호를 입력해주세요. (‘-’ 제외)", text: $controller.phone ?? "", keyboardType: .phonePad)
                    .onChange(of: controller.phone ?? "", perform: { newValue in
                        if newValue.count >= 11 && !newValue.contains("+") {
                            controller.phone = String(newValue.prefix(11))
                        } else if newValue.count >= 13 {
                            controller.phone = String(newValue.prefix(13))
                        }
                    })
                
                Spacer()
                
                Text("입력해 주신 번호로 인증번호가 발송됩니다.\n번호가 틀리지 않았는지 확인해주세요.")
                    .font(regular16Font)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.trailing)
                    .lineSpacing(5)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.horizontal, Size.w(14))
                    .padding(.bottom, Size.w(30))
                
                HStack {
                    Button(action: {
                        start()
                    }) {
                        BlackButton(title: "다음", enabled: !(controller.phone?.isEmpty ?? true) && !(controller.phone?.count ?? 0 < 11))
                    }
                    .disabled((controller.phone?.isEmpty ?? true) || (controller.phone?.count ?? 0 < 11))
                    .background(
                        NavigationLink(isActive: $success, destination: {
                            PhoneAuthOtp()
                                .environmentObject(controller)
                        }) {
                            EmptyView()
                        }
                    )
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
                                    Button(action: {
                sessionManager.signOut()
            }) {
                Text("로그아웃")
                    .foregroundColor(.black)
            }
//                                    BackButton(action: sessionManager.signOut)
            )
        }
    }
    
    private func start() {
        if let phone = controller.phone {
            sessionManager.startPhoneNumberVerification(phoneNumber: phone) { error in
                if let error {
                    notificationController.setNotification(text: error, type: .error)
                } else {
                    self.success = true
                }
            }
        }
    }
}

#Preview {
    NavigationView {
        UserOnboardingName().environmentObject(UserOnboardingController())
    }
}

