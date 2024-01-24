//
//  NearbyView.swift
//  amoring
//
//  Created by 이준녕 on 11/20/23.
//

import SwiftUI
import CachedAsyncImage

struct NearbyView: View {
    @State var district: district = .all
    @State var scrollOffset: CGFloat = 0
    
    var body: some View {
        TrackableScrollView(contentOffset: $scrollOffset) {
            DistrictsView(selectedChip: $district)
            
            BusinessListView(scrollOffset: $scrollOffset, district: $district)
           
        }
        .frame(maxWidth: .infinity)
        .background(Color.gray1000)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("AMORING")
                    .font(bold20Font)
                    .foregroundColor(.yellow300)
            }
        }
        .navigationBarItems(trailing:
                                Button(action: {
        }) {
            Image("ic-info")
                .resizable()
                .scaledToFit()
                .frame(width: Size.w(32), height: Size.w(32))
        }
        )
    }
}

enum businessType: CaseIterable {
    case all, lounge, pub, bar, kr_bar, club
    
    func title() -> String {
        switch self {
        case .all:
            return "전체"
        case .lounge:
            return "라운지"
        case .pub:
            return "펍"
        case .bar:
            return "바"
        case .kr_bar:
            return "포차"
        case .club:
            return "클럽"
        }
    }
}

enum district: Int {
    case all, gangnam, itaewon, hongdae, apgujeong, other
    
    func title() -> String {
        switch self {
        case .all:
            "전체"
        case .gangnam:
            "강남"
        case .itaewon:
            "이태원"
        case .hongdae:
            "홍대"
        case .apgujeong:
            "압구정"
        case .other:
            "기타"
        }
    }
}

enum businessSorting: CaseIterable {
    case recs, name, distance
    
    func title() -> String {
        switch self {
        case .recs:
            return "추천순"
        case .name:
            return "이름순"
        case .distance:
            return "거리순"
        }
    }
}

struct BusinessListView: View {
    @EnvironmentObject var userManager: UserManager
    @Binding var scrollOffset: CGFloat
    @Binding var district: district
    
    @State var type: businessType = .all
    @State var sorting: businessSorting = .recs
    
    var body: some View {
        LazyVStack(alignment: .center, spacing: 0, pinnedViews: [.sectionHeaders]) {
            count
                .padding(.horizontal, Size.w(22))
                .padding(.bottom, Size.w(15))
                .opacity(CGFloat(1) - (scrollOffset / Size.w(200)))
            
            Section(header:
                        VStack {
                Divider()
                
                HStack(alignment: .center) {
                    if scrollOffset > Size.w(200) {
                        count
                    }
                    
                    Spacer()
                    
                    Menu {
                        Picker(selection: $type, label: EmptyView()) {
                            ForEach(businessType.allCases, id: \.self) {
                                Text($0.title())
                                    .font(regular16Font)
                                    .foregroundColor(.yellow300)
                            }
                        }
                    } label: {
                        HStack {
                            Text(type.title())
                                .font(regular16Font)
                            Image(systemName: "chevron.down")
                                .resizable()
                                .scaledToFit()
                                .frame(width: Size.w(8))
                        }
                        .frame(minWidth: Size.w(60), alignment: .trailing)
                        .foregroundColor(.yellow300)
                    }
                    .padding(.trailing, Size.w(12))
                    .onChange(of: type) { newType in
                        filter(newType: newType)
                    }
                    .onChange(of: district) { newDistrict in
                        filter(newDistrict: newDistrict)
                    }
                    
                    Divider().frame(height: Size.w(24))
                    
                    Menu {
                        Picker(selection: $sorting, label: EmptyView()) {
                            ForEach(businessSorting.allCases, id: \.self) {
                                Text($0.title())
                                    .font(regular16Font)
                                    .foregroundColor(.yellow300)
                            }
                        }
                    } label: {
                        HStack {
                            Text(sorting.title())
                                .font(regular16Font)
                            Image(systemName: "chevron.down")
                                .resizable()
                                .scaledToFit()
                                .frame(width: Size.w(8))
                        }
                        .frame(minWidth: Size.w(60), alignment: .leading)
                        .foregroundColor(.yellow300)
                    }
                    .padding(.leading, Size.w(12))
                    .onChange(of: sorting) { sorting in
                        sort(sorting: sorting)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, Size.w(22))
                .padding(.vertical, Size.w(10))
                
                Divider()
                    .opacity(scrollOffset / Size.w(200))
                
            }
                .background(Color.gray1000)
                    
            ) {
                ForEach(userManager.businesses, id: \.self.id) { business in
                    BusinessRow(business: business)
                }
            }
            Spacer(minLength: 200)
        }
        
        .onAppear {
            userManager.getBusinesses()
        }
    }
    
    var count: some View {
        HStack {
            Text("라운지")
            Text("(\(userManager.businesses.count.description))")
            Spacer()
        }
        .font(medium18Font)
        .foregroundColor(.yellow300)
    }
    
    private func filter(newType: businessType? = nil, newDistrict: district? = nil) {
        if let newType {
            switch newType {
            case .all:
                userManager.businesses = userManager.businessesInit
            default:
                userManager.businesses = userManager.businessesInit.filter { $0.businessCategory == newType.title() }
            }
            
            switch self.district {
            case .all:
                userManager.businesses = userManager.businesses
            default:
                userManager.businesses = userManager.businesses.filter { $0.district == self.district.title() }
            }
        }
        
        if let newDistrict {
            switch newDistrict {
            case .all:
                userManager.businesses = userManager.businessesInit
            default:
                userManager.businesses = userManager.businessesInit.filter { $0.district == newDistrict.title() }
            }
            
            switch self.type {
            case .all:
                userManager.businesses = userManager.businesses
            default:
                userManager.businesses = userManager.businesses.filter { $0.businessCategory == self.type.title() }
            }
        }
        
        sort(sorting: self.sorting)
    }
    
    private func sort(sorting: businessSorting) {
        switch sorting {
        case .recs:
            // TODO: Implement recommendations
            userManager.businesses = userManager.businesses.sorted(by: { $0.district ?? "" > $1.district ?? ""})
        case .name:
            userManager.businesses = userManager.businesses.sorted(by: { $0.businessName ?? "" < $1.businessName ?? ""})
        case .distance:
            // TODO: Implement distance
            userManager.businesses = userManager.businesses.sorted(by: { $0.businessName ?? "" > $1.businessName ?? ""})
        }
    }
}

struct BusinessRow: View {
    @EnvironmentObject var navigator: NavigationController
    let business: Business
    
