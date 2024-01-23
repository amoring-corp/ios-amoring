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
    @State private var pictures: [PictureModel] = []
    
    @State private var droppedOutside: Bool = false
    @State private var confirmRemoveImageIndex: Int = 0
    @State private var showRemoveConfirmation: Bool = false
    @State private var showContentTypeSheet: Bool = false
    @State private var showImagePicker: Bool = false
    @State private var editIndex: Int? = nil
    
    var body: some View {
        VStack {
            Text("프로필에 **3개의 사진은 꼭** 등록해주셔야 합니다.\n그래야 인연을 찾을 확률이 높아져요!")
                .font(regular16Font)
                .foregroundColor(.gray600)
                .multilineTextAlignment(.center)
                .padding(.horizontal, Size.w(36))
                .padding(.top, Size.w(40))
                .padding(.bottom, Size.w(40))
            
            PictureGridView(pictures: $pictures, droppedOutside: $droppedOutside, onAddedImageClick: { index in
                confirmRemoveImageIndex = index
                showRemoveConfirmation.toggle()
            }, onAddImageClick: {
                showContentTypeSheet.toggle()
            })
            .padding(.horizontal)
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
            
            Spacer()
            
            HStack {
                Text("사진아래 번호 순서로 노출이 됩니다.")
                    .font(regular16Font)
                    .foregroundColor(.gray600)
                    .multilineTextAlignment(.trailing)
            }.frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.horizontal, Size.w(36))
                .padding(.bottom, Size.w(30))
            
            Button(action: {
                let images = pictures.map({ $0.picture })
                userManager.uploadMyProfileImages(images: images) { success in
                    //TODO: success handle
                }
            }) {
                FullSizeButton(title: "저장", color: Color.black, bg: .yellow300, isLoading: userManager.isLoading, loadingColor: .gray1000)
            }
            .padding(.horizontal, Size.w(22))
            .padding(.bottom, Size.w(16))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.gray1000)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("사진")
                    .font(medium20Font)
                    .foregroundColor(.yellow300)
            }
        }
        .navigationBarItems(leading:
                                BackButton(action: {
            self.presentationMode.wrappedValue.dismiss()
        }, color: Color.yellow300)
        )
        .onAppear(perform: setCurrentPhotos)
    }
    
    private func setCurrentPhotos() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            pictures.removeAll()
            guard let images = userManager.user?.userProfile?.images else { return }
            for image in images {
                let urlString = image.file?.url ?? ""
                guard let url = URL(string: urlString) else { return }
                let data = try? Data(contentsOf: url) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                let image = UIImage(data: data!)
                pictures.append(PictureModel.newPicture(image!, urlString))
            }
        }
    }
    
    private func removePicture() {
        pictures.remove(at: confirmRemoveImageIndex)
    }
}

#Preview {
    AccountPhoto()
}
