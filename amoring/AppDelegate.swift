//
//  AppDelegate.swift
//  amoring
//
//  Created by Sergey Li on 3/7/24.
//

import Foundation
import AWSSNS
import UserNotifications

class AppDelegate: UNNotificationServiceExtension, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    /// The SNS Platform application ARN
    let SNSPlatformApplicationArn = "arn:aws:sns:ap-northeast-2:241804645484:app/APNS_SANDBOX/Amoring"

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        /// Setup AWS Cognito credentials
        let credentialsProvider = AWSCognitoCredentialsProvider(
            regionType: AWSRegionType.APNortheast2, identityPoolId: "ap-northeast-2:6ea3d189-6866-45a5-b125-af5dc0bd15c2")

        let defaultServiceConfiguration = AWSServiceConfiguration(
            region: AWSRegionType.APNortheast2, credentialsProvider: credentialsProvider)

        AWSServiceManager.default().defaultServiceConfiguration = defaultServiceConfiguration
        
        registerForPushNotifications(application: application)
        return true
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        /// Attach the device token to the user defaults
        var token = ""
        for i in 0..<deviceToken.count {
            token = token + String(format: "%02.2hhx", arguments: [deviceToken[i]])
        }

        print("device token:")
        print(token)

        UserDefaults.standard.set(token, forKey: "deviceTokenForSNS")

        /// Create a platform endpoint. In this case,  the endpoint is a
        /// device endpoint ARN
        let sns = AWSSNS.default()
        let request = AWSSNSCreatePlatformEndpointInput()
        request?.token = token
        request?.platformApplicationArn = SNSPlatformApplicationArn
        sns.createPlatformEndpoint(request!).continueWith(executor: AWSExecutor.mainThread(), block: { (task: AWSTask!) -> AnyObject? in
            if task.error != nil {
                print("Error: \(String(describing: task.error))")
            } else {
                let createEndpointResponse = task.result! as AWSSNSCreateEndpointResponse

                if let endpointArnForSNS = createEndpointResponse.endpointArn {
                    print("endpointArn: \(endpointArnForSNS)")
                    UserDefaults.standard.set(endpointArnForSNS, forKey: "endpointArnForSNS")
                }
            }

            return nil
        })
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        getPushNotificationDeeplink(notificationDictionary: userInfo)
        
    }
    
    func registerForPushNotifications(application: UIApplication) {
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
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        print("User Info = ",notification.request.content.userInfo)
        print("foreground")
        
        completionHandler([.banner, .badge, .sound])
    }
    
    // Called to let your app know which action was selected by the user for a given notification.
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("User Info = ",response.notification.request.content.userInfo)
        let content = response.notification.request.content.userInfo
        if let aps = content["aps"] as? [String: AnyObject] {
            let myValue = aps["my_value"]
            
            
        }
        UserDefaults.standard.setValue(response.notification.request.content.userInfo.description, forKey: "didReceive")
        if response.actionIdentifier == UNNotificationDefaultActionIdentifier {
                    // Handle default action (tapping on notification)
                    print("Tapped on notification")
            
        }
        
        completionHandler()
    }
}

func getPushNotificationDeeplink(notificationDictionary: [AnyHashable:Any]) {
        print("Notification dictionary = \(notificationDictionary)")

    guard let alert = notificationDictionary["alert"] as? [String: Any],
          let conversationId = notificationDictionary["conversationId"] as? String
    else { return }
    
              let title = alert["title"] as? String
              let body = alert["body"] as? String

        
    UserDefaults.standard.setValue("Body is \(body) Title is \(title) Conv Id is \(conversationId)", forKey: "BOO")
       print("Body is \(body) Title is \(title) Conv Id is \(conversationId)")

}
