//
//  BusinessOnboardingController.swift
//  amoring
//
//  Created by 이준녕 on 1/12/24.
//

import Foundation

class BusinessSignUpController: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var confirmCode: String = ""
}
