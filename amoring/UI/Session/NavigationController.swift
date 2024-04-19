//
//  NavigationController.swift
//  amoring
//
//  Created by Sergey Li on 4/4/24.
//

import SwiftUI

class NavigationController: ObservableObject {
    @Published var barAppear: Bool = true
    
    func hideBar() {
        withAnimation {
            barAppear = false
        }
    }
    
    func showBar() {
        withAnimation {
            barAppear = true
        }
    }
}
