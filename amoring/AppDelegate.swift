//
//  AppDelegate.swift
//  amoring
//
//  Created by Sergey Li on 3/7/24.
//

import SwiftUI
import AWSSNS
import UserNotifications

class AppDelegate: UIResponder, UIApplicationDelegate {
    @AppStorage("deviceTokenForSNS") var deviceToken: String?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        /// Setup AWS Cognito credentials
        let credentialsProvider = AWSCognitoCredentialsProvider(
            regionType: AWSRegionType.APNortheast2, identityPoolId: "ap-northeast-2:db7d8417-60c6-4f6c-95ce-010cea9c05ca")

        let defaultServiceConfiguration = AWSServiceConfiguration(
            region: AWSRegionType.APNortheast2, credentialsProvider: credentialsProvider)
        
        AWSServiceManager.default().defaultServiceConfiguration = defaultServiceConfiguration

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
        self.deviceToken = token
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
    }
}
