//
//  amoringApp.swift
//  amoring
//
//  Created by 이준녕 on 11/20/23.
//

import SwiftUI
//import KakaoSDKCommon
//import KakaoSDKAuth
import GoogleSignIn
//import NaverThirdPartyLogin

@main
struct amoringApp: App {
    @Environment(\.scenePhase) var scenePhase
    @UIApplicationDelegateAdaptor var appDelegate: AppDelegate
    @StateObject var notificationController = NotificationController()
//    @StateObject var scenePhaseHelper = ScenePhaseHelper()
    
    init() {
//        KakaoSDK.initSDK(appKey: "0489ce9b77b8476eeebcc7461a9b3166")
//        naverSDKinit()
        notificationController.registerForPushNotifications()
    }
    
    // Naver SDK Initializing
//    private func naverSDKinit() {
//        // 네이버 앱으로 로그인 허용
//        NaverThirdPartyLoginConnection.getSharedInstance()?.isNaverAppOauthEnable = true
//        // 브라우저 로그인 허용
//        NaverThirdPartyLoginConnection.getSharedInstance()?.isInAppOauthEnable = true
//        
//        // 네이버 로그인 세로모드 고정
//        NaverThirdPartyLoginConnection.getSharedInstance().setOnlyPortraitSupportInIphone(true)
//        
//        // NaverThirdPartyConstantsForApp.h에 선언한 상수 등록
//        NaverThirdPartyLoginConnection.getSharedInstance().serviceUrlScheme = kServiceAppUrlScheme
//        NaverThirdPartyLoginConnection.getSharedInstance().consumerKey = kConsumerKey
//        NaverThirdPartyLoginConnection.getSharedInstance().consumerSecret = kConsumerSecret
//        NaverThirdPartyLoginConnection.getSharedInstance().appName = kServiceAppName
//    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
            //                .environmentObject(scenePhaseHelper)
                .environmentObject(notificationController)
                .preferredColorScheme(.dark)
            //                .environment(\.locale, .init(identifier: "ko"))
                .onAppear {
                    setupUI()
                }
                .onOpenURL { url in
                    // 1. Google Sign-In
                    if GIDSignIn.sharedInstance.handle(url) {
                        return
                    }
                    
                    // 2. Universal Links (amoring.info)
                    if url.host == "amoring.info" {
                        if url.path.contains("/checkin") {
                            let token = URLComponents(url: url, resolvingAgainstBaseURL: false)?
                                .queryItems?
                                .first(where: { $0.name == "t" })?.value
                            
                            if let token = token {
                                // MARK: Do check in
                                print("Check-in with token:", token)
                                // checkInMutation(token: token)
                            } else {
                                print("Opened without token, show home")
                            }
                        }
                    }
                }
        }
    }
    
    func setupUI() {
        /// Hides native TabBar
        UITabBar.appearance().isHidden = true
        
        /// TextField, TextEditor background to Clear
//        UITextView.appearance().backgroundColor = .clear
        
    }
}
