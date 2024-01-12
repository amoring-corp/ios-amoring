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
    
    //TODO: pass real user here
    @State var user = User(id: 1, name: "Eugene Krabs", birthYear: 2000, bio: "There is no knowledge\nThat is no power", gender: "MALE", interests: [])
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 20) {
                let url = "https://amoring-server-dev.s3.ap-northeast-2.amazonaws.com/images/fa2e0e4387b2855e2cf002964bfed416"
                
                Link(destination: URL(string: url)!) {
                    Text("FADDSSD")
                }
                
                CachedAsyncImage(url: URL(string: url), content: { cont in
                    cont
                        .resizable()
                        .scaledToFit()
                }, placeholder: {
                    ZStack {
                        ProgressView().progressViewStyle(CircularProgressViewStyle(tint: .white))
                    }.frame(width: 100, height: 100, alignment: .center)
                })
            
                
                HStack {
                    Text(user.name ?? "")
                    Text(user.age?.description ?? "")
                    Text(user.gender ?? "")
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
                
                TextEditor(text: $user.bio ?? "")
                    .onChange(of: user.bio ?? "", perform: { newValue in
                    if(newValue.count >= charLimit){
                        user.bio = String(newValue.prefix(charLimit))
                    }
                })
                    .frame(height: 300)
                
                HStack{
                    Spacer()
                    Text("\(charLimit - (user.bio?.count ?? 0))")
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
        .onAppear {
            if let user = userManager.user {
                self.user = user
            }
        }
    }
    
    private func removePicture() {
        pictures.remove(at: confirmRemoveImageIndex)
    }
}

#Preview {
    AccountView()
}
