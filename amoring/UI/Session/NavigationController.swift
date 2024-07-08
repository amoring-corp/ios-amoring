//
//  NavigationController.swift
//  amoring
//
//  Created by Sergey Li on 4/4/24.
//

import SwiftUI

class NavigationController: ObservableObject {
    @Published var barAppear: Bool = true
    @Published var goToBusinessDetails = false
    @Published var goToUserDetails = false
    @Published var goToPhotoDetails = false
    
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
