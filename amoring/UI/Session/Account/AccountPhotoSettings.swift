// MARK: DEPRECATED
////
////  AccountPhotoSettings.swift
////  amoring
////
////  Created by 이준녕 on 7/8/24.
////
//
//import SwiftUI
//
//struct AccountPhotoSettings: View {
//    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
//    @EnvironmentObject var userManager: UserManager
//    @State var goFurther: Bool? = false
//    @State var isBlurred: Bool = false
//    
//    var body: some View {
//        ZStack {
//            if goFurther ?? false {
//                AccountPhoto()
////                AccountPhoto(goFurther: $goFurther)
//                
//                    .transition(.move(edge: .trailing))
//            } else {
//                VStack(spacing: 0) {
//                    ScrollView {
//                        VStack(spacing: 0) {
//                            Button(action: {
//                                withAnimation {
//                                    goFurther = true
//                                }
//                            }) {
//                                HStack {
//                                    Text("사진")
//                                    
//                                    Spacer()
//                                    
//                                    Image(systemName: "chevron.right")
//                                }
//                                .font(regular16Font)
//                                .foregroundColor(Color.gray600)
//                                .padding(.horizontal, Size.w(20))
//                                .padding(.vertical, Size.w(23))
//                            }
//                            
//                            Color.gray1000.frame(maxWidth: .infinity).frame(height: 1)
//                            
//                            Toggle(isOn: $isBlurred) {
//                                Text("흐려지기")
//                                    .font(regular16Font)
//                                    .foregroundColor(Color.gray600)
//                            }
//                            .tint(Color.green400)
//                            .padding(.horizontal, Size.w(20))
//                            .padding(.vertical, Size.w(23))
//                            .onAppear {
//                                self.isBlurred = userManager.user?.profile?.isBlurred ?? false
//                            }
//                            .onChange(of: isBlurred) { value in
//                                userManager.user?.profile?.isBlurred = self.isBlurred
//                                userManager.updateProfile { success in
//                                    if success {
//                                        self.isBlurred = userManager.user?.profile?.isBlurred ?? false
//                                    } else {
//                                        self.isBlurred.toggle()
//                                    }
//                                }
//                            }
//                        }
//                        .background(Color.black)
//                        .clipShape(RoundedRectangle(cornerRadius: 14))
//                        .padding(.horizontal, Size.w(22))
//                        .padding(.bottom, Size.w(16))
//                        .padding(.top, Size.w(40))
//                    }
//                }
//                .frame(maxWidth: .infinity, maxHeight: .infinity)
//                .background(Color.gray1000)
//                .navigationBarBackButtonHidden()
//                .toolbar {
//                    ToolbarItem(placement: .principal) {
//                        Text("사진")
//                            .font(medium20Font)
//                            .foregroundColor(.yellow300)
//                    }
//                }
//                .navigationBarItems(leading:
//                                        BackButton(action: {
//                    if goFurther ?? false {
//                        withAnimation {
//                            goFurther = false
//                        }
//                    } else {
//                        self.presentationMode.wrappedValue.dismiss()
//                    }
//                }, color: Color.yellow300)
//                )
//            }
//        }
//    }
//}
