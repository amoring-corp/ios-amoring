//
//  PhoneAuthController.swift
//  amoring
//
//  Created by Sergey Li on 7/20/24.
//

import Foundation

class PhoneAuthController: ObservableObject {
    @Published var phone: String? = nil
    @Published var otp: String = ""
}
