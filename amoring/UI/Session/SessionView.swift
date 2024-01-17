//
//  SessionView.swift
//  amoring
//
//  Created by 이준녕 on 11/20/23.
//

import SwiftUI
import NavigationStackBackport

struct SessionFlow: View {
    @StateObject var userManager: UserManager
    @EnvironmentObject var sessionManager: SessionManager
    
    var body: some View {
        ZStack {
            switch userManager.userState {
            case .initial:
                EmptyView()
            case .userOnboarding:
                UserOnboardingView()
//            case .imageUploading:
//                UserOnboardingPhoto()
//            case .interestsConnection:
//                UserOnboardingIntro()
            case .session:
                SessionView()
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
                        sessionManager.changeStateWithAnimation(state: .auth)
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
        .environmentObject(userManager)
    }
}

struct SessionView: View {
    @EnvironmentObject var userManager: UserManager
    @EnvironmentObject var navigator: NavigationController
    
    var body: some View {
        NavigatorView { index in
            getTabView(index: index)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    @ViewBuilder
    func getTabView(index: Int) -> some View {
        // FIXME: for now it's walk around. which hides bottom navigation if it navigates to child
        NavigationStackBackport.NavigationStack(path: $navigator.path) {
            ZStack {
                let type = TabBarType(rawValue: index) ?? .amoring
                switch type {
                case .nearby :
                    NearbyView()
                case .amoring:
                    AmoringView()
                case .messages:
                    MessagesView()
                case .account:
                    AccountView()
                }
            }
            .backport.navigationDestination(for: NavigatorPath.self) { screen in
                navigator.navigate(screen: screen)
            }
        }
    }
}

#Preview {
    SessionView()
}
