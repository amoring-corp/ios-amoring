//
//  File.swift
//  amoring
//
//  Created by 이준녕 on 1/26/24.
//

import Foundation
import AmoringAPI

struct File: Hashable {
    var id: String?
    var name: String?
    var mimetype: String?
    var url: String?
    var path: String?
    var width: String?
    var height: String?
    var createdAt: Date?
    var updatedAt: Date?
    
    init(file: UserInfo.Profile.Image.File?) {
        self.url = file?.url
    }
    
    init(file: BusinessInfo.Image.File?) {
        self.url = file?.url
    }
    
    init(file: UploadBusinessImageMutation.Data.UploadBusinessImage.File?) {
        self.url = file?.url
    }
}
