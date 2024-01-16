//
//  ExpandedView.swift
//  amoring
//
//  Created by 이준녕 on 12/14/23.
//

import SwiftUI
import CachedAsyncImage

struct ExpandedView: View {
    let userProfile: UserProfile
    
    private func pictures() -> [String] {
        var temp: [UserProfileImage] = []
        if userProfile.images.count > 2 {
            temp = userProfile.images
            temp.removeFirst()
        }
        return temp.map({ $0.file?.url ?? "" })
    }
    
    var body: some View {
        VStack(spacing: 0) {
            if userProfile.height != nil || userProfile.weight != nil || userProfile.occupation != nil || userProfile.education != nil || userProfile.mbti != nil {
                VStack(alignment: .leading) {
                    Text("기본정보")
                        .font(bold26Font)
                        .foregroundColor(.black)
                    
                    TagCloudView(tags: [
                        userProfile.height.toHeight(),
                        userProfile.weight.toWeight(),
                        userProfile.occupation?.description,
                        userProfile.education?.description,
                        userProfile.mbti,
                    ])
                }
                .padding(Size.w(22))
                .background(Color.yellow350)
            }
            if !userProfile.interests.isEmpty {
                VStack(alignment: .leading) {
                    Text("관심사")
                        .font(bold26Font)
                        .foregroundColor(.black)
                    let tags: [String] = userProfile.interests.map { $0.name }
                    TagCloudView(tags: tags)
                }
                .padding(Size.w(22))
                .background(Color.yellow350)
            }
            
            VStack(spacing: 0) {
                ForEach(pictures(), id: \.self) { url in
                    VStack(spacing: 0) {
                        Color.gray1000.frame(height: 2).frame(minWidth: UIScreen.main.bounds.width)
                        //                        Color.red.frame(height: 300)
                        CachedAsyncImage(url: URL(string: url), content: { cont in
                            cont
                                .resizable()
                                .scaledToFill()
                        }, placeholder: {
                            ZStack {
                                ProgressView().progressViewStyle(CircularProgressViewStyle(tint: Color.gray1000))
                            }
                        })
                    }
                }
            }
            .padding(.top, Size.w(28))
        }
        .background(Color.yellow350)
    }
    
    @ViewBuilder
    private func BasicInfo() -> some View {
        if userProfile.height != nil || userProfile.weight != nil || userProfile.occupation != nil || userProfile.education != nil || userProfile.mbti != nil {
            VStack(alignment: .leading) {
                Text("기본정보")
                    .font(bold26Font)
                    .foregroundColor(.black)
                
                TagCloudView(tags: [
                    userProfile.height.toHeight(),
                    userProfile.weight.toWeight(),
                    userProfile.occupation,
                    userProfile.education,
                    userProfile.mbti,
                ])
            }
            .padding(Size.w(22))
            .background(Color.yellow350)
        }
    }
    
    @ViewBuilder
    private func InterestsView() -> some View {
        if !userProfile.interests.isEmpty {
            VStack(alignment: .leading) {
                Text("관심사")
                    .font(bold26Font)
                    .foregroundColor(.black)
                let tags: [String] = userProfile.interests.map { $0.name }
                TagCloudView(tags: tags)
            }
            .padding(Size.w(22))
            .background(Color.yellow350)
        }
    }
}

#Preview {
    ExpandedView(userProfile: UserProfile(id: "", images: [], interests: []))
}
