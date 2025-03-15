//
//  AmoringView.swift
//  amoring
//
//  Created by 이준녕 on 11/20/23.
//

import SwiftUI
import AVFoundation

struct AmoringView: View {
    @EnvironmentObject var amoringController: AmoringController
    @EnvironmentObject var userManager: UserManager
    @EnvironmentObject var notificationController: NotificationController
    @Binding var selectedIndex: Int
    @State var showAlert = false
    
    var body: some View {
        NavigationView {
            ZStack {
                if amoringController.checkIn != nil {
                    ProfilesView(selectedIndex: $selectedIndex)
//                        .navigationBarItems(leading:
//                                                Text("AMORING")
//                            .font(bold20Font)
//                            .foregroundColor(.yellow300)
//                                            , trailing:
//                                                HStack {
//                            Text(amoringController.countDown.toString())
//                                .font(medium16Font)
//                                .foregroundColor(.yellow300)
//                                .fixedSize(horizontal: true, vertical: false)
//                                .lineLimit(1)
//                            Button(action: {
//                                showAlert = true
//                            }) {
//                                Image("ic-leave-room")
//                                    .resizable()
//                                    .scaledToFit()
//                                    .frame(width: Size.w(32), height: Size.w(32))
//                            }
//                            .alert(isPresented: $showAlert) {
//                                Alert(title: Text("체크아웃하기"),
//                                      message: Text("라운지 체크아웃 시\n프로필이 더 이상 소개되지 않습니다.\n라운지에서 체크아웃 하시겠습니까?"),
//                                      primaryButton: .cancel(Text("취소")), secondaryButton: .default(Text("확인"), action: leave))
//                            }
//                        }
//                        )
                } else {
                    if AVCaptureDevice.authorizationStatus(for: .video) != .denied {
                        //already authorized
                        CheckInView()
                    } else {
                        VStack {
                            Button(action: {
                                AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted: Bool) in
                                    if granted {
                                        print("granted")
                                    } else {
                                        //access denied
                                        print("denied")
                                        self.openAppSettings()
                                    }
                                })
                                
                            }) {
//                                Grant access to camera
//                                카메라 접근을 허용하세요
                                Text("카메라 접근을 허용하세요")
                            }
                        }
                        .padding(.horizontal, Size.w(22))
                        .padding(.bottom, Size.w(10))
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                        .background(.gray1000)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("AMORING")
                        .font(bold20Font)
                        .foregroundColor(.yellow300)
                        .opacity(amoringController.checkIn == nil ? 1 : 0)
                }
                ToolbarItem(placement: .topBarLeading) {
                    Text("AMORING")
                        .font(bold20Font)
                        .foregroundColor(.yellow300)
                        .opacity(amoringController.checkIn == nil ? 0 : 1)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    HStack {
                        Text("-\(amoringController.countDown.toString())")
                            .font(medium16Font)
                            .foregroundColor(.yellow300)
                            .fixedSize(horizontal: true, vertical: false)
                            .lineLimit(1)
                        Button(action: {
                            showAlert = true
                        }) {
                            Image("ic-leave-room")
                                .resizable()
                                .scaledToFit()
                                .frame(width: Size.w(32), height: Size.w(32))
                        }
                        .alert(isPresented: $showAlert) {
                            Alert(title: Text("체크아웃하기"),
                                  message: Text("라운지 체크아웃 시\n프로필이 더 이상 소개되지 않습니다.\n라운지에서 체크아웃 하시겠습니까?"),
                                  primaryButton: .cancel(Text("취소")), secondaryButton: .default(Text("확인"), action: leave))
                        }
                    }
                    .opacity(amoringController.checkIn == nil ? 0 : 1)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    func leave() {
        userManager.checkOutFromActive { error in
            if let error {
                notificationController.setNotification(text: error, type: .error)
            } else {
                amoringController.leave()
            }
        }
    }
    
    private func openAppSettings() {
        DispatchQueue.main.async {
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url)
            }
        }
      }
}

//#Preview {
//    SessionView()
//}
