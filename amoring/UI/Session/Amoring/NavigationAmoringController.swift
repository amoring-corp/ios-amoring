//
//  NavigationAmoringController.swift
//  amoring
//
//  Created by 이준녕 on 12/4/23.
//

import SwiftUI

class AmoringController: ObservableObject {
    @Published var selectedUser: User? = nil
//    @Published var amoring: Bool = false
    @Published var showDetails: Bool = false
    @Published var hidePanel: Bool = false
    // TODO: fetch this object when app starts
    @Published var checkIn: CheckIn? = nil
    @Published var countDown: TimeInterval? = nil

    func leave() {
        // TODO: Save to DB and delete current check in object
        withAnimation {
            self.checkIn?.checkedOutAt = Date()
            self.checkIn = nil
        }
    }
}
