//
//  NavigationController.swift
//  amoring
//
//  Created by 이준녕 on 12/26/23.
//

import Foundation

import SwiftUI
import NavigationStackBackport

class NavigationController: ObservableObject {
    @Published var path = NavigationStackBackport.NavigationPath()
    @Published var selectedConversation: Conversation? = nil
    @Published var selectedBusiness: Business? = nil
    @Published var resultString: String? = nil
    
    @ViewBuilder
    func navigate(screen: NavigatorPath) -> some View {
        switch screen {
        case .listOfLikes:
            PeopleLikesView().environmentObject(self)
        case .conversation:
            ConversationView().environmentObject(self)
        case .business:
            BusinessDetailsView().environmentObject(self)
        case .checkInResult:
            CheckInResult().environmentObject(self)
            
        case .accountPhoto:
            AccountPhoto().environmentObject(self)
        case .accountBio:
            AccountBio().environmentObject(self)
        case .accountIntro:
            AccountIntro().environmentObject(self)
        case .accountInterests:
            AccountInterests().environmentObject(self)
        case .accountEmail:
            AccountEmail().environmentObject(self)
                }
    }
    
    func toRoot() {
        if !path.isEmpty {
            path.removeLast()
        }
    }
}

enum NavigatorPath: Hashable {
    case listOfLikes
    case conversation
    case business
    case checkInResult
    
    case accountPhoto
    case accountBio
    case accountIntro
    case accountInterests
    case accountEmail
}
