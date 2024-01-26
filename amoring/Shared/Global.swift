//
//  Global.swift
//  amoring
//
//  Created by 이준녕 on 1/4/24.
//

import SwiftUI

func closeKeyboard() {
    UIApplication.shared.sendAction(
        #selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil
    )
}

/// optional bindings (ex: $text ?? "default value")
func ??<T>(lhs: Binding<Optional<T>>, rhs: T) -> Binding<T> {
    Binding(
        get: { lhs.wrappedValue ?? rhs },
        set: { lhs.wrappedValue = $0 }
    )
}

func loadFileFromLocalPath(_ url: URL) -> Data? {
    let data = try? Data(contentsOf: url, options: .alwaysMapped)
   return data
}
