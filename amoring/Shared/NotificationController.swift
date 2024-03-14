//
//  NotificationController.swift
//  amoring
//
//  Created by 이준녕 on 1/26/24.
//

import SwiftUI

enum NotificationType {
    case text
    case message
    case textAndButton
    case error
}

struct NotificationModel: Equatable {
    static func == (lhs: NotificationModel, rhs: NotificationModel) -> Bool {
        lhs.text == rhs.text
    }
    
    let type: NotificationType
    var title: String? = nil
    let text: String
    let action: () -> Void
}

class NotificationController: NSObject, ObservableObject, UNUserNotificationCenterDelegate  {
    @Published var notification: NotificationModel? = nil
    @Published var onTapOnPush: () -> Void = { print("empty") }
    
    @Published var offset: CGSize = CGSize.zero
    
    func registerForPushNotifications() {
        /// The notifications settings
            UNUserNotificationCenter.current().delegate = self
            
            UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .sound, .alert], completionHandler: {(granted, error) in
                if (granted) {
                    DispatchQueue.main.async {
                        UIApplication.shared.registerForRemoteNotifications()
                    }
                } else {
                    //Do stuff if unsuccessful...
                }
            })
    }

    // Called when a notification is delivered to a foreground app.
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        print("User Info = ",notification.request.content.userInfo)
        print("foreground")
        
        completionHandler([.banner, .badge, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("User Info = ",response.notification.request.content.userInfo)
//        let content = response.notification.request.content.userInfo
//        if let aps = content["aps"] as? [String: AnyObject] {
//            let myValue = aps["my_value"]
//        }
        
        
        if response.actionIdentifier == UNNotificationDefaultActionIdentifier {
                    // Handle default action (tapping on notification)
                    print("Tapped on notification from NotificationController")
            onTapOnPush()
        }
        
        completionHandler()
    }
    
    func setNotification(show: Bool? = nil, title: String? = nil, text: String, type: NotificationType, action: (() -> Void)? = nil) {
        /// removes previous notification before showing new
        if self.notification != nil {
            withAnimation {
                self.notification = nil
            }
        }
        
        if show ?? true {
            withAnimation {
                self.notification = NotificationModel(type: type, title: title, text: text, action: action ?? {})
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation {
                    self.notification = nil
                }
            }
        }
    }
    
    override init() {
        super.init()
        self.registerForPushNotifications()
    }
    
    @ViewBuilder
    func body() -> some View {
        ZStack {
            VStack(alignment: .leading) {
                if notification?.type == .message {
                    Text(notification?.title ?? "")
                        .font(semiBold16Font)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .lineSpacing(6)
                }
                
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
            }
                .padding(.top, Size.w(21))
                .padding(.bottom, Size.w(30))
                .padding(.horizontal, Size.w(22))
                .frame(maxWidth: .infinity, alignment: .topLeading)
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
                    if self.notification?.type == .message {
                        self.notification?.action()
                    }
                    withAnimation {
                        self.notification = nil
                    }
                }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .opacity(notification == nil ? 0 : 1)
    }
    
}
