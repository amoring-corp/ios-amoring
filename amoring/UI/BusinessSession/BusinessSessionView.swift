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
    @EnvironmentObject var notificationController: NotificationController
    @StateObject var businessSessionController = BusinessSessionController()
    
    @State var xOffset: CGFloat = 0
    @State var isLoading = false
    @State var expired = false
    @State var qrcode: QRCode.Document? = nil
    
    @State var timer: Timer? = nil
    
    var body: some View {
        let business = userManager.user?.business
        GeometryReader { geometry in
            NavigationView {
                VStack(spacing: 0) {
                    Text(business?.businessName ?? "AMORING")
                        .font(extraBold28Font)
                        .foregroundColor(.yellow200)
                        .padding(.top, Size.w(32))
                        .padding(.bottom, Size.w(12))
                    
                    Text("지금 당장, 아모링 라운지에 체크인 하세요!")
                        .font(regular16Font)
                        .foregroundColor(.yellow300)
                        .padding(.bottom, Size.w(40))
                    
                    ZStack {
                        VStack(spacing: 0) {
                            ZStack {
                                if isLoading {
                                    ProgressView()
                                } else {
                                    if let qrcode = qrcode {
                                        QRCodeDocumentUIView(document: qrcode)
                                        // MARK: TESTS
                                            .onTapGesture {
                                                withAnimation {
                                                    self.expired.toggle()
                                                }
                                            }
                                    }
                                }
                            }
                            .frame(width: geometry.size.height / 2.7, height: geometry.size.height / 2.7)
                            .padding(7)
                            .background(Color.white)
                            .cornerRadius(20)
                            .padding(.bottom, Size.h(32))
                            
                            Spacer()
                            
                            Text("지금 아모링 라운지에서\n다른 회원님들이 회원님의 등장을 기다리고 있습니다.")
                                .multilineTextAlignment(.center)
                                .lineSpacing(6)
                                .font(regular16Font)
                                .foregroundColor(.yellow300)
                            
                            let images = ["person-1", "person-2", "person-3", "person-4"]
                            
                            let size = geometry.size.width / 2
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: Size.w(16)) {
                                    list(images: images, size: size)
                                    list(images: images, size: size)
                                    list(images: images, size: size)
                                    list(images: images, size: size)
                                }
                                .offset(x: xOffset)
                            }
                            .disabled(true)
                            .padding(.top, Size.w(22))
                            .onAppear {
                                setToken()
                                withAnimation(.linear(duration: Double(images.count * 4)).repeatForever(autoreverses: false)) {
                                    xOffset = -size * Double(images.count)
                                }
                            }
                        }
                        
                        if expired {
                            Color.black.background(.ultraThinMaterial).opacity(0.7)
                            
                            VStack {
                                Text("😥")
                                    .font(semiBold60Font)
                                    .padding(.top, Size.w(120))
                                    .padding(.bottom, Size.w(22))
                                Text("죄송합니다.\n준비된 라운지가 꽉 찼어요\n나중에 체크인 해주세요")
                                    .font(semiBold28Font)
                                    .foregroundColor(.yellow350)
                                    .multilineTextAlignment(.center)
                                    .lineSpacing(6)
                                // MARK: TESTS
                                    .onTapGesture {
                                        withAnimation {
                                            self.expired.toggle()
                                        }
                                    }
                                
                                Spacer()
                                
                                HStack {
                                    Spacer()
                                    NavigationLink(destination: {
                                        //TODO: open purchases
                                        Text("Purchases")
                                    }) {
                                        YellowButton(title: "확장하기")
                                    }
                                }
                            }
                            .padding(.horizontal, Size.w(22))
                        }
                    }
                    .padding(.bottom, Size.w(30))
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("AMORING")
                            .font(bold20Font)
                            .foregroundColor(.yellow300)
                          
                    }
                }
                .navigationBarItems(trailing:
                                        NavigationLink(destination: {
                    MenuView().environmentObject(businessSessionController)
                }) {
                    Image("ic-hamburger")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32, height: 32)
                })
            } //  geometryreader
        }
        .overlay(
            businessSessionController.showDepositInfo ?
            DepositInfoView().environmentObject(businessSessionController)
                .transition(.move(edge: .bottom))
            : nil
        )
    }
    
    func list(images: [String], size: CGFloat) -> some View {
        let inSize = size < 20 ? size : (size - 20)
        return ForEach(0..<images.count, id: \.self) {
            Image(images[$0])
                .resizable()
                .scaledToFill()
                .blur(radius: 6)
                .frame(width: 90, height: 120)
                .background(Color.gray)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .overlay(
                    RoundedRectangle(cornerRadius: 15).stroke(Color.yellow700)
                )
                .padding(1)
//                .frame(width: size, height: size)
        }
    }
    
    private func setToken() {
        userManager.generateCheckInToken { error, token in
            if let error {
                self.qrcode = nil
                notificationController.setNotification(text: error, type: .error)
            } else {
                self.isLoading = true
                let qrcodeDoc: QRCode.Document = {
                    let doc = QRCode.Document(generator: QRCodeGenerator_External())
                    doc.utf8String = token
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
                
                let timer = Timer.scheduledTimer(withTimeInterval: 60 * 2, repeats: true, block: { timer in
                    print("updating token ...")
                    self.setToken()
                    timer.invalidate()
//                    self.setToken()
                })
            }
        }
    }
}

#Preview {
    BusinessSessionView()
}
