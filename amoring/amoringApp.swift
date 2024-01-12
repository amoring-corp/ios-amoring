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

@main
struct amoringApp: App {
    init() {
        KakaoSDK.initSDK(appKey: "88a121ae97540f56f106e7f52609022c")
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
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
        }
    }
    
    func setupUI() {
        /// Hides native TabBar
        UITabBar.appearance().isHidden = true
        
        /// TextField, TextEditor background to Clear
//        UITextView.appearance().backgroundColor = .clear
        
    }
}
