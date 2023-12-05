//
//  BusnessSettings.swift
//  amoring
//
//  Created by 이준녕 on 11/23/23.
//

import SwiftUI

struct BusnessSettings: View {
    @EnvironmentObject var sessionManager: SessionManager
    
    @State var someText = ""
    @State var showDistacne = false
    @State var showNumber = false
    @State var showGenderRatio = false
    @State var showMatching = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 20) {
                Text("Please enter your business information")
                Text("Basic Information")
                CustomTextField("Name", text: $someText)
                CustomTextField("Address", text: $someText)
                CustomTextField("Sectors", text: $someText)
                CustomTextField("representative", text: $someText)
                CustomTextField("contact", text: $someText)
                CustomTextField("Company Registration Number", text: $someText)
                
                Divider()
                
                Text("Listing Settings")
                Button(action: {}) {
                    Text("Edit")
                }
                
                Toggle(isOn: $showDistacne) { Text("Show distance") }
                Toggle(isOn: $showNumber) { Text("Show number of people") }
                Toggle(isOn: $showGenderRatio) { Text("Show gender ratio") }
                Toggle(isOn: $showMatching) { Text("Show matching probability") }
                
                Text("images")
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(0..<12) { _ in
                            Color.gray
                                .frame(width: 200, height: 200)
                                .cornerRadius(20)
                        }
                    }
                }
                
                Button(action: {
                    // reset password
                }) {
                    Text("Reset password")
                }
                
                Button(action: {
                    withAnimation {
                        sessionManager.signedIn = false
                        sessionManager.isBusiness = false
                    }
                }) {
                    Text("Logout")
                }
                
                Button(action: {
                    // Delete account
                }) {
                    Text("Delete account")
                }
            }
            .padding(.horizontal, 16)
        }
        
    }
}

#Preview {
    BusnessSettings()
}