//
//  PhoneAuthSuccess.swift
//  amoring
//
//  Created by Sergey Li on 7/20/24.
//

import SwiftUI

struct PhoneAuthSuccess: View {
    @EnvironmentObject var sessionManager: SessionManager
    @EnvironmentObject var userManager: UserManager
    @EnvironmentObject var notificationController: NotificationController
    
    var body: some View {
        ZStack(alignment: .top) {
            Circle()
                .fill(Color.black)
                .frame(width: Size.w(160), height: Size.w(160))
                .scaleEffect(1, anchor: .center)
                .padding(.top, Size.w(60))
            
            VStack(spacing: 20) {
                Circle()
                    .fill(Color.clear)
                    .frame(width: Size.w(160), height: Size.w(160))
                    .overlay(
                        Image("LOGO")
                            .resizable()
                            .scaledToFit()
                            .frame(width: Size.w(85), height: Size.w(72))
                    )
                    .padding(.top, Size.w(60))
                
                Text("확인되었습니다!!")
                    .font(bold32Font)
                    .foregroundColor(.black)
                    .padding(.horizontal, Size.w(14))
                    .padding(.top, Size.w(30))
                    .padding(.bottom, Size.w(10))
                
                Text("이제 회원님에 대해서 알려주세요.")
                    .font(regular16Font)
                    .foregroundColor(.black)
                    .padding(.horizontal, Size.w(14))
                    .padding(.bottom, Size.w(40))
                
                Spacer()
                
                Text("1초뒤 화면이 전환됩니다.")
                    .foregroundColor(.black)
                    .font(regular16Font)
//                Button(action: {
//                    sessionManager.getCurrentSession(delay: 0) { success, error in
//                        notificationController.setNotification(show: !success, text: error, type: .error)
//                    }
//                }) {
//                    FullSizeButton(title: "1초뒤 화면이 전환됩니다.", color: Color.black, bg: .yellow300)
//                }
                .padding(.bottom, Size.w(36))
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation {
                            if userManager.authUser.profile == nil {
                                userManager.userState = .userOnboarding
                            } else {
                                userManager.userState = .session
                            }
                        }
                    }
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                        sessionManager.getCurrentSession(delay: 0) { success, error in
//                            notificationController.setNotification(show: !success, text: error, type: .error)
//                        }
//                    }
                }
            }
            .padding(.horizontal, Size.w(22))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.yellow300)
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    UserOnboardingSuccess().environmentObject(SessionManager())
}

