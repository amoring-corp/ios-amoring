//
//  NotificationController.swift
//  amoring
//
//  Created by 이준녕 on 1/26/24.
//

import SwiftUI

enum NotificationType {
    case text
    case textAndButton
    case error
}

struct NotificationModel: Equatable {
    static func == (lhs: NotificationModel, rhs: NotificationModel) -> Bool {
        lhs.text == rhs.text
    }
    
    let type: NotificationType
    let text: String
    let action: () -> Void
}

class NotificationController: ObservableObject {
    @Published var notification: NotificationModel? = nil
    
    @Published var offset: CGSize = CGSize.zero
    
    func setNotification(show: Bool? = nil, text: String, type: NotificationType, action: (() -> Void)? = nil) {
        if show ?? true {
            withAnimation {
                self.notification = NotificationModel(type: type, text: text, action: action ?? {})
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation {
                    self.notification = nil
                }
            }
        }
    }
    
    @ViewBuilder
    func body() -> some View {
        ZStack {
            HStack {
                Text(notification?.text ?? "")
                    .font(regular16Font)
                    .foregroundColor(notification?.type == .error ? .black : .white)
                    .multilineTextAlignment(.center)
                    .lineSpacing(6)
                
                if notification?.type == .textAndButton {
                    Spacer()
                    
                    Button(action: notification?.action ?? {}) {
                            Text("확인하기")
                            .font(semiBold16Font)
                            .foregroundColor(.green200)
                    }
                }
            }
                .padding(.top, Size.w(21))
                .padding(.bottom, Size.w(30))
                .padding(.horizontal, Size.w(22))
                .frame(maxWidth: .infinity)
                .background(notification?.type == .error ?  Color.red300 : Color.gray900)
                .shadow(color: Color.black.opacity(self.notification != nil ? 0.75 : 0), radius: 20, y: 30)
                .offset(y: self.notification != nil ? offset.height : -150)
                .gesture(DragGesture()
                    .onChanged { gesture in
                        if gesture.translation.height < 0 {
                            self.offset = gesture.translation
                        }
                    }
                    .onEnded { _ in
                        if self.offset.height < -60 {
                            withAnimation {
                                self.notification = nil
                                self.offset = .zero
                            }
                        } else {
                            withAnimation {
                                self.offset = .zero
                            }
                        }
                    })
                .onTapGesture {
                    withAnimation {
                        self.notification = nil
                    }
                }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .opacity(notification == nil ? 0 : 1)
    }
}
