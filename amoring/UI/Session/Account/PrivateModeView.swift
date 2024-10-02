//
//  PrivateModeView.swift
//  amoring
//
//  Created by Sergey Li on 9/20/24.
//

import SwiftUI

struct PrivateModeView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var userManager: UserManager
    @State private var isInPrivateMode = false
    
    var body: some View {
        VStack {
            Toggle(isOn: $isInPrivateMode) {
                Text("투명모드")
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
                    self.isInPrivateMode = userManager.user?.profile?.isInPrivateMode ?? false
                }
                .onChange(of: isInPrivateMode) { newValue in
                    if newValue != userManager.user?.profile?.isInPrivateMode {
                        userManager.user?.profile?.isInPrivateMode = newValue
                        userManager.updateProfile { success in
                            if success {
                                self.isInPrivateMode = userManager.user?.profile?.isInPrivateMode ?? false
                            } else {
                                self.isInPrivateMode.toggle()
                            }
                        }
                    }
                }
                
                Text("좋아요를 보낸 사용자들에게만 프로필이 보입니다.")
                    .font(regular16Font)
                    .foregroundColor(.gray600)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal, Size.w(34))
                    .padding(.top, Size.w(16))
                    .padding(.bottom, Size.w(30))
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.gray1000)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("투명모드")
                    .font(medium20Font)
                    .foregroundColor(.yellow300)
            }
        }
        .navigationBarItems(leading:
                                BackButton(action: {
            self.presentationMode.wrappedValue.dismiss()
        }, color: Color.yellow300)
        )
    }
}

#Preview {
    PrivateModeView()
}
