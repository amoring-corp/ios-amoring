//
//  UserOnboardingView.swift
//  amoring
//
//  Created by 이준녕 on 11/21/23.
//

import SwiftUI
import NavigationStackBackport

struct UserOnboardingView: View {
    @StateObject var userOnboardingController: UserOnboardingController = UserOnboardingController()
    
    var body: some View {
        NavigationStackBackport.NavigationStack {
            ZStack {
                UserOnboardingName()
            }
            .navigationBarTitleDisplayMode(.inline)
        }
        .environmentObject(userOnboardingController)
    }
}

class UserOnboardingController: ObservableObject {
    @Published var profile: Profile = Profile(id: "", images: [], interests: [])
    @Published var pictures: [PictureModel] = []
    @Published var selectedInterests: [(String, String)] = []
}

#Preview {
    UserOnboardingView()
}
