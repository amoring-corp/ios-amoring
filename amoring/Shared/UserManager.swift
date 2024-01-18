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
    @Published var userState: UserState = .initial
    let authUser: User
    @Published var api: ApolloClient
    @Published var user: User? = nil
    @Published var isLoading: Bool = false
    @Published var interestCategories: [InterestCategory] = []
    @Published var businessesInit: [Business] = []
    @Published var businesses: [Business] = []
    @Published var profiles: [UserProfile] = []
    
    init(authUser: User, api: ApolloClient) {
        self.authUser = authUser
        self.api = api
        self.user = authUser
        guard let role = authUser.role else {
            print("NO ROLE!")
            self.changeStateWithAnimation(state: .error)
            return
        }
        
        switch role {
        case .business:
            print("I'm a business")
            
            if let businessProfile = authUser.business {
                print("going to Business Session")
                print(businessProfile)
                //TODO:  pass whole business user here!
                self.changeStateWithAnimation(state: .businessSession)
            } else {
//                print("Business not onboarded yet")
                self.changeStateWithAnimation(state: .businessOnboarding)
            }
        case .user:
            print("I'm a user")

            if let userProfile = authUser.userProfile, !userProfile.interests.isEmpty {
//                if userProfile.images.isEmpty {
//                    print("going to Image uploading")
//                    print(userProfile.images.first?.file?.url as Any)
//                    self.changeStateWithAnimation(state: .imageUploading)
//                } else if userProfile.interests.isEmpty {
//                    print("going to Interests Connecting")
//                    self.changeStateWithAnimation(state: .interestsConnection)
//                } else {
                    print("going to User Session")
                    self.changeStateWithAnimation(state: .session)
//                }
            } else {
                print("User not onboarded yet")
                self.changeStateWithAnimation(state: .userOnboarding)
            }
        case .admin:
            print("I'm an admin")
            self.changeStateWithAnimation(state: .debugging)
        }
    }
    
    func createUserProfile(userProfile: UserProfile, completion: @escaping (Bool) -> Void) {
        self.isLoading = true
        let input = UserProfileData(userProfile: userProfile).data
        api.perform(mutation: UpsertMyUserProfileMutation(data: UserProfileUpdateInput(input))) { result in
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
                
                self.user?.userProfile = userProfile
                print("User Profile was successfully created!")
                self.isLoading = false
                completion(true)
            case .failure(let error):
                debugPrint(error.localizedDescription)
                self.isLoading = false
                completion(false)
            }
        }
    }
    
    func uploadMyProfileImages(images: [UIImage], completion: @escaping (Bool) -> Void) {
        self.isLoading = true
        
        let dispatchGroup = DispatchGroup()
        for (index,image) in images.enumerated(){
            let resizedImage = ImageHelper().resizeImage(image: image, targetSize: CGSize(width: 1024, height: 1024))
            if let data = resizedImage!.jpegData(compressionQuality: 1.0) {
                dispatchGroup.enter()

                // TODO: test with image\(index).jpeg
                let file = GraphQLFile(fieldName: "image", originalName: "image\(index)", mimeType: "image/jpeg", data: data)
                self.saveImage(file: file, sort: index) { success in
                    dispatchGroup.leave()
                }
            } else {
                print("wrong image data!")
                completion(true)
            }
        }
        dispatchGroup.notify(queue: DispatchQueue.main, execute: {
            
            self.isLoading = false
            print("sending: \(images.count) images finished")
            completion(true)
        })
    }
    
    
    private func saveImage(file: GraphQLFile, sort: Int, completion: @escaping (Bool) -> Void) {
        api.upload(operation: UploadMyProfileImagesMutation(image: "image", sort: sort), files: [file]) { result in
            switch result {
            case .success(let value):
                guard value.errors == nil else {
                    print(value.errors)
                    completion(false)
                    return
                }
                
                guard let data = value.data else {
                    print("NO DATA!")
                    completion(false)
                    return
                }
                
                print("Image was successfully uploaded!")
                print(data.uploadMyProfileImages)
                completion(true)
            case .failure(let error):
                print(error)
                debugPrint(error.localizedDescription)
                completion(false)
            }
        }
    }
    
    func uploadBusinessImages(images: [UIImage], completion: @escaping (Bool) -> Void) {
        self.isLoading = true
        
        let dispatchGroup = DispatchGroup()
        for (index,image) in images.enumerated(){
            let resizedImage = ImageHelper().resizeImage(image: image, targetSize: CGSize(width: 1024, height: 1024))
            if let data = resizedImage!.jpegData(compressionQuality: 1.0) {
                dispatchGroup.enter()

                // TODO: test with image\(index).jpeg
                let file = GraphQLFile(fieldName: "image", originalName: "image\(index)", mimeType: "image/jpeg", data: data)
                self.saveBusinessImage(file: file, sort: index) { success in
                    dispatchGroup.leave()
                }
            } else {
                print("wrong image data!")
                completion(true)
            }
        }
        dispatchGroup.notify(queue: DispatchQueue.main, execute: {
            self.isLoading = false
            print("sending: \(images.count) images finished")
            completion(true)
        })
    }
    
    private func saveBusinessImage(file: GraphQLFile, sort: Int, completion: @escaping (Bool) -> Void) {
        print("business id: \(user?.business?.id)")
        api.upload(operation: UploadBusinessImageMutation(businessId: user?.business?.id ?? "", image: "image", sort: sort), files: [file]) { result in
            switch result {
            case .success(let value):
                guard value.errors == nil else {
                    print(value.errors)
                    completion(false)
                    return
                }
                
                guard let data = value.data else {
                    print("NO DATA!")
                    completion(false)
                    return
                }
                
                print("Image was successfully uploaded!")
                print(data.uploadBusinessImage)
                completion(true)
            case .failure(let error):
                print(error)
                debugPrint(error.localizedDescription)
                completion(false)
            }
        }
    }
    
    func connectInterests(ids: [String], completion: @escaping (Bool) -> Void) {
        self.isLoading = true
        api.perform(mutation: ConnectInterestsToMyProfileMutation(interestIds: ids)) { result in
            self.isLoading = false
            switch result {
            case .success(let value):
                guard value.errors == nil else {
                    print(value.errors)
                    completion(false)
                    return
                }
                
                guard let data = value.data else {
                    print("NO DATA!")
                    completion(false)
                    return
                }
                
                print(data.connectInterestsToMyProfile.interests)
                completion(true)
            case .failure(let error):
                debugPrint(error.localizedDescription)
                completion(false)
            }
        }
    }
    
    func updateUserProfile(userProfile: UserProfile, completion: @escaping (Bool) -> Void) {
        let input = UserProfileData(userProfile: userProfile).data
        
        api.perform(mutation: UpsertMyUserProfileMutation(data: UserProfileUpdateInput(input))) { result in
            switch result {
            case .success(let value):
                guard value.errors == nil else {
                    print(value.errors)
                    completion(false)
                    return
                }
                
                guard let data = value.data else {
                    print("NO DATA!")
                    completion(false)
                    return
                }
                let fetchedProfile = data.upsertMyUserProfile
                print(data.upsertMyUserProfile.id)
                self.user?.userProfile = userProfile
                completion(true)
            case .failure(let error):
                debugPrint(error.localizedDescription)
                completion(false)
            }
        }
    }
    
    func getInterests() {
        api.fetch(query: QueryInterestCategoriesQuery()) { result in
            switch result {
            case .success(let value):
                guard value.errors == nil else {
                    print(value.errors)
//                    self.interests = Constants.interests //TODO: put dummy or default categories
                    return
                }
                
                guard let data = value.data else {
                    print("NO DATA!")
                    //                    self.interests = Constants.interests //TODO: put dummy or default categories
                    return
                }
                
                let cats = data.interestCategories
                
                for cat in cats {
                    var category = InterestCategory(
                        id: cat?.id ?? "",
                        name: cat?.name ?? "",
                        interests: []
                    )
                    
                    if let interests = cat?.interests {
                        for interest in interests {
                            category.interests?.append(interest.map{ Interest(id: $0.id, name: $0.name ?? "") }!)
                        }
                    }
                    
                    self.interestCategories.append(category)
                }
            case .failure(let error):
                debugPrint(error.localizedDescription)
                //                    self.interests = Constants.interests //TODO: put dummy or default categories
            }
        }
    }
    
    func upsertMyBusiness(business: Business, completion: @escaping (Bool) -> Void) {
        self.isLoading = true
        let data = UpdateBusinessData(business: business).data
        let input = BusinessUpdateInput(data)
        
        api.perform(mutation: UpsertMyBusinessMutation(data: input)) { result in
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
                
                
                self.user?.business = business
                self.user?.business?.id = data.upsertMyBusiness.id
                print("Business was successfully updated!")
                self.isLoading = false
                completion(true)
            case .failure(let error):
                debugPrint(error.localizedDescription)
                self.isLoading = false
                completion(false)
            }
        }
    }
    
