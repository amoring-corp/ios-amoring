//
//  AppDelegate.swift
//  amoring
//
//  Created by Sergey Li on 3/7/24.
//

import SwiftUI
import AWSSNS
import UserNotifications

class AppDelegate: NSObject, UIApplicationDelegate, ObservableObject {
    @AppStorage("deviceTokenForSNS") var deviceToken: String?
//    @Published var deviceToken: String? = nil

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        /// Setup AWS Cognito credentials
        let credentialsProvider = AWSCognitoCredentialsProvider(
            regionType: AWSRegionType.APNortheast2, identityPoolId: "ap-northeast-2:6ea3d189-6866-45a5-b125-af5dc0bd15c2")

        let defaultServiceConfiguration = AWSServiceConfiguration(
            region: AWSRegionType.APNortheast2, credentialsProvider: credentialsProvider)
        
        AWSServiceManager.default().defaultServiceConfiguration = defaultServiceConfiguration
        
//        notificationController.registerForPushNotifications(application: application)
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
//        /// Create a platform endpoint. In this case,  the endpoint is a
//        /// device endpoint ARN
//        let sns = AWSSNS.default()
//        let request = AWSSNSCreatePlatformEndpointInput()
//        request?.token = token
//        request?.attributes = ["UserId": "HELLO!"]
//        
//        request?.platformApplicationArn = SNSPlatformApplicationArn
//        sns.createPlatformEndpoint(request!).continueWith(executor: AWSExecutor.mainThread(), block: { (task: AWSTask!) -> AnyObject? in
//            if task.error != nil {
//                print("Error: \(String(describing: task.error))")
//            } else {
//                let createEndpointResponse = task.result! as AWSSNSCreateEndpointResponse
//
//                if let endpointArnForSNS = createEndpointResponse.endpointArn {
//                    print("endpointArn: \(endpointArnForSNS)")
//                    UserDefaults.standard.set(endpointArnForSNS, forKey: "endpointArnForSNS")
//                }
//            }
//
//            return nil
//        })
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
    }
}
