//
//  AddImageView.swift
//  amoring
//
//  Created by 이준녕 on 11/21/23.
//

import SwiftUI

struct AddImageView: View {
    @State private var isTapped: Bool = false
    let number: Int
    let action: () -> ()
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Spacer()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .aspectRatio(1, contentMode: .fit)
                .background(Color.white)
                .cornerRadius(8)
            Text(number.description)
                .font(semiBold16Font)
                .foregroundColor(.white)
                .frame(width: Size.w(24), height: Size.w(24))
                .background(Color.black.opacity(0.3))
                .clipShape(Circle())
                .padding(Size.w(10))
        }
        .frame(minWidth: Size.w(106), minHeight: Size.w(106))
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .frame(maxWidth: number == 1 ? .infinity : Size.w(106), maxHeight: number == 1 ? .infinity : Size.w(106))
        .overlay(
            Image(systemName: "plus")
                .font(bold24Font)
                .foregroundColor(.gray200)
        )
        .opacity(isTapped ? 0.5 : 1)
        .scaleEffect(isTapped ? 0.9 : 1)
        .padding(Size.w(8))
        .gesture(
            TapGesture()
                .onEnded{ _ in
                    print("on End Tap")
                    withAnimation(Animation.linear(duration: 0.1)){
                        self.isTapped = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        self.isTapped = false
                        action()
                    }
                })
    }
}

struct AddImageView_Previews: PreviewProvider {
    static var previews: some View {
        AddImageView(number: 1) {
            
        }
    }
}


extension View {
    public func foregroundGradient(colors: [Color]) -> some View {
        self.overlay(LinearGradient(gradient: .init(colors: colors),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing))
            .mask(self)
    }
    
    @ViewBuilder
    public func showLoading(_ showLoading: Bool) -> some View{
        self.allowsHitTesting(!showLoading)
        .overlay(ProgressView().frame(maxWidth: .infinity, maxHeight: .infinity).background(Color(UIColor.systemGray5)).opacity( showLoading ? 0.75 : 0.0))
    }
}
