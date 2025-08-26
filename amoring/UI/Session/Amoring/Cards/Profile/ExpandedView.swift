//
//  ExpandedView.swift
//  amoring
//
//  Created by 이준녕 on 12/14/23.
//

import SwiftUI
import Kingfisher
import AmoringAPI

struct ExpandedView: View {
    let profile: ProfileInfo
    var unblur: Bool = false
    
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
            if !(profile.interests?.isEmpty ?? true) {
                VStack(alignment: .leading) {
                    Text("관심사")
                        .font(bold26Font)
                        .foregroundColor(.black)
                    if let tags = profile.interests?.map({ $0?.name }) {
                        TagCloudView(tags: tags)
                    }
                    
                }
                .padding(Size.w(22))
                .background(Color.yellow350)
            }
            
            if let images = profile.images?.compactMap({ $0.map({ $0.fragments.imageFragment.file?.url })}) {
                VStack(spacing: 0) {
                    let imgs = (images.count < 2) ? images : Array(images.dropFirst())
                    
                    ForEach(imgs, id: \.self) { url in
                        VStack(spacing: 0) {
                            Color.gray1000.frame(height: 2).frame(minWidth: UIScreen.main.bounds.width)
                            //                        Color.red.frame(height: 300)
                            let url = URL(string: url ?? "")
                            let isBlurred = unblur ? false : profile.isBlurred ?? false
                            KFImage.url(url)
                                .resizable()
                                .placeholder {
                                    ProgressView().progressViewStyle(CircularProgressViewStyle(tint: Color.gray1000))
                                }
                                .fade(duration: 1)
                                .cancelOnDisappear(true)
                                .aspectRatio(contentMode: .fit)
//                            CachedAsyncImage(url: URL(string: url ?? ""), content: { cont in
//                                cont
//                                    .resizable()
//                                    .scaledToFill()
                                .blur(radius: isBlurred ? 6 : 0)
                                    .frame(minHeight: Size.w(150))
//                            }, placeholder: {
//                                ZStack {
//                                    ProgressView().progressViewStyle(CircularProgressViewStyle(tint: Color.gray1000))
//                                }
//                            })
                        }
                    }
                }
                .padding(.top, Size.w(28))
            }
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
        if !(profile.interests?.isEmpty ?? true) {
            VStack(alignment: .leading) {
                Text("관심사")
                    .font(bold26Font)
                    .foregroundColor(.black)
                if let tags = profile.interests?.map({ $0?.name }) {
                    TagCloudView(tags: tags)
                }
            }
            .padding(Size.w(22))
            .background(Color.yellow350)
        }
    }
}

//#Preview {
//    ExpandedView(profile: Profile(id: "", images: [], interests: []))
//}


struct MyExpandedView: View {
    let profile: Profile
    
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
            if !(profile.interests.isEmpty) {
                VStack(alignment: .leading) {
                    Text("관심사")
                        .font(bold26Font)
                        .foregroundColor(.black)
                   let tags = profile.interests.map({ $0.name }) 
                        TagCloudView(tags: tags)
                    }
                    
                
                .padding(Size.w(22))
                .background(Color.yellow350)
            }
            
             let images = profile.images.compactMap({ $0.file?.url })
                VStack(spacing: 0) {
                    
                    let imgs = Array(images.dropFirst())
                    
                    ForEach(imgs, id: \.self) { url in
                        VStack(spacing: 0) {
                            Color.gray1000.frame(height: 2).frame(minWidth: UIScreen.main.bounds.width)
                            //                        Color.red.frame(height: 300)
                            let url = URL(string: url)

                            KFImage.url(url)
                                .resizable()
                                .placeholder {
                                    ProgressView().progressViewStyle(CircularProgressViewStyle(tint: Color.gray1000))
                                }
                                .fade(duration: 1)
                                .cancelOnDisappear(true)
                                .aspectRatio(contentMode: .fit)
//                            CachedAsyncImage(url: URL(string: url ?? ""), content: { cont in
//                                cont
//                                    .resizable()
//                                    .scaledToFill()
                                    .blur(radius: profile.isBlurred ? 6 : 0)
                                    .frame(minHeight: Size.w(150))
//                            }, placeholder: {
//                                ZStack {
//                                    ProgressView().progressViewStyle(CircularProgressViewStyle(tint: Color.gray1000))
//                                }
//                            })
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
        if !(profile.interests.isEmpty) {
            VStack(alignment: .leading) {
                Text("관심사")
                    .font(bold26Font)
                    .foregroundColor(.black)
                let tags = profile.interests.map({ $0.name })
                    TagCloudView(tags: tags)
                
            }
            .padding(Size.w(22))
            .background(Color.yellow350)
        }
    }
}
