//
//  BusinessSessionView.swift
//  amoring
//
//  Created by 이준녕 on 11/22/23.
//

import SwiftUI
import QRCode

struct BusinessSessionView: View {
    @EnvironmentObject var userManager: UserManager
    
    @State var xOffset: CGFloat = 0
    @State var isLoading = false
    @State var expired = false
    @State var qrcode: QRCode.Document? = nil
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                VStack {
                    Spacer()
                    
                    ZStack {
                        if isLoading {
                            ProgressView()
                        } else {
                            if let qrcode = qrcode {
                                ZStack {
                                    QRCodeDocumentUIView(document: qrcode)
                                        .blur(radius: expired ? 3 : 0)
                                        .opacity(expired ? 0.4 : 1)
                                    if expired {
                                        Button(action: {}) {
                                            Image("ic-error-refresh")
                                                .resizable()
                                                .foregroundColor(.white)
                                                .scaledToFit()
                                                .frame(width: Size.w(60), height: Size.w(60))
                                                .padding(10)
                                                .background(Color.green400)
                                                .frame(width: Size.w(80), height: Size.w(80))
                                                .clipShape(Circle())
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .frame(width: Size.w(200), height: Size.w(200))
                    .padding(7)
                    .background(Color.white)
                    .cornerRadius(15)
                    .padding(.bottom, Size.h(32))
                    
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
                        initialize()
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
    
    private func initialize() {
//        guard let name = userManager.user?.business?.businessName else { return }
        let name = "AMORING"
        self.isLoading = true
        
//        let contact = QRContact(id: id, n: userManager.apiNodeUser.name, f: userManager.apiNodeUser.familyName, e: email, d: expirationDate)
//        let jsonEncoder = JSONEncoder()
        do {
//            let jsonData = try jsonEncoder.encode(contact)
//            if let json = String(data: jsonData, encoding: String.Encoding.utf8) {
                let qrcodeDoc: QRCode.Document = {
                    let doc = QRCode.Document(generator: QRCodeGenerator_External())
                    doc.utf8String = name
                    doc.design.shape.onPixels = QRCode.PixelShape.Squircle(insetFraction: 0.1)
                    doc.design.shape.eye = QRCode.EyeShape.Squircle()
                    doc.errorCorrection = .high
                    let image = UIImage(named: "LOGO")!
                    
                    // Centered square logo
                    doc.logoTemplate = QRCode.LogoTemplate(
                        image: image.cgImage!,
                        path: CGPath(rect: CGRect(x: 0.40, y: 0.40, width: 0.20, height: 0.20), transform: nil),
                        inset: 2
                    )
                    return doc
                }()
                self.qrcode = qrcodeDoc
//            }
            withAnimation {
                isLoading = false
            }
        } catch {
            withAnimation {
                isLoading = false
            }
            print("Error while encoding to json!")
        }
    }
}

#Preview {
    BusinessSessionView()
}