//    func updateBusiness(business: Business, completion: @escaping (Bool) -> Void) {
//        self.isLoading = true
//        let data = UpdateBusinessData(business: business).data
//        let input = BusinessUpdateInput(data)
//        print(user?.id)
//        amoring.perform(mutation: UpdateBusinessMutation(id: user?.id ?? "", data: input)) { result in
//            switch result {
//            case .success(let value):
//                guard value.errors == nil else {
//                    print(value.errors)
//                    self.isLoading = false
//                    completion(false)
//                    return
//                }
//                
//                guard let data = value.data else {
//                    print("NO DATA!")
//                    self.isLoading = false
//                    completion(false)
//                    return
//                }
//                
//                self.user?.business = business
//                print("Business was successfully updated!")
//                self.isLoading = false
//                completion(true)
//            case .failure(let error):
//                debugPrint(error.localizedDescription)
//                self.isLoading = false
//                completion(false)
//            }
//        }
//    }
    
    func changeStateWithAnimation(state: UserState) {
        DispatchQueue.main.async {
            withAnimation {
                self.userState = state
            }
        }
    }
    
    // TODO: move to another Manager
    func getBusinesses() {
        api.fetch(query: QueryBusinessesQuery()) { result in
            switch result {
            case .success(let value):
                guard value.errors == nil else {
                    print(value.errors)
//                    self.interests = Constants.interests //TODO: put dummy or default categories
                    return
                }
                
                guard let data = value.data else {
                    print("NO DATA!")
                    //                    self.interests = Constants.interests //TODO: put dummy or default categories
                    return
                }
                
                let businesss = data.businesses
                self.businesses = []
                self.businessesInit = []
                
                for bus in businesss {
                    if let busForSave = Business().from(data: bus) {
                        self.businesses.append(busForSave)
                        self.businessesInit.append(busForSave)
                    }
                }
                
                self.businesses.append(contentsOf: Dummy.businesses)
                self.businessesInit.append(contentsOf: Dummy.businesses)
                
            case .failure(let error):
                debugPrint(error.localizedDescription)
                //                    self.interests = Constants.interests //TODO: put dummy or default categories
            }
        }
    }
    
    // TODO: move to another Manager
    func getProfiles() {
        api.fetch(query: UserProfilesQuery()) { result in
            switch result {
            case .success(let value):
                guard value.errors == nil else {
                    print(value.errors)
//                    self.interests = Constants.interests //TODO: put dummy or default categories
                    return
                }
                
                guard let data = value.data else {
                    print("NO DATA!")
                    //                    self.interests = Constants.interests //TODO: put dummy or default categories
                    return
                }
                
                let profiles = data.userProfiles
                self.profiles = []
                
                self.profiles.append(contentsOf: Dummy.userProfiles)
                
                for profile in profiles {
                    if let profile = UserProfile(id: "", images: [], interests: []).from(data: profile) {
                        //MARK:  excepting default db profile, excepting myself
                        if profile.id != "3" && profile.id != self.user?.userProfile?.id {
                            self.profiles.append(profile)
                        }
                    }
                }
                
            case .failure(let error):
                debugPrint(error.localizedDescription)
                //                    self.interests = Constants.interests //TODO: put dummy or default categories
            }
        }
    }
}
