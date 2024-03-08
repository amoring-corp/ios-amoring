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
//            .toolbar {
//                ToolbarItem(placement: .principal) {
//                    Text("AMORING")
//                        .font(bold20Font)
//                        .foregroundColor(.yellow300)
//                }
//            }
//            .navigationBarItems(trailing:
//                                    Button(action: {
//            }) {
//                Image("ic-info")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: Size.w(32), height: Size.w(32))
//            }
//            )
            .environmentObject(controller)
            .onAppear {
                userManager.getConversations { conversations in
                    if let conversations {
                        self.controller.conversations = conversations
                        
                    }
                }
            }
    }
}

#Preview {
    CheckInView()
}
