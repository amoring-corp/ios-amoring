//
//  BusinessSettingsImages.swift
//  amoring
//
//  Created by 이준녕 on 1/25/24.
//

import SwiftUI

struct BusinessSettingsImages: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var userManager: UserManager
    @EnvironmentObject var sessionManager: SessionManager
    @EnvironmentObject var notificationController: NotificationController
    
    @State private var pictures: [PictureModel] = []
    @State private var droppedOutside: Bool = false
    @State private var confirmRemoveImageIndex: Int = 0
    @State private var showRemoveConfirmation: Bool = false
    @State private var showContentTypeSheet: Bool = false
    @State private var showPermissionDenied: Bool = false
    @State private var editIndex: Int? = nil
    
    var body: some View {
        VStack(spacing: 0) {
            CustomNavigationView(offset: .constant(400), title: "사진", back: { presentationMode.wrappedValue.dismiss() })
            VStack(alignment: .leading, spacing: 0) {
                Text("아래의 내용은 비울 수 없습니다\n고객에게 홍보되는 정보이니 정확히 작성해주세요.")
                    .font(regular16Font)
                    .foregroundColor(.yellow600)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, Size.w(14))
                    .padding(.top, Size.w(40))
                    .padding(.bottom, Size.w(40))
                
                PictureGridView(pictures: $pictures, droppedOutside: $droppedOutside, onAddedImageClick: { index in
                    confirmRemoveImageIndex = index
                    showRemoveConfirmation.toggle()
                }, onAddImageClick: {
                    showContentTypeSheet.toggle()
                })
                .padding(.horizontal, Size.w(-8))
                .onAppear {
                    self.pictures = userManager.businessPictures
                }
                .onChange(of: userManager.businessPictures) { pics in
                    self.pictures = pics
                }
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
                            .destructive(Text("삭제"), action: userManager.removeBusinessPicture),
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
                
                Spacer()
                
                HStack {
                    Text("사진은 최소 3장 이상 필요하며,\n사진아래 번호 순서로 노출이 됩니다.")
                        .font(regular16Font)
                        .foregroundColor(.yellow600)
                        .multilineTextAlignment(.trailing)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.bottom, Size.w(30))
                
                HStack {
                    if userManager.isLoading {
                        ProgressView()
                            .tint(.black)
                            .frame(maxWidth: .infinity)
                            .padding(20)
                    } else {
                        Button(action: {
                            let images = pictures.map({ $0.picture })
                            // TODO: find better way to refresh images
                            userManager.deleteAllBusinessImages { success in
                                userManager.uploadBusinessImages(images: images) { success in
                                    sessionManager.getCurrentSession(delay: 0) { success, error in
                                        notificationController.setNotification(show: !success, text: error, type: .error)
                                    }
                                }
                            }
                        }) {
                            FullSizeButton(title: "저장", color: .black, bg: .yellow200, loadingColor: .gray1000)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.bottom, Size.w(16))
            }
            .padding(.horizontal, Size.w(22))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.yellow300)
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    BusinessSettingsImages()
}
