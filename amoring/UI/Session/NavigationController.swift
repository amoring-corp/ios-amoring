//
//  NavigationController.swift
//  amoring
//
//  Created by Sergey Li on 4/4/24.
//

import SwiftUI
import AmoringAPI

class NavigationController: ObservableObject {
    @Published var barAppear: Bool = true
    @Published var goToBusinessDetails = false
    @Published var goToUserDetails = false
    @Published var goToUserDetailsFromList = false
    @Published var goToPhotoDetails = false
    @Published var selectedProfile: ProfileInfo? = nil
    
    func hideBar() {
        withAnimation {
            barAppear = false
        }
    }
    
    func showBar() {
        if !goToBusinessDetails && !goToUserDetails {
            withAnimation {
                barAppear = true
            }
        }
    }
}
