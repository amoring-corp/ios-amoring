//
//  amoringApp.swift
//  amoring
//
//  Created by 이준녕 on 11/20/23.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth
import GoogleSignIn
import NaverThirdPartyLogin

@main
struct amoringApp: App {
    @Environment(\.scenePhase) var scenePhase
    @UIApplicationDelegateAdaptor var appDelegate: AppDelegate
    @StateObject var notificationController = NotificationController()
//    @StateObject var scenePhaseHelper = ScenePhaseHelper()
    
    init() {
        KakaoSDK.initSDK(appKey: "88a121ae97540f56f106e7f52609022c")
        naverSDKinit()

        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge, .providesAppNotificationSettings]) { (granted: Bool, error: Error?) in
            if granted {
                print("Notifications permission granted")
            } else {
                guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
                DispatchQueue.main.async {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
        }
    }
    
    // Naver SDK Initializing
    private func naverSDKinit() {
        // 네이버 앱으로 로그인 허용
        NaverThirdPartyLoginConnection.getSharedInstance()?.isNaverAppOauthEnable = true
        // 브라우저 로그인 허용
        NaverThirdPartyLoginConnection.getSharedInstance()?.isInAppOauthEnable = true
        
        // 네이버 로그인 세로모드 고정
        NaverThirdPartyLoginConnection.getSharedInstance().setOnlyPortraitSupportInIphone(true)
        
        // NaverThirdPartyConstantsForApp.h에 선언한 상수 등록
        NaverThirdPartyLoginConnection.getSharedInstance().serviceUrlScheme = kServiceAppUrlScheme
        NaverThirdPartyLoginConnection.getSharedInstance().consumerKey = kConsumerKey
        NaverThirdPartyLoginConnection.getSharedInstance().consumerSecret = kConsumerSecret
        NaverThirdPartyLoginConnection.getSharedInstance().appName = kServiceAppName
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
//                .environmentObject(scenePhaseHelper)
                .environmentObject(notificationController)
                .preferredColorScheme(.dark)
                .environment(\.locale, .init(identifier: "ko"))
                .onAppear {
                    setupUI()
                }
                .onOpenURL { url in
                    if (AuthApi.isKakaoTalkLoginUrl(url)) {
                        _ = AuthController.handleOpenUrl(url: url)
                    } else {
                        GIDSignIn.sharedInstance.handle(url)
                    }
                }
//                .onChange(of: scenePhase) {
//                    self.scenePhaseHelper.scenePhase = $0
//                    print("current scene phase: \($0)")
//                }
//                .onAppear {
//                    self.scenePhaseHelper.scenePhase = scenePhase
//                }
        }
    }
    
    func setupUI() {
        /// Hides native TabBar
//        UITabBar.appearance().isHidden = true
        
        /// TextField, TextEditor background to Clear
//        UITextView.appearance().backgroundColor = .clear
        
    }
}
