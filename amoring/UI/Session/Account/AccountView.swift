//
//  AccountView.swift
//  amoring
//
//  Created by 이준녕 on 11/20/23.
//

import SwiftUI
import CachedAsyncImage

struct AccountView: View {
    @EnvironmentObject var sessionManager: SessionManager
    @EnvironmentObject var userManager: UserManager
    @EnvironmentObject var sessionController: SessionController
    
    @State private var pictures: [PictureModel] = []
    
    @State private var droppedOutside: Bool = false
    @State private var confirmRemoveImageIndex: Int = 0
    @State private var showRemoveConfirmation: Bool = false
    @State private var showContentTypeSheet: Bool = false
    @State private var showImagePicker: Bool = false
    @State private var bio: String = ""
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 20) {
                let url = userManager.user?.userProfile?.images.first?.file?.url ?? ""
                
                CachedAsyncImage(url: URL(string: url), content: { cont in
                    cont
                        .resizable()
                        .scaledToFit()
                }, placeholder: {
                    ZStack {
                        ProgressView().progressViewStyle(CircularProgressViewStyle(tint: .white))
                    }.frame(width: 100, height: 100, alignment: .center)
                })
                .frame(width: 100, height: 100, alignment: .center)
                
                HStack {
                    Text(userManager.user?.userProfile?.name ?? "")
                    Text(userManager.user?.userProfile?.age?.description ?? "")
                    Text(userManager.user?.userProfile?.gender ?? "")
                }
                
                PictureGridView(pictures: $pictures, droppedOutside: $droppedOutside, onAddedImageClick: { index in
                    confirmRemoveImageIndex = index
                    showRemoveConfirmation.toggle()
                }, onAddImageClick: {
                    showContentTypeSheet.toggle()
                })
                .padding(.horizontal)
                .sheet(isPresented: $showContentTypeSheet) {
                    ImagePicker(pictures: $pictures).ignoresSafeArea()
                }
    //            .alert("camera-permission-denied", isPresented: $showPermissionDenied, actions: {}, message: { Text("user-must-grant-camera-permission") })
                .alert("Remove this picture?", isPresented: $showRemoveConfirmation, actions: {
                    Button("Yes", action: removePicture)
                    Button("Cancel", role: .cancel, action: {})
                })
                
                Text("Bio")
                
                let charLimit: Int = 200
                
                TextEditor(text: $bio)
                    .onAppear {
                        if let bio = userManager.user?.userProfile?.bio {
                            self.bio = bio
                        }
                    }
                    .onChange(of: bio, perform: { newValue in
                    if (newValue.count >= charLimit) {
                        self.bio = String(newValue.prefix(charLimit))
                    }
                })
                    .frame(height: 300)
                
                HStack{
                    Spacer()
                    Text("\(charLimit - (bio.count))")
                        .foregroundColor(.gray)
                        .font(.headline)
                        .bold()
                }
                
                Text("Amoring Settings")
                
                HStack {
                    Text("Likes: ")
                    Text(sessionController.purchasedLikes.description)
                    Spacer()
                    Button(action: { sessionController.openPurchase(purchaseType: .like) }) {
                        Text("Purchse")
                    }
                }
                
                HStack {
                    Text("Hide my profile")
                    Spacer()
                    if sessionController.isHidden {
                        Image(systemName: "checkmark")
                            /// for tests. remove it
                            .onTapGesture {
                                sessionController.isHidden = false
                            }
                    } else {
                        Button(action: { sessionController.openPurchase(purchaseType: .transparent) }) {
                            Text("Purchse")
                        }
                    }
                }
                
                HStack {
                    Text("Check out people you like")
                    Spacer()
                    if sessionController.likeListEnabled {
                        Image(systemName: "checkmark")
                        /// for tests. remove it
                        .onTapGesture {
                            sessionController.likeListEnabled = false
                        }
                    } else {
                        Button(action: { sessionController.openPurchase(purchaseType: .list) }) {
                            Text("Purchse")
                        }
                    }
                }
                
                HStack {
                    Text("Amoring Community")
                    Spacer()
                    if sessionController.amoringCommunityIsOn {
                        Image(systemName: "checkmark")
                        /// for tests. remove it
                        .onTapGesture {
                            sessionController.amoringCommunityIsOn = false
                        }
                    } else {
                        Button(action: { sessionController.openPurchase(purchaseType: .lounge) }) {
                            Text("Purchse")
                        }
                    }
                }
                
                Text("Terms of use")
                Text("Terms of Service")
                Text("Privacy Policy")
                Text("Contact Us/ Report")
                
                Text("Account")
                
                Button(action: sessionManager.signOut) {
                    Text("LOGOUT")
                }
                
                Button(action: {

                }) {
                    Text("Deete account")
                }
                
                Spacer().frame(height: 200)
            }
            .padding(.horizontal, Size.w(22))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.gray1000)
    }
    
    private func removePicture() {
        pictures.remove(at: confirmRemoveImageIndex)
    }
}

#Preview {
    AccountView()
}
