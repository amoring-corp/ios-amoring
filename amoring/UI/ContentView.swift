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
    @StateObject var userOnboardingController: UserOnboardingController = UserOnboardingController()
    @StateObject var navigator = NavigationController()
    @StateObject var sessionController = SessionController()
    @StateObject var messagesController = MessagesController()
    @StateObject var amoringController = AmoringController()
    @StateObject var businessOnboardingController: BusinessOnboardingController = BusinessOnboardingController()
    @StateObject var businessSignUpController: BusinessSignUpController = BusinessSignUpController()
    
    var body: some View {
        ZStack {
            switch sessionManager.appState {
            case .loading:
                LogoLoadingView()
            case .auth:
                SignInView()
            case .session(let user):
                SessionFlow(userManager: UserManager(authUser: user)).transition(.move(edge: .trailing))
            case .error:
                Text("smth went wrong!")
            }
        }
        .overlay(
            sessionController.purchaseType != nil ? PurchaseView(purchaseType: $sessionController.purchaseType, model: purchasesList[sessionController.purchaseType!.rawValue]).transition(.move(edge: .bottom)) : nil
        )
        .environmentObject(userOnboardingController)
        .environmentObject(businessOnboardingController)
        .environmentObject(businessSignUpController)
        .environmentObject(navigator)
        .environmentObject(sessionController)
        .environmentObject(sessionManager)
        .environmentObject(messagesController)
        .environmentObject(amoringController)
        .onAppear {
            sessionManager.getCurrentSession()
            
            // MARK: TESTS
//            userManager.user = Dummy.users.first!
        }
    }
}


#Preview {
    ContentView()
}
