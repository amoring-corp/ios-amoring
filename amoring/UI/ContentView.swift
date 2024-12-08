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
    @AppStorage("sessionToken") var sessionToken: String = UserDefaults.standard.string(forKey: "sessionToken") ?? ""

    
    var body: some View {
        ZStack {
            switch sessionManager.appState {
            case .initializing:
                LogoLoadingView()
            case .auth:
                SignInView()
            case .session(let user):
                SessionFlow(userManager: UserManager(authUser: user)).transition(.move(edge: .trailing))
            case .error:
                Text("smth went wrong!")
            }
            VStack {
                Spacer()
                Text(sessionToken.suffix(8))
                    .font(.largeTitle)
                    .foregroundColor(.white)
            }
            
        }
        .overlay(
            notificationController.body()
            , alignment: .top
        )
        .environmentObject(sessionManager)
        .environmentObject(businessSignUpController)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                notificationController.setNotification(show: true, text: "ON APPEAR", type: .text)
            }
            
            sessionManager.getCurrentSession { success, error in
                DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                    notificationController.setNotification(show: true, text: error, type: .error)
                }
            }
        }
    }
}


#Preview {
    ContentView()
}
