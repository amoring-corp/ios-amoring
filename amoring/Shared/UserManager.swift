//
//  UserManager.swift
//  amoring
//
//  Created by 이준녕 on 11/22/23.
//

import SwiftUI
import AmoringAPI
import Apollo

class UserManager: ObservableObject {
    @Published var user: User? = nil
    @Published var isLoading: Bool = false
    
    func createUserProfile(user: User, completion: @escaping (Bool) -> Void) {
        self.isLoading = true
        NetworkService.shared.amoring.perform(mutation: UpsertMyUserProfileMutation(data: UserProfileUpdateInput(user.data))) { result in
            switch result {
            case .success(let value):
                guard value.errors == nil else {
                    print(value.errors)
                    self.isLoading = false
                    completion(false)
                    return
                }
                
                guard let data = value.data else {
                    print("NO DATA!")
                    self.isLoading = false
                    completion(false)
                    return
                }
                
                self.user = user
                print("User was successfully onboarded!")
                self.isLoading = false
                completion(true)
            case .failure(let error):
                debugPrint(error.localizedDescription)
                self.isLoading = false
                completion(false)
            }
        }
    }
    
    func uploadMyProfileImages(images: [UIImage], completion: @escaping (String?) -> Void) {
        self.isLoading = true
        
        var inputArray: [UserProfileImageInput] = []
        var files: [GraphQLFile] = []
        
        for (index,image) in images.enumerated(){
            let resizedImage = ImageHelper().resizeImage(image: image, targetSize: CGSize(width: 102, height: 102))
            if let data = resizedImage!.jpegData(compressionQuality: 1.0) {
//                guard let file = Upload(data: data, encoding: .utf8) else {
//                    print("error")
//                    completion(nil)
//                    return
//                }
//                let file = GraphQLFile(fieldName: "image\(index)", originalName: "image\(index)", mimeType: "image/jpeg", data: data)
                let file = GraphQLFile(fieldName: "image0", originalName: "image0", data: data)
                
//                let sort = GraphQLNullable<Int>(integerLiteral: index)
//                let imageInput = UserProfileImageInput(sort: sort, file: "$image\(index)")
//                print("imageInput: \(imageInput)")
//                inputArray.append(imageInput)
                files.append(file)
                
            } else {
                print("wrong image data!")
            }
        }
        print("sending: \(files.map({ $0.fieldName }))")
        print("sending: \(inputArray.map({ $0.file.description }))")
        
//        NetworkService.shared.amoring.perform(mutation: UploadMyProfileImagesMutation(image0: "image0")) { result in
        NetworkService.shared.amoring.upload(operation: UploadMyProfileImagesMutation(image0: "image0"), files: files) { result in
            switch result {
            case .success(let value):
                guard value.errors == nil else {
                    print(value.errors)
                    self.isLoading = false
                    completion(nil)
                    return
                }
                
                guard let data = value.data else {
                    print("NO DATA!")
                    self.isLoading = false
                    completion(nil)
                    return
                }
                
                print("Images was successfully uploaded!")
                print(data.uploadMyProfileImages)
                self.isLoading = false
                completion(data.uploadMyProfileImages.description)
            case .failure(let error):
                print(error)
                debugPrint(error.localizedDescription)
                self.isLoading = false
                completion(nil)
            }
        }
    }
    
    func updateUserProfile(
        name: String? = nil,
        age: Int? = nil,
        birthYear: Int? = nil,
        height: Int? = nil,
        weight: Int? = nil,
        mbti: String? = nil,
        education: String? = nil,
        bio: String? = nil,
        gender: String? = nil
    ) {
        // MARK: Or same as create?
        var data = InputDict([:])
        
        if let name { data["name"] = name }
        if let age { data["age"] = age }
        if let birthYear { data["birthYear"] = birthYear }
        // FIXME: after deploy 'height'
        if let height { data["heigth"] = height }
        if let weight { data["weight"] = weight }
        if let mbti { data["mbti"] = mbti }
        if let education { data["education"] = education }
        if let bio { data["bio"] = bio }
        if let gender { data["gender"] = gender }
        
        NetworkService.shared.amoring.perform(mutation: UpsertMyUserProfileMutation(data: UserProfileUpdateInput(data))) { result in
            switch result {
            case .success(let value):
                guard value.errors == nil else {
                    print(value.errors)
                    return
                }
                
                guard let data = value.data else {
                    print("NO DATA!")
                    return
                }
                
                print(data.upsertMyUserProfile)
                
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        }
    }
}
