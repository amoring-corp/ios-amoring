//
//  SessionView.swift
//  amoring
//
//  Created by 이준녕 on 11/20/23.
//

import SwiftUI
import NavigationStackBackport
import AmoringAPI

struct SessionFlow: View {
    @EnvironmentObject var sessionManager: SessionManager
    @EnvironmentObject var notificationController: NotificationController
    @EnvironmentObject var scenePhaseHelper: ScenePhaseHelper
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
        .overlay(
            notificationController.reaction != nil ? NewMatchNotification(reaction: notificationController.reaction!).transition(.move(edge: .bottom)) : nil
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
                if let activeCheckIn {
                    userManager.getReactions { error, reactions in
                        if let error {
                            notificationController.setNotification(text: error, type: .error)
                        } else {
                            messagesController.reactions = reactions
                        }
                    }
                }
                amoringController.checkIn = activeCheckIn
            }
            
            /// in App Purchases
            purchaseController.fetchProducts()
            
//            if self.messagesController.conversations.isEmpty {
                userManager.getConversations { conversations in
                    if let conversations {
                        self.messagesController.conversations = conversations.compactMap({ Conversation(conversationInfo: $0) })
                        
                    }
                }
//            }
            
            // MARK: all subscriptions
            subscriptions()

        }
    }
    
    private func goToCurrentMessage(newMessage: MessageInfo) {
        DispatchQueue.main.async {
            self.selectedIndex = 2
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.messagesController.selectedConversation = self.messagesController.conversations.first(where: { $0.id == newMessage.conversationId })
            withAnimation {
                self.messagesController.goToConversation = messagesController.selectedConversation != nil
            }
        }
    }
    
    private func subscriptions() {
        userManager.messageSubscription { newMessage in
            if let newMessage {
//                if scenePhaseHelper.scenePhase != .active {
//                    notificationController.setInnerPushNotification(newMessage: newMessage)
//                    notificationController.onTapOnPush = { goToCurrentMessage(newMessage: newMessage) }
//                    
//                } else {
//                    if !self.messagesController.goToConversation {
//                        notificationController.setNotification(title: newMessage.sender?.profile?.name, text: newMessage.body, type: .message, action: { goToCurrentMessage(newMessage: newMessage) } )
//                    }
//                }
                
                if self.messagesController.selectedConversation != self.messagesController.conversations.first(where: { $0.id == newMessage.conversationId }) {
                    notificationController.setInnerPushNotification(newMessage: newMessage)
                    notificationController.goToCurrentConversation = { goToCurrentMessage(newMessage: newMessage) }
                }
                
                if let row = self.messagesController.conversations.firstIndex(where: { $0.id == newMessage.conversationId }) {
                    self.messagesController.conversations[row].messages.insert(Message(messageInfo: newMessage), at: 0)
                    if messagesController.selectedConversation != nil {
                        self.messagesController.selectedConversation?.messages.insert(Message(messageInfo: newMessage), at: 0)
                    }
                } else {
                    print("SessionView: finding proper conversation error!")
                }
            }
        }
        
        userManager.reactionSubscription { reaction in
            if let reaction {
                if reaction.isMatched {
                    withAnimation {
                        notificationController.reaction = reaction
                    }
                    
                    notificationController.goToConversationsList = {
                        DispatchQueue.main.async {
                            self.selectedIndex = 2
                        }
                    }
                    
                    userManager.getConversations { conversations in
                        if let conversations {
                            self.messagesController.conversations = conversations.compactMap({ Conversation(conversationInfo: $0) })
                        }
                    }
                } else {
                    // TODO: need tests
                    withAnimation {
                        messagesController.reactions.insert(reaction, at: 0)
                    }
                }
                print(reaction.byProfile.fragments.profileInfo)
            }
        }
        
        userManager.conversationSubscription { id, deletedBy in
            if let id, let deletedBy {
                notificationController.setNotification(text: "Conversation with \(deletedBy) was deleted!", type: .text)
                messagesController.conversations.removeAll(where: { $0.id == id })
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
