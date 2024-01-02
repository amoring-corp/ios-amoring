//
//  SignInSheet.swift
//  amoring
//
//  Created by 이준녕 on 12/29/23.
//

import SwiftUI

struct SignInSheet: View {
    @EnvironmentObject var sessionManager: SessionManager
    @EnvironmentObject var navigator: NavigationAuthController
    @Binding var goToUserOnboarding: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Spacer()
            VStack(alignment: .center, spacing: 0) {
                Text("시작하기")
                    .font(bold28Font)
                    .foregroundColor(.gray150)
                    .padding(.top, Size.w(40))
                    .padding(.bottom, Size.w(10))
                
                Text("간편하게 SNS로 빠르게 시작해보세요!")
                    .font(medium14Font)
                    .foregroundColor(.gray600)
                    .padding(.bottom, Size.w(40))
                
                
                // TODO: get user from db if exists and skip useronboarding part else go to userOnboarding
                
                HStack {
                    Image("SNS-google")
                        .resizable()
                        .scaledToFit()
                        .onTapGesture {
                            sessionManager.signInWithGoogle()
                        }
                    Spacer().frame(maxWidth: Size.w(20))
                    Image("SNS-apple")
                        .resizable()
                        .scaledToFit()
                        .onTapGesture {
                            sessionManager.signInWithApple()
                        }
//                    Spacer().frame(maxWidth: Size.w(20))
//                    Image("SNS-facebook")
//                        .resizable()
//                        .scaledToFit()
//                    Spacer().frame(maxWidth: Size.w(20))
//                    Image("SNS-naver")
//                        .resizable()
//                        .scaledToFit()
                    Spacer().frame(maxWidth: Size.w(20))
                    Image("SNS-kakao")
                        .resizable()
                        .scaledToFit()
                        .onTapGesture {
                            sessionManager.signInWithKakao()
                        }
                }
                .frame(maxWidth: UIScreen.main.bounds.width - Size.w(60), maxHeight: Size.w(54))
                
                (Text("가입함으로써, 귀하는 당사의 ") + 
                 Text("이용약관").underline() +
                 Text("에 동의하게됩니다.\n당사의 개인정보 사용방식에 관한 내용은 ") +
                 Text("개인정보 취급방침").underline() +
                 Text("에서\n확인하실 수 있습니다."))
                    .font(light12Font)
                    .foregroundColor(.gray600)
                    .multilineTextAlignment(.center)
                    .lineSpacing(6)
                    .padding(.top, Size.w(50))
                    .padding(.bottom, Size.w(42))
                    .padding(.horizontal, Size.w(36))
                    .fixedSize(horizontal: false, vertical: true)
                
                HStack {
                    Button(action: {
                        navigator.toBusinessSignUp()
                    }) {
                        Text("비즈니스 가입 ")
                    }
                    
                    
                    Text("  |  ")
                    
                    Button(action: {
                        navigator.toBusinessSignIn()
                    }) {
                        Text("비즈니스 로그인")
                    }
                }
                .font(medium16Font)
                .foregroundColor(.gray600)
                .padding(.bottom, Size.w(48))
                
                //                    Button(action: goNext) {
                //                        Text("Facebook")
                //                    }
                //                    ThirdPartyProvider.shared.googleButton()
                //                    ThirdPartyProvider.shared.appleButton()
                //
                //                    HStack(spacing: 20) {
                //                        Button(action: goNext) {
                //                            Text("Naver")
                //                        }
                //                        ThirdPartyProvider.shared.kakaoButton()
                //                    }
                //
                
            }
            .frame(maxWidth: UIScreen.main.bounds.width)
            .background(Color.black)
        }
        .ignoresSafeArea(edges: .bottom)
        .transition(.move(edge: .bottom))
    }
    
    private func goNext() {
        //        if user.exists {
        //            go to session
        //        } else {
        withAnimation {
            goToUserOnboarding = true
        }
        //        }
    }
}

#Preview {
    SignInSheet(goToUserOnboarding: .constant(false))
}
