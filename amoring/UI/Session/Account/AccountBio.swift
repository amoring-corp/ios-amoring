//
//  AccountBio.swift
//  amoring
//
//  Created by 이준녕 on 1/23/24.
//

import SwiftUI

struct AccountBio: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var userManager: UserManager
    
    @State var bio: String = ""
    
    private let charLimit: Int = 40
    
    var body: some View {
        VStack {
            Text("40자까지 작성이 가능해요.\n파워풀한 자기소개 한줄을 부탁드려요!")
                .font(regular16Font)
                .foregroundColor(.gray600)
                .multilineTextAlignment(.center)
                .padding(.horizontal, Size.w(36))
                .padding(.top, Size.w(40))
                .padding(.bottom, Size.w(40))
            
   
            MultilineCustomTextField(placeholder: "저는 코튼같고 클린한 사람입니다 ㅋㅋㅋㅋ몇자냐 생각보다 40자가 길군아.", text: $bio)
            
            Spacer()
                .onChange(of: bio, perform: { newValue in
                    if(newValue.count >= charLimit) {
                        bio = String(newValue.prefix(charLimit))
                    }
                })
            
            Button(action: {
                userManager.user?.userProfile?.bio = self.bio
                if let userProfile = userManager.user?.userProfile {
                    userManager.updateUserProfile(userProfile: userProfile) { success in
                        print("Bio Successfully saved")
                    }
                }
            }) {
                FullSizeButton(title: "저장", color: Color.black, bg: .yellow300, isLoading: userManager.isLoading, loadingColor: .gray1000)
            }
            .padding(.bottom, Size.w(16))
        }
        .padding(.horizontal, Size.w(22))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.gray1000)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("소개글")
                    .font(medium20Font)
                    .foregroundColor(.yellow300)
            }
        }
        .navigationBarItems(leading:
                                BackButton(action: {
            self.presentationMode.wrappedValue.dismiss()
        }, color: Color.yellow300)
        )
        .onAppear {
            withAnimation {
                self.bio = userManager.user?.userProfile?.bio ?? ""
            }
        }
    }
}

#Preview {
    AccountBio()
}
