//
//  NavigationAmoringController.swift
//  amoring
//
//  Created by 이준녕 on 12/4/23.
//

import SwiftUI
import AmoringAPI

class AmoringController: ObservableObject {
    @Published var selectedUser: UserInfo? = nil
//    @Published var amoring: Bool = false
    @Published var showDetails: Bool = false
    @Published var hidePanel: Bool = false
    @Published var checkIn: CheckInInfo? = nil
    @Published var countDown: TimeInterval? = nil
    @Published var profiles: [ProfileInfo] = []
    
    func leave() {
        withAnimation {
//            self.checkIn?.checkedOutAt = Date()
            self.checkIn = nil
        }
    }
}
