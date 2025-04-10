//
//  TestView.swift
//  amoring
//
//  Created by 이준녕 on 12/22/23.
//

import SwiftUI

struct TestView: View {
    @State var show = false
    
    var body: some View {
        Text("안녕하세요!")
        
    }
}

#Preview {
    TestView()
        .environment(\.locale, Locale(identifier: "ko"))
}
