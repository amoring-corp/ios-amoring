//
//  BusinessEnterView.swift
//  amoring
//
//  Created by 이준녕 on 11/23/23.
//

import SwiftUI

struct BusinessEnterView: View {
    @EnvironmentObject var userManager: UserManager
    @EnvironmentObject var sessionManager: SessionManager
    @Binding var isLocked: Bool
    @State var password = ""
    @State var warning = false
    
    var body: some View {
        let user = userManager.user
        let business = user?.business
        VStack(alignment: .center, spacing: 20) {
            Text(business?.businessName ?? "NONAME")
            Text("To change settings Please re-enter your password")
            Text(user?.email ?? "NOEMAIL")
            CustomSecureField(text: $password)
            
            
            Text("Wrong password!")
                .foregroundColor(.red)
                .opacity(warning ? 1 : 0)
            
            Spacer()
            
            Button(action: sessionManager.signOut) {
                Text("Logout")
            }
            .padding(.vertical, 20)
            
            Button(action: {
                //                if password == "12345678" {
                withAnimation {
                    isLocked = false
                }
                //                } else {
                //                    warning = true
                //                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                //                        warning = false
                //                    }
                //                }
            }) {
                Text("Done")
            }
        }
    }
}

#Preview {
    BusinessEnterView(isLocked: .constant(false))
}
