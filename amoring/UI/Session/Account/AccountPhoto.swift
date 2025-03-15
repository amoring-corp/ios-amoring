//
//  AccountPhoto.swift
//  amoring
//
//  Created by 이준녕 on 1/23/24.
//

import SwiftUI

struct AccountPhoto: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var userManager: UserManager
    @EnvironmentObject var sessionManager: SessionManager
    @EnvironmentObject var notificationController: NotificationController
    
    @State private var droppedOutside: Bool = false
//    @State private var confirmRemoveImageIndex: Int = 0
    @State private var showRemoveConfirmation: Bool = false
    @State private var showContentTypeSheet: Bool = false
    @State private var showImagePicker: Bool = false
    @State private var editIndex: Int? = nil
    @State private var pictures: [PictureModel] = []
//    @Binding var goFurther: Bool?
    @State var isBlurred: Bool = false
    
    var body: some View {
        ScrollView {
            VStack {
                if userManager.user?.profile?.gender == .female {
                    Toggle(isOn: $isBlurred) {
                        Text("흐려지기")
                            .font(regular16Font)
                            .foregroundColor(Color.gray600)
                    }
                    .tint(Color.green400)
                    .padding(.horizontal, Size.w(14))
                    .padding(.vertical, Size.w(16))
                    .background(Color.black)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                    .padding(.horizontal, Size.w(22))
                    .padding(.top, Size.w(40))
                    .onAppear {
                        self.isBlurred = userManager.user?.profile?.isBlurred ?? false
                    }
                    .onChange(of: isBlurred) { value in
                        userManager.user?.profile?.isBlurred = self.isBlurred
                        userManager.updateProfile { success in
                            if success {
                                self.isBlurred = userManager.user?.profile?.isBlurred ?? false
                            } else {
                                self.isBlurred.toggle()
                            }
                        }
                    }
                    
                    Text("사용시 다른 사용자들에게 내 사진이 흐리게 보이고, 매칭 후에만 사진이 보입니다.")
                        .font(regular16Font)
                        .foregroundColor(.gray600)
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal, Size.w(34))
                        .padding(.top, Size.w(16))
                        .padding(.bottom, Size.w(30))
                }
                
                PictureGridView(pictures: $pictures, droppedOutside: $droppedOutside, onAddedImageClick: { index in
                    userManager.confirmRemoveImageIndex = index
                    showRemoveConfirmation.toggle()
                }, onAddImageClick: {
                    showContentTypeSheet.toggle()
                })
                .padding(.horizontal)
                .onAppear {
                    self.pictures = userManager.pictures
                }
                .sheet(isPresented: $showContentTypeSheet) {
                    ImagePicker(pictures: $pictures, photoIndex: editIndex).ignoresSafeArea()
                        .onDisappear {
                            self.editIndex = nil
                        }
                }
                .actionSheet(isPresented: $showRemoveConfirmation) {
                    if userManager.confirmRemoveImageIndex >= 3 {
                        ActionSheet(title: Text("프로필 사진 추가"), message: Text("회원가입을 위해 최소 3개의 사진이 필요합니다."), buttons: [
                            .default(Text("등록"), action: {
                                self.editIndex = userManager.confirmRemoveImageIndex
                                showContentTypeSheet.toggle()
                            }),
                            .destructive(Text("삭제"), action: self.removePicture),
                            .cancel()
                        ])
                    } else {
                        ActionSheet(title: Text("프로필 사진 추가"), message: Text("회원가입을 위해 최소 3개의 사진이 필요합니다."), buttons: [
                            .default(Text("등록"), action: {
                                self.editIndex = userManager.confirmRemoveImageIndex
                                showContentTypeSheet.toggle()
                            }),
                            .cancel()
                        ])
                    }
                }
                
                Text("프로필에 **3개의 사진은 꼭** 등록해주셔야 합니다.\n그래야 인연을 찾을 확률이 높아져요!")
                    .font(regular16Font)
                    .foregroundColor(.gray600)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal, Size.w(34))
                    .padding(.bottom, Size.w(20))
                
//                HStack {
//                    Text("사진아래 번호 순서로 노출이 됩니다.")
//                        .font(regular16Font)
//                        .foregroundColor(.gray600)
//                        .multilineTextAlignment(.trailing)
//                }.frame(maxWidth: .infinity, alignment: .trailing)
//                    .padding(.horizontal, Size.w(36))
//                    .padding(.bottom, Size.w(30))
                
                Button(action: {
                    /// do nothing if images are haven't been changed
                    guard self.pictures != userManager.pictures else { return }
                    
                    let images = pictures.map({ $0.picture })
                    userManager.deleteMyAllProfileImages { success in
                        self.pictures.removeAll()
                        userManager.uploadMyProfileImages(images: images) { success in
                            self.pictures = userManager.pictures
                            //                        sessionManager.getCurrentSession(delay: 0) { success, error in
                            //                            notificationController.setNotification(show: !success, text: error, type: .error)
                            //                        }
                        }
                    }
                }) {
                    FullSizeButton(title: "저장", color: Color.black, bg: .yellow300, isLoading: userManager.isLoading, loadingColor: .gray1000)
                }
                .padding(.horizontal, Size.w(22))
                .padding(.bottom, Size.w(16))
                
                Spacer(minLength: 200)
            }
        }
        .frame(maxWidth: .infinity)
        .background(Color.gray1000)
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("내 사진")
                    .font(medium20Font)
                    .foregroundColor(.yellow300)
            }
        }
        .navigationBarItems(leading:
                                BackButton(action: {
//            if let goFurther {
//                withAnimation {
//                    self.goFurther = false
//                }
//            } else {
                self.presentationMode.wrappedValue.dismiss()
//            }
        }, color: Color.yellow300)
        )
    }
    
    func removePicture() {
        self.pictures.remove(at: userManager.confirmRemoveImageIndex)
    }
}

#Preview {
    AccountPhoto()
}
