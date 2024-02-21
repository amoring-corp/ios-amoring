//
//  UserOnboardingBio.swift
//  amoring
//
//  Created by 이준녕 on 11/21/23.
//

import SwiftUI

struct UserOnboardingBio: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var controller: UserOnboardingController
    @EnvironmentObject var userManager: UserManager
    @EnvironmentObject var notificationController: NotificationController
    
    @State var success = false
    
    private let charLimit: Int = 40
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("마지막, 자기소개 한줄")
                .font(bold32Font)
                .foregroundColor(.black)
                .padding(.horizontal, Size.w(14))
                .padding(.top, Size.w(56))
                .padding(.bottom, Size.w(10))
            
            Text("회원님에 대한 인상을 남길 수 있는\n파워풀한 자기소개 한줄을 부탁드려요!")
                .font(regular16Font)
                .foregroundColor(.black)
                .padding(.horizontal, Size.w(14))
                .padding(.bottom, Size.w(40))
            
            MultilineCustomTextField(placeholder: "40자 이하로 작성해주세요.", text: $controller.profile.bio ?? "")
            
            Spacer()
                .onChange(of: controller.profile.bio ?? "", perform: { newValue in
                    if(newValue.count >= charLimit){
                        controller.profile.bio = String(newValue.prefix(charLimit))
                    }
                })
            
            Text("이제 다 끝났어요!\n계속해서 가입하기를 완료해주세요.")
                .font(regular16Font)
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
                .lineSpacing(5)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.horizontal, Size.w(14))
                .padding(.bottom, Size.w(30))
            
            NavigationLink(isActive: $success, destination: {
                UserOnboardingSuccess()
            }) {
                EmptyView()
            }
            
            HStack {
                Button(action: save) {
                    FullSizeButton(title: "가입하기", isLoading: userManager.isLoading)
                }
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.bottom, Size.w(36))
        }
        .padding(.horizontal, Size.w(22))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.yellow300)
        .onTapGesture {
            closeKeyboard()
        }
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
            self.presentationMode.wrappedValue.dismiss()
        })
        )
    }
    
    private func save() {
        userManager.createProfile(profile: controller.profile) { success in
            userManager.connectInterests(ids: controller.selectedInterests.map{ $0.0 }) { success in }
            let images = controller.pictures.map({ $0.picture })
            userManager.uploadMyProfileImages(images: images) { success in
                if success {
                    self.success = success
                } else {
                    notificationController.setNotification(text: "Something went wrong while uploading images. Please try again", type: .error)
                }
            }
        }
    }
}

//#Preview {
//    UserOnboardingBio()
//}
