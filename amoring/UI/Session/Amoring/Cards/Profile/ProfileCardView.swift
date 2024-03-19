//
//  ProfileCardView.swift
//  amoring
//
//  Created by 이준녕 on 11/30/23.
//

import SwiftUI
import CachedAsyncImage
import AmoringAPI

struct ProfileCardView: View {
    let profile: ProfileInfo
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        ZStack(alignment: .center) {
            ZStack(alignment: .bottom) {
                Color.yellow350
                VStack {
                    let colors: [Color] = [.black, .black, .black, .black, .black, .black, .black, .black, .clear]
                    let url = profile.avatarUrl ?? ""
                    CachedAsyncImage(url: URL(string: url), content: { cont in
                        cont
                            .resizable()
                            .scaledToFill()
                    }, placeholder: {
                        ZStack {
                            ProgressView().progressViewStyle(CircularProgressViewStyle(tint: Color.gray1000))
                        }.frame(width: width, height: height, alignment: .center)
                    })
                    
//                    Image(user.fakeImage  ?? "")
//                        .resizable()
//                        .scaledToFit()
                        .mask(LinearGradient(gradient: Gradient(colors: colors), startPoint: .top, endPoint: .bottom))
                }
                .frame(width: width, height: height, alignment: .top)
                
//                Color.red.opacity(0.5)
//                    .frame(width: width, height: Size.w(186))
               UserInfoView(profile: profile)
                
            }
            .frame(maxWidth: width, maxHeight: height)
            .cornerRadius(24, corners: [.topLeft, .topRight])
        }
    }
}

struct UserInfoView: View {
    @EnvironmentObject var amoringController: AmoringController
    
    let profile: ProfileInfo
    var body: some View {
        ZStack(alignment: .top) {
            LinearGradient(colors: [
                Color.clear,
                Color.yellow350,
                Color.yellow350,
                Color.yellow350
            ], startPoint: .top, endPoint: .bottom)
            
            // TODO: make it conditional
            Image("tables-background")
                .resizable()
                .scaledToFill()
                .frame(height: Size.w(165))
            
            VStack(spacing: Size.w(10)) {
                HStack {
                    let gender = profile.gender?.rawValue
                    Text(LocalizedStringKey(gender ?? ""))
                        .font(semiBold12Font)
                        .foregroundColor(.white)
                        .padding(.horizontal, Size.w(12))
                        .padding(.vertical, Size.w(6))
                        .background(Capsule().fill(Color.gray1000))
                    
                    if let age = profile.age {
                        Text(age.description + "세")
                            .font(semiBold12Font)
                            .foregroundColor(.white)
                            .padding(.horizontal, Size.w(12))
                            .padding(.vertical, Size.w(6))
                            .background(Capsule().fill(Color.gray1000))
                    }
                    
                    
                    Text("테이블")
                        .font(semiBold12Font)
                        .foregroundColor(.black)
                        .padding(.horizontal, Size.w(12))
                        .padding(.vertical, Size.w(6))
                        .background(Capsule().fill(Color.green200))
                }
                .frame(maxWidth: .infinity, alignment: amoringController.showDetails ? .leading : .center)
                
                Text(profile.name ?? "")
                    .font(bold32Font)
                    .foregroundColor(.black)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: amoringController.showDetails ? .leading : .center)
                Text(profile.bio ?? "")
                    .font(medium16Font)
                    .foregroundColor(.black)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: amoringController.showDetails ? .leading : .center)
            }
            .padding(.horizontal, Size.w(22))
            .padding(.top, Size.w(16))
//            .padding(.bottom, Size.w(22 + 36))
        }
        .frame(height: Size.w(186), alignment: .top)
    }
}

//#Preview {
//    ProfileCardView(profile: Dummy.users.first!.profile!, width: UIScreen.main.bounds.width - Size.w(44), height: 500)
//}


