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
            if #available(iOS 16.0, *) {
                MultilineCustomTextField(placeholder: "40자 이하로 작성해주세요.", text: $controller.user.bio ?? "")
                    .layoutPriority(2)
            } else {
                CustomTextField(placeholder: "40자 이하로 작성해주세요.", text: $controller.user.bio ?? "", font: semiBold18Font)
            }
            
            Spacer()
                .onChange(of: controller.user.bio ?? "", perform: { newValue in
                    if(newValue.count >= charLimit){
                        controller.user.bio = String(newValue.prefix(charLimit))
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
            
            HStack {
                NavigationLink(destination: {
                    UserOnboardingSuccess()
                }) {
                    FullSizeButton(title: "가입하기")
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
}

//    var body: some View {
//        VStack(spacing: 20) {
//            Text("Step5")
//            Text("Lastly, please explain yourself\n(40 characters or less)")
//            
//            TextEditor(text: $controller.user.bio ?? "")
//                
//            
//            HStack{
//                Spacer()
//                Text("\(charLimit - (controller.user.bio?.count ?? 0))").foregroundColor(.gray).font(.headline).bold()
//            }
//
//            NavigationLink(destination: { UserOnboardingTerms() }) {
//                Text("Next")
//            }
//        }
//        .padding(16)
//        .navigationBarBackButtonHidden()
//    }
//}

//#Preview {
//    UserOnboardingBio()
//}
