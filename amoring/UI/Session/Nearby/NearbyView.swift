//
//  NearbyView.swift
//  amoring
//
//  Created by 이준녕 on 11/20/23.
//

import SwiftUI
import CachedAsyncImage
import CoreLocationUI
import CoreLocation
import AmoringAPI

struct NearbyView: View {
    @EnvironmentObject var navigationController: NavigationController
    @StateObject var locationManager = LocationManager()
    @State var district: District = District.all
    @State var scrollOffset: CGFloat = 0
    
    var body: some View {
        ZStack {
            if locationManager.locationStatus == .authorizedAlways || locationManager.locationStatus == .authorizedWhenInUse {
                NavigationView {
                    TrackableScrollView(contentOffset: $scrollOffset) {
//                        Text("location status: \(locationManager.statusString)")
//                        Text("\(locationManager.lastLocation?.coordinate.latitude ?? 0), \(locationManager.lastLocation?.coordinate.longitude ?? 0)")
                        DistrictsView(selectedChip: $district)
                            .environmentObject(locationManager)
                        
                        BusinessListView(scrollOffset: $scrollOffset, selectedChip: $district)
                            .environmentObject(locationManager)
                        
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
                    .navigationBarItems(
                        trailing: Button(action: {
                            //                showInfo.toggle()
                        }) {
                            Image("ic-info")
                                .resizable()
                                .scaledToFit()
                                .frame(width: Size.w(32), height: Size.w(32))
                        }
                    )
                }
            } else {
                LocationAccessScreen().environmentObject(locationManager)
            }
        }
    }
}

struct LocationAccessScreen: View {
    @EnvironmentObject var locationManager: LocationManager
    var body: some View {
        VStack {
            LocationButton(.shareMyCurrentLocation, action: {
                locationManager.requestAlwaysAuthorization()
            })
        }
    }
}

enum businessType: CaseIterable {
    case all, club, lounge, bar, pub, kr_bar, jujeob, hoff, izakaya, cafe, festival
    //    ["클럽", "라운지", "바", "펍", "포차", "주점", "호프", "이자카야", "카페", "페스티벌"]
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
        case .jujeob:
            return "주점"
        case .hoff:
            return "호프"
        case .izakaya:
            return "이자카야"
        case .cafe:
            return "카페"
        case .festival:
            return "페스티벌"
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
    @EnvironmentObject var navigationController: NavigationController
    @EnvironmentObject var userManager: UserManager
    @EnvironmentObject var locationManager: LocationManager
    @Binding var scrollOffset: CGFloat
    @Binding var selectedChip: District
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
                    
                    Divider().frame(height: Size.w(24))
                    
                    Menu {
                        Picker(selection: $sorting, label: EmptyView()) {
                            ForEach(businessSorting.allCases, id: \.self) {
                                Text($0.title())
                                    .font(regular16Font)
                                    .foregroundColor(.yellow300)
                            }
                        }
                        .onChange(of: sorting) { sort in
                            action(district: selectedChip, sort: sort == .name ? .businessName : nil) { }
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
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, Size.w(22))
                .padding(.vertical, Size.w(10))
                
                Divider()
                    .opacity(scrollOffset / Size.w(200))
                
            }
                .background(Color.gray1000)
                    
            ) {
                // TODO: Implement pagination here!
//                ForEach(0..<20) { num in
//                                    Text(num.description)
//                                        .font(.title)
//                                        .padding()
//                                        .onAppear {
//                                            if num >= 19 {
//                                                userManager.isLoading = true
//                                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                                                    userManager.getBusinesses {
//                                                        userManager.isLoading = false
//                                                    }
//                                                }
//                                            }
//                                            print(num)
//                                        }
//                                }
                ForEach(userManager.businesses, id: \.self.id) { business in
                    NavigationLink(destination: {
                        BusinessDetailsView(business: Business(businessInfo: business))
                            .onAppear(perform: navigationController.hideBar)
                            .onDisappear(perform: navigationController.showBar)
                    }) {
                        BusinessRow(business: Business(businessInfo: business))
                    }
                }
            }
            Spacer(minLength: 200)
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
    
