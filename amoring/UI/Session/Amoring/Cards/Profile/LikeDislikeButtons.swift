//
//  LikeDislikeButtons.swift
//  amoring
//
//  Created by 이준녕 on 12/13/23.
//

import SwiftUI
import AmoringAPI

struct LikeDisLikeButtons: View {
    @EnvironmentObject var userManager: UserManager
    @EnvironmentObject var amoringController: AmoringController
    @EnvironmentObject var notificationController: NotificationController
    @State var reportAlertPresented = false
    @Binding var swipeAction: SwipeAction
    @Binding var showAlert: Bool
    let profile: ProfileInfo
    
    var body: some View {
        VStack {
            Spacer()
            VStack {
                HStack {
                    Button(action: {
                        swipeAction = .swipeLeft
                    }) {
                        ZStack {
                            Circle().frame(width: Size.w(76), height: Size.w(76))
                                .foregroundColor(.gray900)
                            Image("dislike-cross")
                                .resizable()
                                .scaledToFit()
                                .frame(width: Size.w(29), height: Size.w(29))
                        }
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        if userManager.disableLikes() {
                            showAlert = true
                        } else {
                            swipeAction = .swipeRight
                        }
                    }) {
                        ZStack {
                            Circle().frame(width: Size.w(76), height: Size.w(76))
                                .foregroundColor(.gray900)
                            Image("ic-heart-fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: Size.w(34), height: Size.w(30))
                                .foregroundColor(.yellow300)
                        }
                    }
                }
                if amoringController.showDetails {
                    Button(action: {
                        self.reportAlertPresented = true
                    }) {
                        Text("신고하기")
                            .font(regular16Font)
                            .foregroundColor(.yellow300)
                            .frame(maxWidth: .infinity)
                            .frame(height: Size.w(35))
                            .background(Color.yellow350.opacity(0.15))
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .overlay(
                                RoundedRectangle(cornerRadius: 20).stroke(Color.yellow300)
                            )
                    }
                    .frame(height: 40)
                    .alertPatched(isPresented: $reportAlertPresented) {
                        Alert(title: Text("신고하기"), message: Text("해당 사용자를 부적절한 콘텐츠 등의 이유로 신고합니다."), primaryButton: .cancel(Text("취소")), secondaryButton: .destructive(Text("보내기"), action: report))
                    }
                }
            }
            .padding(.horizontal, Size.w(44 + 22))
            .zIndex(2)
            /// bottom bar and 16padding
            .padding(.bottom, Size.w(75 + 16))
        }
        
    }
    
    private func report() {
        userManager.reportUser(userId: profile.userId) { error in
            if let error {
                notificationController.setNotification(text: error, type: .error)
            } else {
                // TODO: Test it
                userManager.profiles.removeAll(where: { $0.id == profile.id  })
            }
        }
    }
}
