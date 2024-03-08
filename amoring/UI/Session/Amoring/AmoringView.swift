//
//  AmoringView.swift
//  amoring
//
//  Created by 이준녕 on 11/20/23.
//

import SwiftUI

struct AmoringView: View {
    @EnvironmentObject var amoringController: AmoringController
    @EnvironmentObject var userManager: UserManager
    @Binding var selectedIndex: Int
    
    var body: some View {
        Group {
            if amoringController.checkIn != nil {
                ProfilesView(selectedIndex: $selectedIndex)
            } else {
                CheckInView()
            }
        }
    }
}

//#Preview {
//    SessionView()
//}
