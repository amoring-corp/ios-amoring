//
//  AppDelegate.swift
//  amoring
//
//  Created by Sergey Li on 3/7/24.
//

import Foundation
import AWSSNS
import UserNotifications

class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    /// The SNS Platform application ARN
    let SNSPlatformApplicationArn = "arn:aws:sns:ap-northeast-2:241804645484:app/APNS_SANDBOX/Amoring"

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        /// Setup AWS Cognito credentials
        let credentialsProvider = AWSCognitoCredentialsProvider(
            regionType: AWSRegionType.APNortheast2, identityPoolId: "ap-northeast-2:6ea3d189-6866-45a5-b125-af5dc0bdx`15c2")

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

    func registerForPushNotifications(application: UIApplication) {
        /// The notifications settings
        if #available(iOS 10.0, *) {
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
        } else {
            let settings = UIUserNotificationSettings(types: [UIUserNotificationType.alert, UIUserNotificationType.badge, UIUserNotificationType.sound], categories: nil)
            application.registerUserNotificationSettings(settings)
            application.registerForRemoteNotifications()
        }
    }

    // Called when a notification is delivered to a foreground app.
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("User Info = ",notification.request.content.userInfo)
        completionHandler([.alert, .badge, .sound])
    }

    // Called to let your app know which action was selected by the user for a given notification.
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("User Info = ",response.notification.request.content.userInfo)

        completionHandler()
    }
}
