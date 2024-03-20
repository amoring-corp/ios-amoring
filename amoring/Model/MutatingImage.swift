//
//  MutatingImage.swift
//  amoring
//
//  Created by Sergey Li on 3/7/24.
//

import Foundation
import AmoringAPI

struct MutatingImage: Hashable {
    var id: String?
    var profileId: String?
    var field: Int?
    var sort: Int?
    var file: File?
    var createdAt: Date?
    var updatedAt: Date?
    
    init(image: UserInfo.Profile.Image) {
        self.id = image.id
        self.file =  File(file: image.file)
    }
    
    init(image: ProfileInfo.Image) {
        self.id = image.id
        self.file = File(file: image.file)
    }
    
    init(image: ConversationInfo.Participant.Profile.Image) {
        self.id = image.id
        self.file = File(file: image.file)
    }
    
    init(image: BusinessInfo.Image) {
        self.id = image.id
        self.file = File(file: image.file)
    }
    
    init(image: BusinessInfo.ActiveCheckIn.Profile.Image) {
        self.id = image.id
        self.file = File(file: image.file)
    }
    
}
