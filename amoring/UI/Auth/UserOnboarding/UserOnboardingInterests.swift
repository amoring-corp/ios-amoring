//
//  UserOnboardingInterests.swift
//  amoring
//
//  Created by 이준녕 on 1/3/24.
//

import SwiftUI

struct UserOnboardingInterests: View {
    @EnvironmentObject var controller: UserOnboardingController
    @EnvironmentObject var notificationController: NotificationController
    @EnvironmentObject var userManager: UserManager
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var success: Bool = false
    @State var contentOffset: CGFloat = 0
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                CustomNavigationView(offset: $contentOffset, title: "관심사", back: { self.presentationMode.wrappedValue.dismiss() })
                TrackableScrollView(showIndicators: false, contentOffset: $contentOffset) {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("관심사를 알려주세요")
                            .font(bold32Font)
                            .foregroundColor(.black)
                            .padding(.horizontal, Size.w(14))
                            .padding(.top, Size.w(56))
                            .padding(.bottom, Size.w(10))
                        
                        Text("흥미있는 것들을 최대 7개까지 골라주세요. 서로의 관심사를 알면 더 쉽게 대화를 시작할 수 있어요!")
                            .font(regular16Font)
                            .foregroundColor(.black)
                            .padding(.horizontal, Size.w(14))
                            .padding(.bottom, Size.w(40))
                        
                        ForEach(userManager.interestCategories, id: \.self) { cat in
                            TagCloudViewSelectable(cat: cat, selectedInterests: $controller.selectedInterests, selectedColor: .gray150, titleColor: .black)
                                .frame(maxWidth: .infinity)
                                .padding(.bottom, Size.w(30))
                        }
                        
                        Spacer().frame(height: 300)
                        
                        NavigationLink(isActive: $success, destination: {
                            UserOnboardingSuccess()
                        }) {
                            EmptyView()
                        }
                    }
                    .padding(.horizontal, Size.w(22))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .background(Color.yellow300)
            }
            
            VStack(spacing: 0) {
                Color.yellow200
                    .frame(height: 1)
                    .frame(maxWidth: .infinity)
                
                TagCloudViewSelected(selectedInterests: $controller.selectedInterests, totalHeight: CGFloat.infinity)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, Size.w(32))
                    .padding(.top, Size.w(25))
                
                Button(action: {
                    save()
//                    userManager.connectInterests(ids: selectedInterests.map{ $0.0 }) { success in
//                        next = true
//                    }
                }) {
                    BlackButton(title: "다음")
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.top, Size.w(16))
                .padding(.horizontal, Size.w(22))
            }
            .padding(.bottom, Size.w(36))
            .background(Color.yellow300)
            .shadow(color: Color.black.opacity(0.1), radius: 50, y: -20)
        }
        .navigationBarHidden(true)
        //        .navigationBarItems(leading:
        //                                Button(action: {
        //            self.presentationMode.wrappedValue.dismiss()
        //        }) {
        //            Image(systemName: "chevron.left")
        //                .resizable()
        //                .scaledToFit()
        //                .frame(width: Size.w(20), height: Size.w(20))
        //                .foregroundColor(.black)
        //        }
        //        )
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

#Preview {
    UserOnboardingInterests().environmentObject(UserOnboardingController())
}
