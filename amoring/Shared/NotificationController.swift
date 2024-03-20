//
//  NotificationController.swift
//  amoring
//
//  Created by 이준녕 on 1/26/24.
//

import SwiftUI
import AmoringAPI
import Intents

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

class NotificationController: UNNotificationServiceExtension, ObservableObject, UNUserNotificationCenterDelegate  {
    @Published var notification: NotificationModel? = nil
    @Published var goToCurrentConversation: () -> Void = { print("empty") }
    @Published var goToConversationsList: () -> Void = { print("empty") }
    
    @Published var offset: CGSize = CGSize.zero
    @Published var reaction: ReactionInfo? = nil
    
    func registerForPushNotifications() {
        /// The notifications settings
            UNUserNotificationCenter.current().delegate = self
            
        UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .sound, .alert, .providesAppNotificationSettings], completionHandler: {(granted, error) in
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
        
//        print("User Info = ",notification.request.content.userInfo)
//        print("foreground")
        
        completionHandler([.banner, .badge, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, openSettingsFor notification: UNNotification?) {
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
//        print("User Info = ",response.notification.request.content.userInfo)

        if response.actionIdentifier == UNNotificationDefaultActionIdentifier {
            goToCurrentConversation()
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
  
    func setInnerPushNotification(newMessage: MessageInfo) {
        let senderName = newMessage.sender?.profile?.name ?? "TITLE"
        let message = newMessage.body
        var content = UNMutableNotificationContent()
        content.title = senderName
        content.body = message
        content.categoryIdentifier = "newMessage"
        
        var personNameComponents = PersonNameComponents()
        personNameComponents.nickname = newMessage.senderName ?? "unknown"
        var image: UIImage? = nil
        if let urlString = newMessage.senderAvatarUrl,
           let url = URL(string: urlString),
           let data = try? Data(contentsOf: url) {
            image = UIImage(data: data)
        }
        
        var avatar: INImage? = nil
        
        if let image {
            avatar = INImage(imageData: image.pngData()!)
        }
        
        let senderPerson = INPerson(
            personHandle: INPersonHandle(value: "1233211234", type: .unknown),
            nameComponents: personNameComponents,
            displayName: senderName,
            image: avatar,
            contactIdentifier: nil,
            customIdentifier: nil,
            isMe: false,
            suggestionType: .none
        )

        let intent = INSendMessageIntent(
            recipients: [],
            outgoingMessageType: .outgoingMessageText,
            content: message,
            speakableGroupName: INSpeakableString(spokenPhrase: senderName),
            conversationIdentifier: "newMessage",
            serviceName: nil,
            sender: senderPerson,
            attachments: nil
        )
        let interaction = INInteraction(intent: intent, response: nil)
        interaction.direction = .incoming

        interaction.donate(completion: nil)
        intent.setImage(avatar, forParameterNamed: \.speakableGroupName)
        
        do {
            content = try content.updating(from: intent) as! UNMutableNotificationContent
        } catch {
            print("errrrror updating Intent!")
        }
        
//        if let fileURL: URL = URL(string: newMessage.sender?.profile?.images?.first??.file.url ?? "https://picsum.photos/200/300") {
//            guard let imageData = NSData(contentsOf: fileURL) else {
//                    return
//                }
//            guard let senderId = newMessage.senderId else { return }
//            guard let attachment = UNNotificationAttachment.saveImageToDisk(fileIdentifier: senderId + ".jpg", data: imageData, options: nil) else {
//                    print("error in UNNotificationAttachment.saveImageToDisk()")
//                    return
//                }
//            content.attachments = [attachment]
//        }
        
        let center = UNUserNotificationCenter.current()
        let request = UNNotificationRequest.init(identifier: "newMessage", content: content, trigger: nil)
        center.add(request)
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
