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
    // TODO: fetch this object when app starts
    @Published var checkIn: CheckInInfo? = nil
    @Published var countDown: TimeInterval? = nil

    // TODO: Not sure if this object should be here...
    @Published var likes: Int = 20
    
    func leave() {
        // TODO: Save to DB and delete current check in object
        withAnimation {
//            self.checkIn?.checkedOutAt = Date()
            self.checkIn = nil
        }
    }
}
