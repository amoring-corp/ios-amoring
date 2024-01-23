//
//  TagCloudView.swift
//  amoring
//
//  Created by 이준녕 on 12/14/23.
//

import SwiftUI

struct TagCloudView: View {
    var tags: [String?]
    @State var totalHeight
          = CGFloat.zero       // << variant for ScrollView/List
    //    = CGFloat.infinity   // << variant for VStacktotalHeight: CGFloat.infinity, 
    var isDark: Bool = false
    
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                self.generateContent(in: geometry)
            }
        }
        .frame(height: totalHeight)// << variant for ScrollView/List
        //.frame(maxHeight: totalHeight) // << variant for VStack
    }

    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        let filteredTags = self.tags.filter({ $0 != nil })
        
        return ZStack(alignment: .topLeading) {
            ForEach(filteredTags, id: \.self) { tag in
                self.item(for: tag)
                    .padding(.trailing, 8)
                    .padding(.vertical, 4)
                    .alignmentGuide(.leading, computeValue: { d in
                        if (abs(width - d.width) > g.size.width)
                        {
                            width = 0
                            height -= d.height
                        }
                        let result = width
                        if tag == filteredTags.last! {
                            width = 0 //last item
                        } else {
                            width -= d.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: {d in
                        let result = height
                        if tag == filteredTags.last! {
                            height = 0 // last item
                        }
                        return result
                    })
            }
        }.background(viewHeightReader($totalHeight))
    }

    private func item(for text: String?) -> some View {
        text == nil ? nil : Chip(text: text ?? "", isDark: isDark)
    }

    private func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
        return GeometryReader { geometry -> Color in
            let rect = geometry.frame(in: .local)
            DispatchQueue.main.async {
                binding.wrappedValue = rect.size.height
            }
            return .clear
        }
    }
}

struct Chip: View {
    let text: String
    var isDark: Bool = false
    
    var body: some View {
        Text(text)
            .font(medium16Font)
            .foregroundColor(isDark ? .gray150 : .black)
            .lineLimit(1)
            .padding(.horizontal, Size.w(18))
            .padding(.vertical, Size.w(8))
            .background(isDark ? Color.gray1000 : Color.yellow300)
            .clipShape(Capsule())
    }
}


struct TagCloudViewSelectable: View {
    let cat: InterestCategory
    @Binding var selectedInterests: [(String, String)]
    var selectedBG: Color = Color.gray1000
    var selectedColor: Color = Color.black
    var titleColor: Color = Color.gray200
    
    @State var totalHeight
          = CGFloat.zero       // << variant for ScrollView/List
    //    = CGFloat.infinity   // << variant for VStacktotalHeight: CGFloat.infinity,

    var body: some View {
        VStack(alignment: .leading) {
            Text(cat.name)
                .font(regular16Font)
                .foregroundColor(titleColor)
                .padding(.leading, Size.w(14))
            GeometryReader { geometry in
                self.generateContent(in: geometry)
            }
        }
        .frame(height: totalHeight)// << variant for ScrollView/List
        //.frame(maxHeight: totalHeight) // << variant for VStack
        
        .padding(.bottom, Size.w(30))
    }

    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        
//        let interests = {
//            switch cat {
//            case .interest:
//                Constants.interests
//            case .music:
//                Constants.music
//            case .food:
//                Constants.food_drink
//            case .travel:
//                Constants.travel
//            case .movie:
//                Constants.movies_novels
//            case .sport:
//                Constants.sport
//            }
//        }()
        
