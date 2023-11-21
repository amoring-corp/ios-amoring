//
//  UserOnboardingStep6.swift
//  amoring
//
//  Created by 이준녕 on 11/21/23.
//

import SwiftUI

struct UserOnboardingStep6: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Step6")
            Text("TERMS and AGREEMENTS")
            
            NavigationLink(destination: { UserOnboardingStep7() }) {
                Text("Next")
            }
        }
    }
}

#Preview {
    UserOnboardingStep6()
}
