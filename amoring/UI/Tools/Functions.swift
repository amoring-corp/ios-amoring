//
//  Functions.swift
//  amoring
//
//  Created by Sergey Li on 4/30/24.
//

import SwiftUI

struct ScrollOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}