    var body: some View {
        HStack(alignment: .bottom) {
            let url = business.images?.first?.file?.url
            
            CachedAsyncImage(url: URL(string: url ?? ""), content: { cont in
                cont
                    .resizable()
                    .scaledToFill()
            }, placeholder: {
                ZStack {
                    ProgressView().progressViewStyle(CircularProgressViewStyle(tint: Color.gray1000))
                }
            })
            .frame(width: Size.w(90), height: Size.w(90))
            .clipShape(RoundedRectangle(cornerRadius: 14))
            .overlay(
                RoundedRectangle(cornerRadius: 14).stroke(Color.gray700)
            )
            
            VStack(alignment: .leading, spacing: Size.w(10)) {
                Text(business.businessName ?? "")
                    .font(semiBold20Font)
                    .foregroundColor(.gray200)
                HStack {
                    Text("\(business.businessCategory ?? "")  |  \(business.district ?? "")")
                    
                    Spacer()
                    
                    // TODO: get range from location and business .. what? lat and long?
                    Text("1.0km")
                }
                .font(regular16Font)
                .foregroundColor(.gray600)
            }
            .padding(.bottom, Size.w(6))
        }
        .padding(.horizontal, Size.w(22))
        .padding(.vertical, Size.w(11))
        .listRowSeparator(.hidden)
        .listRowInsets(EdgeInsets())
        .listRowBackground(Color.clear)
        .onTapGesture {
            navigator.selectedBusiness = business
            navigator.path.append(NavigatorPath.business)
        }
    }
}

struct DistrictsView: View {
    @Binding var selectedChip: district
    
    var body: some View {
        VStack(alignment: .leading, spacing: Size.w(20)) {
            Text("지역")
                .font(medium18Font)
                .foregroundColor(.yellow300)
            
            HStack(spacing: 0) {
                DistrictChip(selectedChip: $selectedChip, district: .all)
                    .padding(.trailing, Size.w(12))
                Divider()
                    .frame(height: Size.w(24))
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        DistrictChip(selectedChip: $selectedChip, district: .gangnam)
                        DistrictChip(selectedChip: $selectedChip, district: .itaewon)
                        DistrictChip(selectedChip: $selectedChip, district: .hongdae)
                        DistrictChip(selectedChip: $selectedChip, district: .apgujeong)
                        DistrictChip(selectedChip: $selectedChip, district: .other)
                    }.padding(.horizontal, Size.w(12))
                }
            }
        }
        .padding(.top, Size.w(20))
        .padding(.bottom, Size.w(60))
        .padding(.leading, Size.w(22))
    }
}

struct DistrictChip: View {
    @Binding var selectedChip: district
    let district: district
    
    var body: some View {
        Text(district.title())
            .font(regular16Font)
            .foregroundColor(selectedChip == district ? .yellow300 : .yellow600)
            .padding(.vertical, Size.w(8))
            .padding(.horizontal, Size.w(20))
            .background(selectedChip == district ? Color.yellow350.opacity(0.15) : Color.clear)
            .clipShape(Capsule())
            .overlay(
                Capsule().stroke(selectedChip == district ? Color.yellow300 : Color.yellow800)
            )
            .padding(2)
            .onTapGesture {
                withAnimation {
                    selectedChip = selectedChip == district ? .all : district
                }
            }
    }
}

#Preview {
    NearbyView()
}