        return ZStack(alignment: .topLeading) {
            if cat.interests != nil {
                ForEach(cat.interests!, id: \.self) { interest in
                    self.item(id: interest.id, text: interest.name)
                        .padding(.trailing, 8)
                        .padding(.vertical, 4)
                        .alignmentGuide(.leading, computeValue: { d in
                            if (abs(width - d.width) > g.size.width)
                            {
                                width = 0
                                height -= d.height
                            }
                            let result = width
                            if interest == cat.interests?.last! {
                                width = 0 //last item
                            } else {
                                width -= d.width
                            }
                            return result
                        })
                        .alignmentGuide(.top, computeValue: {d in
                            let result = height
                            if interest == cat.interests?.last! {
                                height = 0 // last item
                            }
                            return result
                        })
                        .onTapGesture {
                            if !self.selectedInterests.contains(where: { $0.0 == interest.id }) {
                                if selectedInterests.count < 7 {
                                    withAnimation(.smooth) {
                                        self.selectedInterests.append((interest.id, interest.name))
                                    }
                                }
                            } else {
                                withAnimation(.smooth) {
                                    self.selectedInterests.removeAll(where: { $0.0 == interest.id })
                                }
                            }
                        }
                }
            }
            
        }.background(viewHeightReader($totalHeight))
    }

    private func item(id: String, text: String) -> some View {
        InterestChip(selectedInterests: $selectedInterests, id: id, text: text, selectedBG: selectedBG, selectedColor: selectedColor)
    }

    private func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
        return GeometryReader { geometry -> Color in
            let rect = geometry.frame(in: .local)
            DispatchQueue.main.async {
                binding.wrappedValue = rect.size.height
            }
            return .clear
        }
    }
}

struct InterestChip: View {
    @Binding var selectedInterests: [(String, String)]
    let id: String
    let text: String
    
    var selectedBG: Color = Color.gray1000
    var selectedColor: Color = Color.gray150
    
    var body: some View {
        let selected = selectedInterests.contains(where: { $0.0 == id })
        Text(text)
            .font(medium16Font)
            .foregroundColor(selected ? selectedColor : .black)
            .lineLimit(1)
            .padding(.horizontal, Size.w(18))
            .padding(.vertical, Size.w(8))
            .background(selected ? selectedBG : Color.white)
            .clipShape(Capsule())
            .opacity((selectedInterests.count >= 7 && !selected) ? 0.5 : 1)
    }
}

struct TagCloudViewSelected: View {
    @Binding var selectedInterests: [(String, String)]
    @State var totalHeight
          = CGFloat.zero       // << variant for ScrollView/List
    //    = CGFloat.infinity   // << variant for VStacktotalHeight: CGFloat.infinity,
    var isDark: Bool = false
    
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                self.generateContent(in: geometry)
            }
        }
//        .frame(height: totalHeight)// << variant for ScrollView/List
        .frame(maxHeight: totalHeight) // << variant for VStack
    }

    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        
        return ZStack(alignment: .topLeading) {
            ForEach(selectedInterests, id: \.self.0) { tag in
                self.item(id: tag.0, text: tag.1)
                    .padding(.trailing, 8)
                    .padding(.vertical, 4)
                    .alignmentGuide(.leading, computeValue: { d in
                        if (abs(width - d.width) > g.size.width)
                        {
                            width = 0
                            height -= d.height
                        }
                        let result = width
                        if tag == selectedInterests.last! {
                            width = 0 //last item
                        } else {
                            width -= d.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: {d in
                        let result = height
                        if tag == selectedInterests.last! {
                            height = 0 // last item
                        }
                        return result
                    })
            }
        }.background(viewHeightReader($totalHeight))
    }

    private func item(id: String?, text: String?) -> some View {
        text == nil ? nil : ChipSelected(selectedInterests: $selectedInterests, id: id ?? "", text: text ?? "", isDark: isDark)
    }

    private func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
        return GeometryReader { geometry -> Color in
            let rect = geometry.frame(in: .local)
            DispatchQueue.main.async {
                binding.wrappedValue = rect.size.height
            }
            return .clear
        }
    }
}

struct ChipSelected: View {
    @Binding var selectedInterests: [(String, String)]
    let id: String
    let text: String
    let isDark: Bool
    
    var body: some View {
        Text(text)
            .font(medium16Font)
            .foregroundColor(isDark ? .black : .gray150)
            .lineLimit(1)
            .padding(.horizontal, Size.w(18))
            .padding(.vertical, Size.w(8))
            .background(isDark ? Color.yellow300 : Color.gray1000)
            .clipShape(Capsule())
            .onTapGesture {
                withAnimation {
                    selectedInterests.removeAll(where: { $0.0 == id })
                }
            }
    }
}


//#Preview {
//    TagCloudView(tags: [])
//    TagCloudViewSelectable(cat: .interest, selectedInterests: .constant([]))
//}
