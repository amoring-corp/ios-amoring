//
//  AppState.swift
//  amoring
//
//  Created by 이준녕 on 1/16/24.
//

import Foundation

enum AppState {
    case auth
    case loading
    case session(user: User)
    case error
}

enum UserState {
    case initial
    case userOnboarding
//    case imageUploading
//    case interestsConnection
    case session
    case businessOnboarding
    case businessSession
    case debugging
    case error
}
