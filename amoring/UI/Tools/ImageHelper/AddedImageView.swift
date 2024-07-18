//
//  AddedImageView.swift
//  amoring
//
//  Created by 이준녕 on 11/21/23.
//

import SwiftUI

struct AddedImageView: View {
    @EnvironmentObject var userManager: UserManager
    @State private var isTapped: Bool = false
    let image: UIImage
    let number: Int
    let action: () -> ()
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image(uiImage: image)
                .centerCropped()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .aspectRatio(1, contentMode: .fit)
                .background(.gray100)
                .blur(radius: userManager.blurring ? 6 : 0)
                .cornerRadius(8)
                
            Text(number.description)
                .font(semiBold16Font)
                .foregroundColor(.white)
                .frame(width: Size.w(24), height: Size.w(24))
                .background(Color.black.opacity(0.3))
                .clipShape(Circle())
                .padding(Size.w(10))
        }
        .frame(minWidth: Size.w(106))
        .padding(Size.w(8))
        .opacity(isTapped ? 0.5 : 1)
        .scaleEffect(isTapped ? 0.9 : 1)
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

extension Image {
    func centerCropped() -> some View {
        GeometryReader { geo in
            self
            .resizable()
            .scaledToFill()
//            .frame(width: geo.size.width, height: geo.size.height)
            .frame(width: geo.size.width, height: geo.size.width)
            .clipped()
        }
    }
}

struct AddedImageView_Previews: PreviewProvider {
    static var previews: some View {
        AddedImageView(image: UIImage(named: "jeff_bezos")!, number: 1){
            
        }
    }
}

