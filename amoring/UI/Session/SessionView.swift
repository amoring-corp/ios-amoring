//
//  SessionView.swift
//  amoring
//
//  Created by 이준녕 on 11/20/23.
//

import SwiftUI
import NavigationStackBackport

struct SessionFlow: View {
    @EnvironmentObject var sessionManager: SessionManager
    @EnvironmentObject var notificationController: NotificationController
    @StateObject var purchaseController = PurchaseController()
    @StateObject var userManager: UserManager
    @StateObject var messagesController = MessagesController()
    @StateObject var amoringController = AmoringController()
    
    @State var selectedIndex: Int = 1
    
    var body: some View {
        ZStack {
            switch userManager.userState {
            case .initial:
                EmptyView()
            case .userOnboarding:
                UserOnboardingView()
            case .session:
                SessionView(selectedIndex: $selectedIndex)
            case .businessOnboarding:
                BusinessOnboardingView()
            case .businessSession:
                BusinessSessionView()
            case .debugging:
                Text("DEBUGGING")
                    .foregroundColor(.black)
                    .padding(100)
                    .background(Color.yellow100)
                    .onTapGesture {
                        sessionManager.signOut()
//                        sessionManager.changeStateWithAnimation(state: .auth)
                    }
            case .error:
                Text("ERROR")
                    .foregroundColor(.black)
                    .padding(100)
                    .background(Color.yellow100)
                    .onTapGesture {
                        sessionManager.changeStateWithAnimation(state: .auth)
                    }
            }
        }
        .overlay(
            purchaseController.purchaseType != nil ? PurchaseView(purchaseType: $purchaseController.purchaseType, model: purchasesList[purchaseController.purchaseType!.rawValue]).transition(.move(edge: .bottom)) : nil
        )
        .environmentObject(purchaseController)
        .environmentObject(userManager)
        .environmentObject(messagesController)
        .environmentObject(amoringController)
        .onAppear {
            /// sets current interests from DB
            userManager.getInterests()
            /// getting current active check in for Amoring page
            userManager.activeCheckIn { activeCheckIn in
                amoringController.checkIn = activeCheckIn
            }
           
            if self.messagesController.conversations.isEmpty {
                userManager.getConversations { conversations in
                    if let conversations {
                        self.messagesController.conversations = conversations.compactMap({ Conversation(conversationInfo: $0) })
                        
                    }
                }
            }
            
            // MARK: New message from subscription
            userManager.conversationSubscription { newMessage in
                if let newMessage {
                    if self.messagesController.selectedConversation == nil {
                        notificationController.setNotification(text: newMessage.body, type: .textAndButton, action: {
                            withAnimation {
                                self.selectedIndex = 2
                                self.messagesController.selectedConversation = self.messagesController.conversations.first(where: { $0.id == newMessage.conversationId })
                                if let selectedConversation = messagesController.selectedConversation {
                                    self.messagesController.goToConversation = true
                                }
                            }
                        })
                    }
                    
                    if let row = self.messagesController.conversations.firstIndex(where: { $0.id == newMessage.conversationId }) {
                        self.messagesController.conversations[row].messages.insert(Message(messageInfo: newMessage), at: 0)
                        if let selectedConversation = messagesController.selectedConversation {
                            self.messagesController.selectedConversation?.messages.insert(Message(messageInfo: newMessage), at: 0)
                        }
                    }
                }
            }
            
            
            
            
            if let deviceToken = UserDefaults.standard.string(forKey: "deviceTokenForSNS") {
                userManager.upsertUserDevice(deviceToken: deviceToken) { error in
                    if let error {
                        notificationController.setNotification(text: error, type: .error)
                    }
                }
            }
        }
    }
}

struct SessionView: View {
    @EnvironmentObject var userManager: UserManager
    @Binding var selectedIndex: Int
    
    var body: some View {
        NavigationView {
            NavigatorView(selectedIndex: $selectedIndex) { index in
                getTabView(selectedIndex: $selectedIndex, index: index)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationBarTitleDisplayMode(.inline)
            .safeAreaInset(edge: .top, content: {
                Color.clear
                    .frame(height: 0)
//                    .background(.bar)
                    .background(Color.gray1000)
                    .border(.black)
            })
        }
    }
    
    @ViewBuilder
    func getTabView(selectedIndex: Binding<Int>, index: Int) -> some View {
        // FIXME: for now it's walk around. which hides bottom navigation if it navigates to child
//        NavigationStackBackport.NavigationStack(path: $navigator.path) {
            ZStack {
                let type = TabBarType(rawValue: index) ?? .amoring
                switch type {
                case .nearby :
                    NearbyView()
                case .amoring:
                    AmoringView(selectedIndex: $selectedIndex)
                case .messages:
                    MessagesView()
                case .account:
                    AccountView()
                }
            }
//            .backport.navigationDestination(for: NavigatorPath.self) { screen in
//                navigator.navigate(screen: screen)
//            }
//        }
    }
}

//#Preview {
//    SessionView()
//}
