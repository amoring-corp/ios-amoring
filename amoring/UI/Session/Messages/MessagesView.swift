//
//  MessagesView.swift
//  amoring
//
//  Created by 이준녕 on 11/20/23.
//

import SwiftUI

struct MessagesView: View {
    @EnvironmentObject var controller: MessagesController
    @EnvironmentObject var userManager: UserManager
    @EnvironmentObject var notificationController: NotificationController
    
    @State var torchIsOn = false
    @State var haveTable = false
    @State var resultString: String? = nil
    
    var body: some View {
            VStack(alignment: .center, spacing: 0) {
                if !controller.reactions.isEmpty {
                    NavigationLink(destination: {
                        PeopleLikesView()
                    }) {
                        ListOfPeopleLikesLink()
                    }
                }
                
                ListOfConversations()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(.gray1000)
            .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    CheckInView()
}