    private func action(district: District, sort: BusinessSortField? = nil, completion: @escaping () -> Void) {
        let lat = locationManager.lastLocation?.coordinate.latitude
        let lng = locationManager.lastLocation?.coordinate.longitude
        
        switch district {
        case District.all: userManager.getBusinesses(lat: lat, lng: lng, sort: sort, completion: completion)
        case District.nearby:
            userManager.getBusinesses(lat: lat, lng: lng, sort: sort, nearByOnly: true, completion: completion)
        case  District.other:
            let index = 4
            var other: [District] = []
            if userManager.districts.count > index {
                let elementsAfterIndex = Array(userManager.districts[(index + 1)...])
                other = elementsAfterIndex
                print("Elements after index \(index):", elementsAfterIndex)
            }
            userManager.getBusinesses(lat: lat, lng: lng, districts: other.map({ $0.code }), sort: sort, completion: completion)
        default:
            userManager.getBusinesses(lat: lat, lng: lng, districts: [district.code], sort: sort, completion: completion)
        }
    }
    
//    private func filter(newType: businessType? = nil, newDistrict: districtEnum? = nil) {
//        if let newType {
//            switch newType {
//            case .all:
//                userManager.businesses = userManager.businessesInit
//            default:
//                userManager.businesses = userManager.businessesInit.filter { $0.businessCategory == newType.title() }
//            }
//            
//            switch self.district {
//            case .all:
//                userManager.businesses = userManager.businesses
//            case .other:
//                userManager.businesses = userManager.businesses.filter { biz in
//                    !districtEnum.allCases.map({ $0.title() }).contains(biz.addressSigungu) }
//            default:
//                userManager.businesses = userManager.businesses.filter { $0.addressSigungu == self.district.title() }
//            }
//        }
//        
//        if let newDistrict {
//            switch newDistrict {
//            case .all:
//                userManager.businesses = userManager.businessesInit
//            case .other:
//                userManager.businesses = userManager.businessesInit.filter { biz in
//                    !districtEnum.allCases.map({ $0.title() }).contains(biz.addressSigungu) }
//            default:
//                userManager.businesses = userManager.businessesInit.filter { $0.addressSigungu == newDistrict.title() }
//            }
//            
//            switch self.type {
//            case .all:
//                userManager.businesses = userManager.businesses
//            default:
//                userManager.businesses = userManager.businesses.filter { $0.businessCategory == self.type.title() }
//            }
//        }
//        
//        sort(sorting: self.sorting)
//    }
//    
//    private func sort(sorting: businessSorting) {
//        switch sorting {
//        case .recs:
//            // TODO: backend. Implement recommendations
//            userManager.businesses = userManager.businesses.sorted(by: { $0.addressSigungu ?? "" > $1.addressSigungu ?? ""})
//        case .name:
//            userManager.businesses = userManager.businesses.sorted(by: { $0.businessName ?? "" < $1.businessName ?? ""})
//        case .distance:
//            // TODO: backend. Implement distance
//            userManager.businesses = userManager.businesses.sorted(by: { $0.businessName ?? "" > $1.businessName ?? ""})
//        }
//    }
}

struct BusinessRow: View {
    @EnvironmentObject var locationManager: LocationManager
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
                    Text("\(business.businessCategory ?? "")  |  \(business.addressSigungu ?? "")")
                    
                    Spacer()
                 
                    if let busLatitude = business.latitude, let busLongitude = business.longitude, let latitude = locationManager.lastLocation?.coordinate.latitude, let longitude = locationManager.lastLocation?.coordinate.longitude {
                        let busCoordinate = CLLocation(latitude: busLatitude, longitude: busLongitude)
                        let myCoordinate = CLLocation(latitude: latitude, longitude: longitude)
                        let distanceInMeters = busCoordinate.distance(from: myCoordinate)
                        let distanceInMetersString = String(format: "%.0f", distanceInMeters)
                        let distanceInKm = String(format: "%.1f", distanceInMeters / 1000)

                        Text(distanceInMeters > 1000 ? "\(distanceInKm) km" : "\(distanceInMetersString) m")
                            .onAppear {
                                print("bus: \(busLatitude), \(busLongitude)")
                                print("my: \(latitude), \(longitude)")
                            }
//                            .onChange(of: locationManager.lastLocation) { a in
//                                if let latitude = locationManager.lastLocation?.coordinate.latitude, let longitude =
//                                    locationManager.lastLocation?.coordinate.longitude {
//                                    let myCoordinate = CLLocation(latitude: latitude, longitude: longitude)
//                                    let distanceInMeters = busCoordinate.distance(from: myCoordinate)
//                                    print("abraca")
//                                    print(distanceInMeters)
//                                }
//                            }
                            
                    }
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
        //        .onTapGesture {
        //            navigator.selectedBusiness = business
        //            navigator.path.append(NavigatorPath.business)
        //        }
    }
}

struct DistrictsView: View {
    @EnvironmentObject var userManager: UserManager
    @Binding var selectedChip: District
    
    var body: some View {
        VStack(alignment: .leading, spacing: Size.w(20)) {
            Text("지역")
                .font(medium18Font)
                .foregroundColor(.yellow300)
            
            HStack(spacing: 0) {
                DistrictChip(selectedChip: $selectedChip, district: District.nearby)
                    .padding(.trailing, Size.w(12))
                Divider()
                    .frame(height: Size.w(24))
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        DistrictChip(selectedChip: $selectedChip, district: District.all)
                        ForEach(userManager.districts, id: \.self.id) { disctrict in
                            DistrictChip(selectedChip: $selectedChip, district: disctrict)
                        }
                        if userManager.districts.count > 5 {
                            DistrictChip(selectedChip: $selectedChip, district: District.other)
                        }
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
    @EnvironmentObject var locationManager: LocationManager
    @EnvironmentObject var userManager: UserManager
    @Binding var selectedChip: District
    let district: District
    
    var body: some View {
        Text(district.name)
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
                if selectedChip != district {
                    action(district: district) {
                        withAnimation {
                            selectedChip = district
                        }
                    }
                }
            }
    }

    private func action(district: District, sort: BusinessSortField? = nil, completion: @escaping () -> Void) {
        let lat = locationManager.lastLocation?.coordinate.latitude
        let lng = locationManager.lastLocation?.coordinate.longitude
        
        switch district {
        case District.all: userManager.getBusinesses(lat: lat, lng: lng, sort: sort, completion: completion)
        case District.nearby:
            userManager.getBusinesses(lat: lat, lng: lng, sort: sort, nearByOnly: true, completion: completion)
        case  District.other:
            let index = 4
            var other: [District] = []
            if userManager.districts.count > index {
                let elementsAfterIndex = Array(userManager.districts[(index + 1)...])
                other = elementsAfterIndex
                print("Elements after index \(index):", elementsAfterIndex)
            }
            userManager.getBusinesses(lat: lat, lng: lng, districts: other.map({ $0.code }), sort: sort, completion: completion)
        default:
            userManager.getBusinesses(lat: lat, lng: lng, districts: [district.code], sort: sort, completion: completion)
        }
    }
}

#Preview {
    NearbyView()
}
