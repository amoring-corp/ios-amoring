//
//  BusinessDetailsView.swift
//  amoring
//
//  Created by 이준녕 on 12/28/23.
//

import SwiftUI
import UniformTypeIdentifiers
import CachedAsyncImage

struct BusinessDetailsView: View {
    @EnvironmentObject var navigator: NavigationController
    @State var showPhotoViewer = false
    @State var selection: Int = 0
    @State var showAlert: Bool = false
    
    var body: some View {
        if let business = navigator.selectedBusiness {
            VStack {
                ScrollView {
                    VStack(spacing: 0) {
                        Divider()
                            .padding(.top, Size.w(16))
                            .padding(.bottom, Size.w(40))
                        
                        VStack(spacing: 0) {
                            let url = business.images?.first
                            
                            CachedAsyncImage(url: URL(string: url ?? ""), content: { cont in
                                cont
                                    .resizable()
                                    .scaledToFill()
                            }, placeholder: {
                                ZStack {
                                    ProgressView().progressViewStyle(CircularProgressViewStyle(tint: Color.gray1000))
                                }
                            })
                            .frame(width: Size.w(90), height: Size.w(90))
                            .clipShape(RoundedRectangle(cornerRadius: 14))
                            .overlay(
                                RoundedRectangle(cornerRadius: 14).stroke(Color.yellow700)
                            )
                            .padding(.bottom, Size.w(30))
                            
                            Text(business.name ?? "")
                                .font(extraBold28Font)
                                .foregroundColor(.yellow200)
                                .padding(.bottom, Size.w(12))
                            
                            Text("\(business.type ?? "")  |  \(business.district ?? "")")
                                .font(regular18Font)
                                .foregroundColor(.yellow200)
                                .padding(.bottom, Size.w(30))
                            
                            Text(business.description ?? "")
                                .font(regular16Font)
                                .foregroundColor(.yellow300)
                                .lineSpacing(6)
                                .multilineTextAlignment(.center)
                                .padding(.bottom, Size.w(40))
                            
                            VStack(alignment: .leading, spacing: Size.w(26)) {
                                Button(action: {
                                    if let address = business.address {
                                        UIPasteboard.general.setValue(address, forPasteboardType: UTType.plainText.identifier)
                                            showAlert = true
                                    }
                                }) {
                                    HStack {
                                        Image("ic-pin")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: Size.w(24), height: Size.w(24))
                                        Text(business.address ?? "")
                                        Image(systemName: "doc.on.doc")
                                    }
                                }
                                .alert(isPresented: $showAlert) {
                                    // FIXME: Need alert text
                                    Alert(title: Text("Address: '\(business.address ?? "")' successfully copied to clipboard"))
                                }
                                
                                if let phone = business.phone {
                                    Button(action: {
                                        let telephone = "tel://"
                                        let formattedString = telephone + phone
                                        guard let url = URL(string: formattedString) else { return }
                                        UIApplication.shared.open(url)
                                    }) {
                                        HStack {
                                            Image("ic-phone")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: Size.w(24), height: Size.w(24))
                                            Text(phone)
                                        }
                                    }
                                }
                               
                                
                                HStack {
                                    Image("ic-clock")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: Size.w(24), height: Size.w(24))
                                    Text("\(business.open.toTime()) - \(business.close.toTime())")
                                    Spacer()
                                }
                            }
                            .foregroundColor(.yellow400)
                            .font(regular16Font)
                            .padding(.bottom, Size.w(50))
                            
                            if let images = business.images {
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack {
                                        ForEach(Array(images.enumerated()), id: \.offset) { index, element in
                                            CachedAsyncImage(url: URL(string: element), content: { cont in
                                                cont
                                                    .resizable()
                                                    .scaledToFill()
                                            }, placeholder: {
                                                ZStack {
                                                    ProgressView().progressViewStyle(CircularProgressViewStyle(tint: Color.gray1000))
                                                }
                                            })
                                            .frame(width: Size.w(120), height: Size.w(120))
                                            .clipShape(RoundedRectangle(cornerRadius: 14))
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 14).stroke(Color.yellow700)
                                            )
                                            .padding(5)
                                            .onTapGesture {
                                                self.selection = index
                                                showPhotoViewer = true
                                            }
                                        }
                                    }
                                }
                            }
                            
                            Spacer().frame(height: 100)
                        }
                        .padding(.horizontal, Size.w(22))
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .background(Color.gray1000)
            .navigationBarHidden(showPhotoViewer)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(business.name ?? "noname")
                        .font(medium20Font)
                        .foregroundColor(.yellow300)
                }
            }
            .navigationBarItems(leading:
                                    BackButton(action: navigator.toRoot, color: Color.yellow300)
            )
            .overlay(
                !(business.images?.isEmpty ?? true) && showPhotoViewer ?
                PhotoViewer(images: business.images!, showPhotoViewer: $showPhotoViewer, selection: $selection) : nil
            )
            .animation(.default, value: showPhotoViewer)
        }
    }
}

struct PhotoViewer: View {
    let images: [String]
    @Binding var showPhotoViewer: Bool
    @Binding var selection: Int
    
    @State var scale: CGFloat = 1.0
    @State var lastScaleValue: CGFloat = 1.0
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.3).background(.ultraThinMaterial)
                .ignoresSafeArea()
            TabView(selection: $selection) {
                ForEach(Array(images.enumerated()), id: \.offset) { index, element in
                    CachedAsyncImage(url: URL(string: element), content: { cont in
                        cont
                            .resizable()
                            .scaledToFit()
                    }, placeholder: {
                        ZStack {
                            ProgressView().progressViewStyle(CircularProgressViewStyle(tint: Color.gray1000))
                        }
                    })
                    .frame(width: UIScreen.main.bounds.width)
                    .id(index)
                    .scaleEffect(lastScaleValue)
                    .gesture(MagnificationGesture().onChanged { val in
                        let delta = val / self.lastScaleValue
                        self.lastScaleValue = val
                        let newScale = self.scale * delta
                    }.onEnded { val in
                        withAnimation {
                            self.lastScaleValue = 1.0
                        }
                    })
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            
            VStack {
                ZStack {
                    HStack {
                        Text("\(selection + 1)/\(images.count)")
                            .foregroundColor(.yellow300)
                            .font(medium20Font)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    HStack {
                        XButton(action: { showPhotoViewer = false })
                            .padding(Size.w(11))
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
                
            }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
    }
}

#Preview {
    BusinessDetailsView()
}
