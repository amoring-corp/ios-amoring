//
//  UserOnboardingView.swift
//  amoring
//
//  Created by 이준녕 on 11/21/23.
//

import SwiftUI
import NavigationStackBackport

struct UserOnboardingView: View {
    @StateObject var controller: UserOnboardingController = UserOnboardingController()
    
    var body: some View {
        NavigationStackBackport.NavigationStack {
            ZStack {
                UserOnboardingName()
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

class UserOnboardingController: ObservableObject {
    @Published var userProfile: UserProfile = UserProfile(id: "", images: [], interests: [])
}

#Preview {
    UserOnboardingView()
}
