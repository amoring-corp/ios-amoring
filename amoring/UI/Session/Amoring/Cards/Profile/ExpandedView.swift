//
//  ExpandedView.swift
//  amoring
//
//  Created by 이준녕 on 12/14/23.
//

import SwiftUI
import CachedAsyncImage

struct ExpandedView: View {
    let profile: Profile
    
    private func pictures() -> [String] {
        var temp: [ProfileImage] = []
        if profile.images.count > 2 {
            temp = profile.images
            temp.removeFirst()
        }
        return temp.map({ $0.file?.url ?? "" })
    }
    
    var body: some View {
        VStack(spacing: 0) {
            if profile.height != nil || profile.weight != nil || profile.occupation != nil || profile.education != nil || profile.mbti != nil {
                VStack(alignment: .leading) {
                    Text("기본정보")
                        .font(bold26Font)
                        .foregroundColor(.black)
                    
                    TagCloudView(tags: [
                        profile.height.toHeight(),
                        profile.weight.toWeight(),
                        profile.occupation?.description,
                        profile.education?.description,
                        profile.mbti,
                    ])
                }
                .padding(Size.w(22))
                .background(Color.yellow350)
            }
            if !profile.interests.isEmpty {
                VStack(alignment: .leading) {
                    Text("관심사")
                        .font(bold26Font)
                        .foregroundColor(.black)
                    let tags: [String] = profile.interests.map { $0.name }
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
        if profile.height != nil || profile.weight != nil || profile.occupation != nil || profile.education != nil || profile.mbti != nil {
            VStack(alignment: .leading) {
                Text("기본정보")
                    .font(bold26Font)
                    .foregroundColor(.black)
                
                TagCloudView(tags: [
                    profile.height.toHeight(),
                    profile.weight.toWeight(),
                    profile.occupation,
                    profile.education,
                    profile.mbti,
                ])
            }
            .padding(Size.w(22))
            .background(Color.yellow350)
        }
    }
    
    @ViewBuilder
    private func InterestsView() -> some View {
        if !profile.interests.isEmpty {
            VStack(alignment: .leading) {
                Text("관심사")
                    .font(bold26Font)
                    .foregroundColor(.black)
                let tags: [String] = profile.interests.map { $0.name }
                TagCloudView(tags: tags)
            }
            .padding(Size.w(22))
            .background(Color.yellow350)
        }
    }
}

#Preview {
    ExpandedView(profile: Profile(id: "", images: [], interests: []))
}
