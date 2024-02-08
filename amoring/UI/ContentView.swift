//
//  ContentView.swift
//  amoring
//
//  Created by 이준녕 on 11/20/23.
//

import SwiftUI
import Apollo

struct ContentView: View {
    @StateObject var sessionManager = SessionManager()
    @StateObject var notificationController = NotificationController()
    @StateObject var businessSignUpController: BusinessSignUpController = BusinessSignUpController()

    var body: some View {
        ZStack {
            switch sessionManager.appState {
            case .initializing:
                LogoLoadingView()
            case .auth:
                SignInView()
            case .session(let user):
                SessionFlow(userManager: UserManager(authUser: user, api: sessionManager.api)).transition(.move(edge: .trailing))
            case .error:
                Text("smth went wrong!")
            }
        }
        .overlay(
            notificationController.body()
            , alignment: .top
                
        )
        .environmentObject(sessionManager)
        .environmentObject(notificationController)
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
