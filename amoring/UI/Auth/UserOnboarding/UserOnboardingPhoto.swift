//
//  UserOnboardingPhoto.swift
//  amoring
//
//  Created by 이준녕 on 11/21/23.
//

import SwiftUI

struct UserOnboardingPhoto: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var controller: UserOnboardingController
    @EnvironmentObject var userManager: UserManager
    @EnvironmentObject var sessionManager: SessionManager
    
    @State private var pictures: [PictureModel] = []
    
    @State private var droppedOutside: Bool = false
    @State private var confirmRemoveImageIndex: Int = 0
    @State private var showRemoveConfirmation: Bool = false
    @State private var showContentTypeSheet: Bool = false
    @State private var showPermissionDenied: Bool = false
    @State private var goToStep5: Bool = false
    @State private var editIndex: Int? = nil
    
    var body: some View {
        
            VStack(alignment: .leading, spacing: 0) {
                Text("사진을 추가하세요")
                    .font(bold32Font)
                    .foregroundColor(.black)
                    .padding(.horizontal, Size.w(36))
                    .padding(.top, Size.w(56))
                    .padding(.bottom, Size.w(10))
                
                Text("프로필에 **3개의 사진은 꼭** 등록해주셔야 합니다.\n그래야 인연을 찾을 확률이 높아져요!")
                    .font(regular16Font)
                    .foregroundColor(.black)
                    .padding(.horizontal, Size.w(36))
                    .padding(.bottom, Size.w(40))
                
                PictureGridView(pictures: $pictures, droppedOutside: $droppedOutside, onAddedImageClick: { index in
                    confirmRemoveImageIndex = index
                    showRemoveConfirmation.toggle()
                }, onAddImageClick: {
                    showContentTypeSheet.toggle()
                }).padding(.horizontal, Size.w(14))
                
                Spacer()
                
                Text("사진아래 번호 순서로 노출이 됩니다.")
                    .font(regular16Font)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.trailing)
                    .lineSpacing(5)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.horizontal, Size.w(36))
                    .padding(.bottom, Size.w(30))
                
                NavigationLink(isActive: $goToStep5, destination: {
                    UserOnboardingIntro()
                }) {
                    EmptyView()
                }
                
                HStack {
                    Button(action: {
                        /// skipping for tests
                        //                                                goToStep5 = true
                        
                        let images = pictures.map({ $0.picture })
                        userManager.uploadMyProfileImages(images: images) { success in
                            goToStep5 = success
                        }
                    }) {
                        BlackButton(title: "다음", enabled: pictures.count >= 1, isLoading: userManager.isLoading)
                    }
                    .disabled(userManager.isLoading)
                    //                .disabled(pictures.count < 3 || userManager.isLoading)
                    .sheet(isPresented: $showContentTypeSheet) {
                        ImagePicker(pictures: $pictures, photoIndex: editIndex).ignoresSafeArea()
                            .onDisappear {
                                self.editIndex = nil
                            }
                    }
                    .actionSheet(isPresented: $showRemoveConfirmation) {
                        if confirmRemoveImageIndex >= 3 {
                            ActionSheet(title: Text("프로필 사진 추가"), message: Text("회원가입을 위해 최소 3개의 사진이 필요합니다."), buttons: [
                                .default(Text("등록"), action: {
                                    self.editIndex = confirmRemoveImageIndex
                                    showContentTypeSheet.toggle()
                                }),
                                .destructive(Text("삭제"), action: removePicture),
                                .cancel()
                            ])
                        } else {
                            ActionSheet(title: Text("프로필 사진 추가"), message: Text("회원가입을 위해 최소 3개의 사진이 필요합니다."), buttons: [
                                .default(Text("등록"), action: {
                                    self.editIndex = confirmRemoveImageIndex
                                    showContentTypeSheet.toggle()
                                }),
                                .cancel()
                            ])
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.horizontal, Size.w(22))
                .padding(.bottom, Size.w(36))
            }
            
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.yellow300)
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("")
                        .font(medium20Font)
                        .foregroundColor(.black)
                }
            }
            .navigationBarItems(leading:
                                    BackButton(action: {
                sessionManager.signOut()
                self.presentationMode.wrappedValue.dismiss()
            })
            )
        
    }
    
//    var body: some View {
//        
//        VStack(spacing: 20) {
//            Text("Step4")
//            Text("Please add photo")
//            Text("Please select at least 3")
//
//            PictureGridView(pictures: $pictures, droppedOutside: $droppedOutside, onAddedImageClick: { index in
//                confirmRemoveImageIndex = index
//                showRemoveConfirmation.toggle()
//            }, onAddImageClick: {
//                showContentTypeSheet.toggle()
//            }).padding(.horizontal)
//            
//        
//            NavigationLink(isActive: $goToStep5, destination: {
//                UserOnboardingBio()
//            }) {
//                EmptyView()
//            }
//            
//            Button(action: {
//                // TODO: Save images to db at this point
//                controller.user.pictures = pictures.map({ $0.picture.description })
//                print("\(pictures.count) pictures saved!")
//                goToStep5 = true
//            }) {
//                Text("Next")
//            }
//            .disabled(pictures.count < 3)
//            .opacity(pictures.count < 3 ? 0.5 : 1)
//            .sheet(isPresented: $showContentTypeSheet) {
//                ImagePicker(pictures: $pictures)
//            }
////            .alert("camera-permission-denied", isPresented: $showPermissionDenied, actions: {}, message: { Text("user-must-grant-camera-permission") })
//            .alert("Remove this picture?", isPresented: $showRemoveConfirmation, actions: {
//                Button("Yes", action: removePicture)
//                Button("Cancel", role: .cancel, action: {})
//            })
//        }
////        .textFieldStyle(.roundedBorder)
//    }
    
    private func removePicture() {
        pictures.remove(at: confirmRemoveImageIndex)
    }
}

#Preview {
    UserOnboardingPhoto().environmentObject(UserOnboardingController())
}
