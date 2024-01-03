//
//  UserOnboardingName.swift
//  amoring
//
//  Created by 이준녕 on 11/21/23.
//

import SwiftUI

struct UserOnboardingName: View {
    @EnvironmentObject var controller: UserOnboardingController
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("이름을 입력해주세요")
                .font(bold32Font)
                .foregroundColor(.black)
                .padding(.horizontal, Size.w(14))
                .padding(.top, Size.w(56))
                .padding(.bottom, Size.w(10))
            
            Text("다른 사용자들에게 회원님을 소개할 수 있는\n이름을 입력해주세요.")
                .font(regular16Font)
                .foregroundColor(.black)
                .padding(.horizontal, Size.w(14))
                .padding(.bottom, Size.w(40))
            
            CustomTextField(placeholder: "이름을 입력해주세요.", text: $controller.user.name ?? "")

            Spacer()
            
            Text("회원님의 첫 인상이 되는 이름이예요!\n등록 후 변경은 불가하니 신중하게 입력하세요.")
                .font(regular16Font)
                .foregroundColor(.black)
                .multilineTextAlignment(.trailing)
                .lineSpacing(5)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.horizontal, Size.w(14))
                .padding(.bottom, Size.w(30))
            
            HStack {
                NavigationLink(destination: {
                    UserOnboardingGender()
                }) {
                    NextBlackButton(enabled: !(controller.user.name?.isEmpty ?? true))
                }
                .disabled((controller.user.name?.isEmpty ?? true))
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.bottom, Size.w(36))
        }
        .padding(.horizontal, Size.w(22))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.yellow300)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("")
                    .font(medium20Font)
                    .foregroundColor(.black)
            }
        }
        .navigationBarItems(leading:
                                Button(action: {
            // sign out?
        }) {
            Image(systemName: "chevron.left")
                .resizable()
                .scaledToFit()
                .frame(width: Size.w(20), height: Size.w(20))
                .foregroundColor(.black)
        }
        )
    }
}

#Preview {
    NavigationView {
        UserOnboardingName().environmentObject(UserOnboardingController())
    }
}


