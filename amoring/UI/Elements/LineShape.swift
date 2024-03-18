//
//  LineShape.swift
//  amoring
//
//  Created by Sergey Li on 3/18/24.
//

import SwiftUI

struct LineShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        return path
    }
}
