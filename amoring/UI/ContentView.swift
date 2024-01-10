//
//  ContentView.swift
//  amoring
//
//  Created by 이준녕 on 11/20/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var sessionManager = SessionManager()
    @StateObject var userManager = UserManager()
    @StateObject var navigator = NavigationController()
    @StateObject var sessionController = SessionController()
    @StateObject var messagesController = MessagesController()
    @StateObject var amoringController = AmoringController()
    @StateObject var controller: BusinessOnboardingController = BusinessOnboardingController()
    
    var body: some View {
        ZStack {
            if sessionManager.isLoading {
                LogoLoadingView()
            } else if sessionManager.signedIn {
                /// pass user here
                SessionView().transition(.move(edge: .trailing))
            } else if sessionManager.BusinessSignedIn {
                if sessionManager.goToBusinessOnboarding {
                    BusinessOnboardingView().transition(.move(edge: .trailing))
                } else {
                    BusinessSessionView().transition(.move(edge: .trailing))
                }
            } else {
                SignInView()
            }
        }
        .overlay(
            sessionController.purchaseType != nil ? PurchaseView(purchaseType: $sessionController.purchaseType, model: purchasesList[sessionController.purchaseType!.rawValue]).transition(.move(edge: .bottom)) : nil
        )
        .environmentObject(controller)
        .environmentObject(navigator)
        .environmentObject(sessionController)
        .environmentObject(sessionManager)
        .environmentObject(userManager)
        .environmentObject(messagesController)
        .environmentObject(amoringController)
        .onAppear {
//            NetworkService.shared.amoring.
            sessionManager.getCurrentSession()
            
            // MARK: TESTS
            userManager.user = Dummy.users.first!
        }
    }
}


#Preview {
    ContentView()
}
