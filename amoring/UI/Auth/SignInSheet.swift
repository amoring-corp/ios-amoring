//
//  SignInSheet.swift
//  amoring
//
//  Created by 이준녕 on 12/29/23.
//

import SwiftUI

enum lastProvider: Int {
    case google, apple, facebook, naver, kakao, none
}

struct SignInSheet: View {
    @EnvironmentObject var sessionManager: SessionManager
    @EnvironmentObject var navigator: NavigationAuthController
    @Binding var businessSheetPresented: Bool
    
    @AppStorage("lastProvider") var lastProvider: lastProvider = .none
    
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
                        .overlay(
                            lastProvider == .google ?
                            SignInTooltip(provider: .google)
                            : nil
                             
                        )
                    Spacer().frame(maxWidth: Size.w(20))
                    Image("SNS-apple")
                        .resizable()
                        .scaledToFit()
                        .onTapGesture {
                            sessionManager.signInWithApple()
                        }
                        .overlay(
                            lastProvider == .apple ?
                            SignInTooltip(provider: .apple) : nil
                        )
                    Spacer().frame(maxWidth: Size.w(20))
                    Image("SNS-kakao")
                        .resizable()
                        .scaledToFit()
                        .onTapGesture {
                            sessionManager.signInWithKakao()
                        }
                        .overlay(
                            lastProvider == .kakao ?
                            SignInTooltip(provider: .kakao) : nil
                        )
                    Spacer().frame(maxWidth: Size.w(20))
                    Image("SNS-naver")
                        .resizable()
                        .scaledToFit()
                        .onTapGesture {
                            self.sessionManager.changeStateWithAnimation(state: .session(user: User(id: "dummy")))
                        }
                        .overlay(
                            lastProvider == .naver ?
                            SignInTooltip(provider: .naver) : nil
                        )
                    Spacer().frame(maxWidth: Size.w(20))
                    Image("SNS-facebook")
                        .resizable()
                        .scaledToFit()
                        .onTapGesture {
                            withAnimation {
                                sessionManager.appState = .session(user: User(id: "dummy"))
                            }
                        }
                        .overlay(
                            lastProvider == .facebook ?
                            SignInTooltip(provider: .facebook) : nil
                        )
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
                }
                .frame(maxWidth: UIScreen.main.bounds.width - Size.w(60), maxHeight: Size.w(54))
                
                .zIndex(3)
                
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
                .zIndex(1)
                
                HStack {
                    NavigationLink(destination: {
                        BusinessSignUpTerms()
                    }) {
                        Text("비즈니스 가입 ")
                    }
                    
                    Text("  |  ")
                    
                    Button(action: {
                        withAnimation {
                            self.businessSheetPresented = true
                        }
                    }) {
                        Text("비즈니스 로그인")
                    }
                }
                .font(medium16Font)
                .foregroundColor(.gray600)
                .padding(.bottom, Size.w(48))
            }
            .frame(maxWidth: UIScreen.main.bounds.width)
            .background(Color.black)
        }
        .ignoresSafeArea(edges: .bottom)
        .transition(.move(edge: .bottom))
    }
}

struct SignInTooltip: View {
    let provider: lastProvider
    @State var hideLastProvider: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            Triangle()
                .foregroundColor(.gray100)
                .frame(width: 10, height: 10)
            Text("마지막으로\n로그인한 계정이예요~")
                .font(medium14Font)
                .foregroundColor(.gray900)
                .multilineTextAlignment(.center)
                .padding(Size.w(16))
                .background(Color.gray100)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .offset(x: provider == .google ? Size.w(45) : (provider == .facebook ? Size.w(-45): 0))
        }
            .fixedSize()
            .opacity(hideLastProvider ? 0.1 : 1)
            .offset(y: Size.w(54 + 26))
            .onTapGesture {
                withAnimation {
                    hideLastProvider.toggle()
                }
            }
    }
}

#Preview {
    SignInSheet(businessSheetPresented: .constant(false))
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        }
    }
}
