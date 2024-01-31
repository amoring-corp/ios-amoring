//
//  SignInTooltip.swift
//  amoring
//
//  Created by 이준녕 on 1/25/24.
//

import SwiftUI

struct SignInTooltip: View {
    let provider: lastProvider
    @State var hideLastProvider: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            Triangle()
                .foregroundColor(.gray100)
                .frame(width: 10, height: 10)
            Text("마지막으로\n로그인한 계정이예요~")
                .font(medium14Font)
                .foregroundColor(.gray900)
                .multilineTextAlignment(.center)
                .padding(Size.w(16))
                .background(Color.gray100)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .offset(x: provider == .google ? Size.w(45) : (provider == .facebook ? Size.w(-45): 0))
        }
        .fixedSize()
        .opacity(hideLastProvider ? 0.1 : 1)
        .offset(y: Size.w(54 + 26))
        .onTapGesture {
            withAnimation {
                hideLastProvider.toggle()
            }
        }
    }
}

#Preview {
    SignInTooltip(provider: .google)
}
