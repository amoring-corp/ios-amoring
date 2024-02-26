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
    
    var body: some View {
        Group {
            if amoringController.checkIn != nil {
                ProfilesView()
            } else {
                CheckInView()
            }
        }
        .onAppear {
            userManager.activeCheckIn { activeCheckIn in
                amoringController.checkIn = activeCheckIn
            }
        }
    }
}

//#Preview {
//    SessionView()
//}
