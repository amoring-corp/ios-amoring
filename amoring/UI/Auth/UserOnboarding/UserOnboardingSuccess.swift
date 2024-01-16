//
//  UserOnboardingSuccess.swift
//  amoring
//
//  Created by 이준녕 on 11/21/23.
//

import SwiftUI

struct UserOnboardingSuccess: View {
    @EnvironmentObject var sessionManager: SessionManager
    @EnvironmentObject var userManager: UserManager
    @State var animation: Bool = false
    
    var body: some View {
        ZStack(alignment: .top) {
            Circle()
                .fill(Color.black)
                .frame(width: Size.w(160), height: Size.w(160))
                .scaleEffect(animation ? 12 : 1, anchor: .center)
                .padding(.top, Size.w(60))
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        withAnimation(.linear(duration: 1.5)) {
                            animation = true
                        }
                    }
                }
            
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
                
                Text("반갑습니다!")
                    .font(bold32Font)
                    .foregroundColor(animation ? .gray100 : .black)
                    .padding(.horizontal, Size.w(14))
                    .padding(.top, Size.w(30))
                    .padding(.bottom, Size.w(10))
                
                Text("이제 같이 둘러보도록 할까요?")
                    .font(regular16Font)
                    .foregroundColor(animation ? .gray100 : .black)
                    .padding(.horizontal, Size.w(14))
                    .padding(.bottom, Size.w(40))
                
                Spacer()
                
                Button(action: {
                    sessionManager.getCurrentSession(delay: 0)
                }) {
                    FullSizeButton(title: "확인", color: Color.black, bg: .yellow300)
                }
                .padding(.bottom, Size.w(36))
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
