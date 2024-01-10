//
//  UserOnboardingAge.swift
//  amoring
//
//  Created by 이준녕 on 11/21/23.
//

import SwiftUI

struct UserOnboardingAge: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var controller: UserOnboardingController
    @State private var goToPhoto: Bool = false
    @State private var sheetPresented: Bool = false
    @State var age = 2000
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("회원님은\n몇년도에 태어났나요?")
                .font(bold32Font)
                .foregroundColor(.black)
                .padding(.top, Size.w(56))
                .padding(.horizontal, Size.w(14))
                .padding(.bottom, Size.w(66))
            
            PickerButton {
                if let age = controller.user.birthYear {
                    Text(age.description)
                        .foregroundColor(.black)
                        .font(medium18Font)
                }
            } .onTapGesture {
                withAnimation {
                    sheetPresented.toggle()
                }
            }
            
            Spacer()
            
            Text("회원님의 프로필에 표시되는 정보로\n등록 후 변경은 불가하니 신중하게 입력하세요.")
                .font(regular16Font)
                .foregroundColor(.black)
                .multilineTextAlignment(.trailing)
                .lineSpacing(5)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.horizontal, Size.w(14))
                .padding(.bottom, Size.w(30))
            
            NavigationLink(isActive: $goToPhoto, destination: {
                UserOnboardingPhoto()
            }) {
                EmptyView()
            }
            
            HStack {
                Button(action: {
                    goToPhoto = true
                }) {
                    NextBlackButton(enabled: controller.user.birthYear != nil)
                }
                .disabled(controller.user.birthYear == nil)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.bottom, Size.w(36))
        }
        .padding(.horizontal, Size.w(22))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.yellow300)
        .onTapGesture {
            withAnimation {
                sheetPresented = false
            }
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
        .overlay(
            sheetPresented ? CustomSheet {
                let year = (Int(Calendar.current.component(.year, from: Date()).description) ?? 2024) - 17
                Picker("", selection: $age) {
                    ForEach(1920..<year, id: \.self) { year in
                        Text(String(year)).tag(year)
                            .foregroundColor(.black)
                    }
                }
                .pickerStyle(.wheel)
                .onAppear {
                    withAnimation {
                        controller.user.birthYear = self.age
                    }
                }
                .onChange(of: age) { newAge in
                    withAnimation {
                        controller.user.birthYear = newAge
                    }
                }
            } : nil
        )
        
    }
}

#Preview {
    NavigationView {
        UserOnboardingAge().environmentObject(UserOnboardingController()).navigationBarTitleDisplayMode(.inline)
          
    }
    
}
