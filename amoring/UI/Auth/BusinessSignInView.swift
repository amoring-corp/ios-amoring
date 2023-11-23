//
//  BusinessSignIn.swift
//  amoring
//
//  Created by 이준녕 on 11/20/23.
//

import SwiftUI

struct BusinessSignInView: View {
    @State var email: String = ""
    @State var password: String = ""
    
    var body: some View {
        VStack {
            Spacer()
            
            TextField("", text: $email)
                .textFieldStyle(.roundedBorder)
            SecureField("", text: $password)
                .textFieldStyle(.roundedBorder)
            Spacer()
            
            Button(action: {
                // business sign in
            }) {
                Text("Business sign in")
            }
            
            Spacer()
            
            NavigationLink(destination: {
                BusinessSignUp()
            }) {
                Text("Business sign Up")
            }
        }
        .padding(16)
    }
}

#Preview {
    BusinessSignInView()
}
