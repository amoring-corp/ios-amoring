//
//  UserOnboardingGender.swift
//  amoring
//
//  Created by 이준녕 on 11/21/23.
//

import SwiftUI
import AmoringAPI

struct UserOnboardingGender: View {
    @EnvironmentObject var controller: UserOnboardingController
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @State var gender: Gender? = nil
    @State var next: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("성별을 골라주세요")
                .font(bold32Font)
                .foregroundColor(.black)
                .padding(.horizontal, Size.w(14))
                .padding(.top, Size.w(56))
                .padding(.bottom, Size.w(10))
            
            Text("회원님의 성별을 기준으로\n이성에게만 회원님을 소개해드릴게요!")
                .font(regular16Font)
                .foregroundColor(.black)
                .padding(.horizontal, Size.w(14))
                .padding(.bottom, Size.w(40))
        
            GenderPicker(gender: $gender)
            
            Spacer()
            
            Text("저희 서비스는 아직 이성 매칭만 가능해요.\n등록 후 변경은 불가하니 신중하게 입력하세요.")
                .font(regular16Font)
                .foregroundColor(.black)
                .multilineTextAlignment(.trailing)
                .lineSpacing(5)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.horizontal, Size.w(14))
                .padding(.bottom, Size.w(30))
            
            NavigationLink(isActive: $next, destination: {
                UserOnboardingPhoto()
            }) {
                EmptyView()
            }
            
            HStack {
                Button(action: {
                    if let gender {
                        controller.profile.gender = gender
                        next = true
                    }
                }, label: {
                    BlackButton(title: "다음", enabled: gender != nil)
                })
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.bottom, Size.w(36))
        }
        .padding(.horizontal, Size.w(22))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.yellow300)
        .navigationBarBackButtonHidden()
        .navigationBarItems(leading:
                                BackButton(action: {
            self.presentationMode.wrappedValue.dismiss()
        })
        )
    }
}

//enum Gender: String {
//    case male, female
//}

struct GenderPicker: View {
    @Binding var gender: Gender?
    
    var body: some View {
        HStack(spacing: Size.w(21)) {
            GenderCell(selectedGender: $gender, gender: .male)
            
            GenderCell(selectedGender: $gender, gender: .female)
        }
    }
}

struct GenderCell: View {
    @Binding var selectedGender: Gender?
    
    let gender: Gender
    
    var body: some View {
        VStack(spacing: Size.w(15)) {
            Text(gender == .male ? "남성" : "여성")
                .font(semiBold22Font)
                .foregroundColor(.black)
            Text(gender == .male ? (self.selectedGender == self.gender ? "🙋🏻" : "🧑🏻") : (self.selectedGender == self.gender ? "🙋🏻‍♀️" : "👩🏻"))
                .font(semiBold58Font)
                .transition(.identity)
        }
        .padding(.vertical, Size.w(30))
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .overlay(
            RoundedRectangle(cornerRadius: 14).stroke(Color.gray900.opacity(self.selectedGender == self.gender ? 1 : 0.01), lineWidth: 3)
        )
        .offset(y: self.selectedGender == self.gender ? Size.w(-15) : 0)
        .onTapGesture {
            withAnimation(.smooth) {
                self.selectedGender = self.selectedGender == self.gender ? nil : self.gender
            }
        }
    }
}

#Preview {
    NavigationView {
        UserOnboardingGender().environmentObject(UserOnboardingController())
    }
}
