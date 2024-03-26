//
//  ContentView.swift
//  amoring
//
//  Created by 이준녕 on 11/20/23.
//

import SwiftUI
import Apollo

struct ContentView: View {
    @EnvironmentObject var notificationController: NotificationController
    @StateObject var sessionManager = SessionManager()
    @StateObject var businessSignUpController: BusinessSignUpController = BusinessSignUpController()
    @EnvironmentObject private var appDelegate: AppDelegate
    
    var body: some View {
        ZStack {
            switch sessionManager.appState {
            case .initializing:
                LogoLoadingView()
            case .auth:
                SignInView()
            case .session(let user):
                SessionFlow(userManager: UserManager(authUser: user, api: sessionManager.api, WSApi: sessionManager.wsApi)).transition(.move(edge: .trailing))
            case .error:
                Text("smth went wrong!")
            }
        }
        .overlay(
            notificationController.body()
            , alignment: .top
        )
        .environmentObject(sessionManager)
        .environmentObject(businessSignUpController)
        .onAppear {
            sessionManager.getCurrentSession { success, error in
                notificationController.setNotification(show: !success, text: error, type: .error)
            }
        }
    }
}


#Preview {
    ContentView()
}
