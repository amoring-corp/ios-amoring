//
//  NavigationAuthController.swift
//  amoring
//
//  Created by 이준녕 on 12/4/23.
//

import SwiftUI
import NavigationStackBackport

class NavigationAuthController: ObservableObject {
    @Published var path = NavigationStackBackport.NavigationPath()
    
    func toRoot() {
        path.removeLast()
    }
    
    func toBusinessSignIn() {
        path.append(AuthPath.businessSignIn)
    }
    
    func toBusinessSignUp() {
        path.append(AuthPath.businessSignUp)
    }
    
    func toPhoneValidation() {
        path.append(AuthPath.phoneValidation)
    }
    
    func navigate(screen: AuthPath) -> some View {
        ZStack {
            switch screen {
            case .businessSignIn:
                Text("Business Sign IN").environmentObject(self)
            case .businessSignUp:
                Text("Sign Up").environmentObject(self)
            case .phoneValidation:
                Text("Phone Validation").environmentObject(self)
            }
        }
    }
}

enum AuthPath: Hashable {
    case businessSignIn, businessSignUp, phoneValidation
}
