//
//  NearbyFilterController.swift
//  amoring
//
//  Created by Sergey Li on 6/10/24.
//

import SwiftUI

class NearbyFilterController: ObservableObject {
    @Published var selectedDistrict: District = .all
    @Published var businessType: BusinessTypeModel = BusinessTypeModel(id: "ALL", name: "전체")
    @Published var sorting: businessSorting = .recs
}
