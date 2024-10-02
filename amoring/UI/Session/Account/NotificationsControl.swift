//
//  NotificationsControl.swift
//  amoring
//
//  Created by Sergey Li on 9/25/24.
//

import SwiftUI

struct NotificationsControl: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @AppStorage("shouldSendNotifications") var shouldSendNotifications = UserDefaults.standard.bool(forKey: "shouldSendNotifications")
    @EnvironmentObject var sessionManager: SessionManager
    @EnvironmentObject var notificationController: NotificationController
    
    var body: some View {
        VStack {
            Toggle(isOn: $shouldSendNotifications) {
                Text("푸시 알림")
                    .font(regular16Font)
                    .foregroundColor(Color.gray600)
            }
            .tint(Color.green400)
            .padding(.horizontal, Size.w(14))
            .padding(.vertical, Size.w(16))
            .background(Color.black)
            .clipShape(RoundedRectangle(cornerRadius: 14))
            .padding(.horizontal, Size.w(22))
            .padding(.top, Size.w(40))
            .onChange(of: shouldSendNotifications) { newValue in
                if !newValue {
                    notificationController.unregisterPushNotifications()
//                    sessionManager.deleteEndPoint{ error in
//                        if let error {
//                            withAnimation {
//                                self.shouldSendNotifications = !newValue
//                            }
//                            notificationController.setNotification(text: error.localizedDescription, type: .error)
//                        } else {
//                            print("Push notifications end point deleted")
//                        }
//                    }
                } else {
                    notificationController.registerForPushNotifications()
//                    sessionManager.createEndPoint { error in
//                        if let error {
//                            withAnimation {
//                                self.shouldSendNotifications = !newValue
//                            }
//                            notificationController.setNotification(text: error.localizedDescription, type: .error)
//                        } else {
//                            print("Push notifications end point created")
//                        }
//                    }
                }
            }
            
                Text("푸시 알림을 활성화합니다. 메세지, 매칭 등에 활용됩니다.")
                    .font(regular16Font)
                    .foregroundColor(.gray600)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal, Size.w(34))
                    .padding(.top, Size.w(16))
                    .padding(.bottom, Size.w(30))
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.gray1000)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("알림 설정")
                    .font(medium20Font)
                    .foregroundColor(.yellow300)
            }
        }
        .navigationBarItems(leading:
                                BackButton(action: {
            self.presentationMode.wrappedValue.dismiss()
        }, color: Color.yellow300)
        )
    }
}

//
//  NotificationsControl.swift
//  amoring
//
//  Created by Sergey Li on 9/25/24.
//

//import SwiftUI
//
//struct NotificationsControl: View {
//    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
//    @State private var notificationAuthorised = false
//    @State private var taskTrigger = false
//    @Environment(\.scenePhase) var scenePhase
//    @AppStorage("notifications") var shouldSendNotifications = true
//    
//    var body: some View {
//        let binding = Binding {
//            notificationAuthorised && shouldSendNotifications
//        } set: { newValue in
//            if newValue { // turning on notifications
//                print("turning on notifications")
//                Task {
//                    // perhaps also UIApplication.shared.registerForRemoteNotifications()
//                    shouldSendNotifications = true
//
//                    let notifCenter = UNUserNotificationCenter.current()
//                    let settings = await notifCenter.notificationSettings()
//                    if settings.authorizationStatus == .notDetermined {
//                        // show the request alert
//                        try await notifCenter.requestAuthorization(options: [.alert, .sound, .badge])
//                    } else if settings.authorizationStatus == .denied {
//                        // go to settings page
//                        if let appSettings = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(appSettings) {
//                            await UIApplication.shared.open(appSettings)
//                        }
//                    }
//                    // run the task again to update notificationAuthorised
//                    taskTrigger.toggle()
//                }
//            } else {
//                print("turning off notifications")
//                shouldSendNotifications = false
//                // perhaps also UIApplication.shared.unregisterForRemoteNotifications()
//            }
//        }
//
//        VStack {
//            Toggle(isOn: binding) {
//                Text("Push Notifications")
//                    .font(regular16Font)
//                    .foregroundColor(Color.gray600)
//            }
//                .tint(Color.green400)
//                .padding(.horizontal, Size.w(14))
//                .padding(.vertical, Size.w(16))
//                .background(Color.black)
//                .clipShape(RoundedRectangle(cornerRadius: 14))
//                .padding(.horizontal, Size.w(22))
//                .padding(.top, Size.w(40))
//                
//                Text("Push notifications control")
//                    .font(regular16Font)
//                    .foregroundColor(.gray600)
//                    .multilineTextAlignment(.leading)
//                    .padding(.horizontal, Size.w(34))
//                    .padding(.top, Size.w(16))
//                    .padding(.bottom, Size.w(30))
//            
//            Spacer()
//        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .background(Color.gray1000)
//        .navigationBarBackButtonHidden()
//        .toolbar {
//            ToolbarItem(placement: .principal) {
//                Text("Push Notifications")
//                    .font(medium20Font)
//                    .foregroundColor(.yellow300)
//            }
//        }
//        .navigationBarItems(leading:
//                                BackButton(action: {
//            self.presentationMode.wrappedValue.dismiss()
//        }, color: Color.yellow300)
//        )
//        .task(id: taskTrigger) {
//            let notifCenter = UNUserNotificationCenter.current()
//            let settings = await notifCenter.notificationSettings()
//            switch settings.authorizationStatus {
//            case .notDetermined, .denied:
//                notificationAuthorised = false
//            case .authorized, .ephemeral, .provisional:
//                notificationAuthorised = true
//            @unknown default:
//                notificationAuthorised = false
//            }
//        }
//        // run the task again to update notificationAuthorised when coming back to the app
//        .onChange(of: scenePhase) { _ in
//            taskTrigger.toggle()
//        }
//    }
//}
