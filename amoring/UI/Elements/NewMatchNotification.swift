//
//  NewMatchNotification.swift
//  amoring
//
//  Created by Sergey Li on 3/18/24.
//

import SwiftUI
import AmoringAPI
import CachedAsyncImage

struct NewMatchNotification: View {
    @EnvironmentObject var notificationController: NotificationController
    @EnvironmentObject var userManager: UserManager
    @State var animation: Bool = false
    @State var scaleSize: CGFloat = 1
    
    var reaction: ReactionInfo
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack(spacing: 0) {
                Color.yellow300.frame(height: 44)
                    .padding(.top, Size.safeArea().top)
                
                Circle()
                    .fill(Color.black)
                    .frame(width: Size.w(160), height: Size.w(160))
                    .scaleEffect(scaleSize, anchor: .center)
                    .padding(.top, Size.w(16))
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            withAnimation(.linear(duration: 0.2)) {
                                self.scaleSize = 0
                            }
                            
                            withAnimation(.linear(duration: 0.2).delay(0.2)) {
                                self.scaleSize = 0.7
                            }
                                
                            withAnimation(.linear(duration: 0.1).delay(0.4)) {
                                self.scaleSize = 0
                            }
                            
                            withAnimation(.linear(duration: 0.7).delay(0.5)) {
                                self.scaleSize = 12
                                animation = true
                            }
                        }
                    }
                    
                Spacer()
            }
            
            .frame(maxHeight: UIScreen.main.bounds.height).ignoresSafeArea()
            .clipped().ignoresSafeArea()
            
            VStack(spacing: 0) {
                ZStack {
                    HStack {
                        XButton(action: {
                            notificationController.reaction = nil
                        })
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    
                    HStack {
                        Text("AMORING")
                            .font(bold20Font)
                            .foregroundColor(.yellow300)
                    }
                    .font(bold20Font)
                    .foregroundColor(.yellow300)
                    .frame(maxWidth: .infinity, alignment: .center)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 44)
                .padding(.top, Size.safeArea().top)
                
                        Image("LOGO")
                            .resizable()
                            .scaledToFit()
                            .frame(width: Size.w(85), height: Size.w(72))
                            .frame(width: Size.w(160), height: Size.w(160))
                    .padding(.top, Size.w(16))
                
                VStack(spacing: 0) {
                    ZStack {
                        HStack(alignment: .top) {
                            let me = userManager.user?.profile?.images.first?.file?.url
                            let chatMate = reaction.byProfile.images?.first??.file.url
                            
                            PersonView(lineHeight: 60, stringUrl: me)
                            Spacer()
                            PersonView(lineHeight: 72, stringUrl: chatMate)
                        }
                        .padding(.horizontal, Size.w(70))
                        .overlay(
                            Ellipse()
                                .stroke(Color.yellow900)
                                .frame(width: .infinity, height: Size.w(64))
                                .padding(.horizontal, Size.w(22))
                                .offset(y: Size.w(32))
                            , alignment: .bottom
                        )
                    }
                    .frame(maxHeight: animation ? 150 : 0, alignment: .center)
                    .frame(height: animation ? 150 : 0, alignment: .center)
                    .opacity(animation ? 1 : 0)
                }
                .padding(.bottom, Size.w(32))
                
                VStack(spacing: 0) {
                    Text("마음이 통했어요!")
                        .font(bold32Font)
                        .foregroundColor(animation ? .gray100 : .black)
                        .padding(.horizontal, Size.w(14))
                        .padding(.top, Size.w(30))
                        .padding(.bottom, Size.w(16))
                    
                    Text("서로가 ‘좋아요'를 통해 연결되었어요.\n먼저 메시지를 보내서 인사를 건내 보세요!")
                        .font(regular16Font)
                        .foregroundColor(animation ? .gray100 : .black)
                        .lineSpacing(6)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, Size.w(22))
                }
                
                Spacer()
                
                Button(action: {
                    withAnimation {
                        notificationController.reaction = nil
                    }
                    notificationController.goToConversationsList()
                }) {
                    FullSizeButton(title: "메시지 보내기", color: Color.black, bg: .yellow300)
                }
                .padding(.horizontal, Size.w(22))
                .padding(.bottom, Size.safeArea().bottom + Size.w(22))
            }
            .ignoresSafeArea()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.yellow300)
    }
    
    @ViewBuilder
    private func PersonView(lineHeight: CGFloat, stringUrl: String?) -> some View {
        VStack(spacing: 0) {
            ZStack {
                Circle()
                    .fill(Color.yellow300)
                
                CachedAsyncImage(url: URL(string: stringUrl ?? ""), content: { cont in
                    cont
                        .resizable()
                        .scaledToFill()
                }, placeholder: {
                    ZStack {
                        ProgressView().progressViewStyle(CircularProgressViewStyle(tint: Color.gray1000))
                    }
                })
                .frame(width: Size.w(86), height: Size.w(86))
                .clipShape(Circle())
            }
            .frame(width: Size.w(90), height: Size.w(90))
            
            LineShape()
                .stroke(Color.yellow300, style: StrokeStyle(lineWidth: 1, dash: [2]))
                .frame(width: 1, height: lineHeight)
            Circle()
                .fill(Color.yellow300)
                .frame(width: Size.w(8), height: Size.w(8))
        }
    }
}

//#Preview {
//    NewMatchNotification()
//}
