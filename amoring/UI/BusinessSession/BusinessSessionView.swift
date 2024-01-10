//
//  BusinessSessionView.swift
//  amoring
//
//  Created by 이준녕 on 11/22/23.
//

import SwiftUI

struct BusinessSessionView: View {
    @State var xOffset: CGFloat = 0
    
    var body: some View {
        GeometryReader { geometry in
        NavigationView {
       
                VStack {
                    Spacer()
                    
                    ZStack {
                        Color.gray
                        Text("QR CODE")
                    }
                    .frame(width: 200, height: 200)
                    .cornerRadius(30)
                    
                    Spacer()
                    
                    Text("Users currently logged in")
                    
                    let images = ["person-1", "person-2", "person-3", "person-4"]
                    
                    
                    let size = geometry.size.width / 2
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 0) {
                            list(images: images, size: size)
                            list(images: images, size: size)
                            list(images: images, size: size)
                            list(images: images, size: size)
                        }
                        .padding(.vertical, 100)
                        .offset(x: xOffset, y: 0)
                    }
                    .disabled(true)
                    .onAppear {
                        withAnimation(.linear(duration: Double(images.count * 4)).repeatForever(autoreverses: false)) {
                            xOffset = -size * Double(images.count)
                        }
                    }
                    Spacer()
                }
                .navigationBarItems(trailing:
                                        NavigationLink(destination: {
                    MenuView()
                }) {
                    Image(systemName: "line.3.horizontal")
                        .foregroundColor(.gray600)
                })
            } //  geometryreader
        }
    }
    
    func list(images: [String], size: CGFloat) -> some View {
        let inSize = size < 20 ? size : (size - 20)
        return ForEach(0..<images.count, id: \.self) {
            Image(images[$0])
                .resizable()
                .scaledToFill()
                .blur(radius: 6)
                .frame(width: inSize, height: inSize)
                .background(Color.gray)
                .cornerRadius(15)
                .frame(width: size, height: size)
        }
    }
}

#Preview {
    BusinessSessionView()
}
