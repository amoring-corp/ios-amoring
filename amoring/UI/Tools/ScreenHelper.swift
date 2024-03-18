//
//  ScreenHelper.swift
//  amoring
//
//  Created by 이준녕 on 11/20/23.
//


import SwiftUI

class DeviceHelper {
    public static var isIPad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
}

class Size {
    static let screen = UIScreen.main.bounds
    
    // MARK: - Size funcs (default - iPhone 14,15 Pro screen size, iPad 9.7-inch)
    static func w(_ size: CGFloat, sizeForRotation: CGSize? = nil) -> CGFloat {
        var screenWidth = UIScreen.main.bounds.width
        if let sizeForRotation = sizeForRotation {
            screenWidth = sizeForRotation.width
        }
        
        return (size * screenWidth) / (DeviceHelper.isIPad ? 768 : 393 )
    }
    
    static func h(_ size: CGFloat, sizeForRotation: CGSize? = nil) -> CGFloat {
        var screenHeight = UIScreen.main.bounds.height
        if let sizeForRotation = sizeForRotation {
            screenHeight = sizeForRotation.height
        }
        
        return (size * screenHeight) / (DeviceHelper.isIPad ? 1024 : 852)
    }
    
    static func safeArea() -> (top: CGFloat, bottom: CGFloat) {
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        if let window = windowScene?.windows.first {
            return (window.safeAreaInsets.top, window.safeAreaInsets.bottom)
        } else {
            switch Size.type {
            case .button: return (20, 0)
            case .mini: return (50, 34)
            case .notch: return (44, 34)
            case .island: return (59, 34)
            }
        }
    }
    
    static let statusBarHeight: CGFloat = 44
    
    static var type: iPhoneType {
        if UIScreen.main.bounds.height / UIScreen.main.bounds.width < 2 {
            return .button
        } else {
            if UIDevice().name.contains("mini") {
                return .mini
            } else if UIDevice().name.contains("14") && UIDevice().name.contains("Pro") {
                return .island
            } else {
                return .notch
            }
        }
    }
    
    static var isNotch: Bool {
        Size.type != .button
    }
}

enum iPhoneType {
    case button, mini, notch, island
}
