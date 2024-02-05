//
//  MessagesView.swift
//  amoring
//
//  Created by 이준녕 on 11/20/23.
//

import SwiftUI

struct MessagesView: View {
    @EnvironmentObject var messageController: MessagesController
    
    @State var torchIsOn = false
    @State var haveTable = false
    @State var resultString: String? = nil
    
    var body: some View {
            VStack(alignment: .center, spacing: 0) {
                if !messageController.reactions.isEmpty {
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
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("AMORING")
                        .font(bold20Font)
                        .foregroundColor(.yellow300)
                }
            }
            .navigationBarItems(trailing:
                                    Button(action: {
            }) {
                Image("ic-info")
                    .resizable()
                    .scaledToFit()
                    .frame(width: Size.w(32), height: Size.w(32))
            }
            )
            .environmentObject(messageController)
    }
}

#Preview {
    CheckInView()
}
