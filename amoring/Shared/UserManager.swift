//
//  UserManager.swift
//  amoring
//
//  Created by 이준녕 on 11/22/23.
//

import SwiftUI
import AmoringAPI
import Apollo
import ApolloWebSocket
import AWSSNS
import StoreKit

class UserManager: ObservableObject {
    @Published var userState: UserState = .initial
    let authUser: UserInfo
    @Published var api: ApolloClient
    @Published var WSApi: ApolloClient
    @Published var user: MutatingUser? = nil

    @Published var isLoading: Bool = false
    @Published var interestCategories: [InterestCategory] = []
    @Published var businessesInit: [BusinessInfo] = []
    @Published var businesses: [BusinessInfo] = []
    @Published var profiles: [ProfileInfo] = []
    
    @Published var pictures: [PictureModel] = []
    @Published var businessPictures: [PictureModel] = []
    
    @Published var confirmRemoveImageIndex: Int = 0
    @Published var total: Int = 0
    @Published var includeNearby: Bool = false
    
    init(authUser: UserInfo, api: ApolloClient, WSApi: ApolloClient) {
        /// unsubscripe all subscriptions . [case : business login]
//        self.messageSubscription?.cancel()
//        self.reactionSubscription?.cancel()
//        self.conversationSubscription?.cancel()

        self.authUser = authUser
        self.api = api
        self.WSApi = WSApi
        self.user = MutatingUser(userInfo: authUser)
        
        guard let role = authUser.role else {
            print("NO ROLE!")
            self.changeStateWithAnimation(state: .error)
            return
        }
        
        switch role {
        case .case(.business):
            print("I'm a business")
            if !(authUser.isEmailVerified ?? false) {
                self.changeStateWithAnimation(state: .emailValidation)
                
            } else
            if let business = authUser.business, ((business.phoneNumber?.isEmpty) != nil) {
//                DispatchQueue.main.async {
//                    UIApplication.shared.unregisterForRemoteNotifications()
//                }
                //TODO:  pass whole business user here!
                self.setBusinessPhotos()
                self.changeStateWithAnimation(state: .businessSession)
            } else {
//                print("Business not onboarded yet")
                self.changeStateWithAnimation(state: .businessOnboarding)
            }
        case .case(.user):
            print("I'm a user")
            if !(authUser.isPhoneNumberVerified ?? false) {
                self.changeStateWithAnimation(state: .phoneValidation)
            } else 
            if authUser.profile == nil {
                print("User not onboarded yet")
                self.changeStateWithAnimation(state: .userOnboarding)
            } else {
                self.setCurrentPhotos()
                self.changeStateWithAnimation(state: .session)
            }
        case .case(.admin):
            print("I'm an admin")
            self.changeStateWithAnimation(state: .debugging)
        case .unknown(_):
            print("unknown role")
            self.changeStateWithAnimation(state: .error)
        }
    }
    
    private func setCurrentPhotos() {
        guard let images = self.user?.profile?.images else { return }
        if self.pictures.map({ $0.url }).sorted() == images.map({ $0.file?.url ?? "" }).sorted() {
            
        }
        
        for image in images {
            let urlString = image.file?.url ?? ""
            guard let url = URL(string: urlString) else { return }
            let data = try? Data(contentsOf: url) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            let image = UIImage(data: data!)
            self.pictures.append(PictureModel.newPicture(image!, urlString))
        }
    }
    
    private func setBusinessPhotos() {
        guard let images = self.user?.business?.images else { return }
        // TODO: test it out
        if self.businessPictures.map({ $0.url }).sorted() == images.map({ $0.file?.url ?? "" }).sorted() {
          
        }
        
        for image in images {
            let urlString = image.file?.url ?? ""
            guard let url = URL(string: urlString) else { return }
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    self.businessPictures.append(PictureModel.newPicture(image, urlString))
                }
            }
        }
    }
    
    func refreshUser() {
        self.isLoading = true
        api.fetch(query: QueryAuthenticatedUserQuery()) { result in
            self.isLoading = false
                switch result {
                case .success(let value):
                    guard value.errors == nil else {
                        print(value.errors as Any)
                        return
                    }
                    
                    guard let data = value.data else {
                        print("WRONG DATA")
                        return
                    }
                    
                    guard let authUser = data.authenticatedUser else {
                        print("NO USER")
                        return
                    }
                    
                    self.user = MutatingUser(userInfo: authUser.fragments.userInfo)
                    
                    print(self.user?.profile?.images as Any)
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                }
        }
    }
    
    func createProfile(profile: Profile, completion: @escaping (Bool) -> Void) {
        self.isLoading = true
        let input = ProfileData(profile: profile).data
        
        api.perform(mutation: UpsertMyProfileMutation(data: ProfileUpdateInput(input))) { result in
            switch result {
            case .success(let value):
                guard value.errors == nil else {
                    print(value.errors as Any)
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
                self.user?.profile = Profile(profile: data.upsertMyProfile.fragments.profileInfo) 
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
    
//    func uploadMyProfileImages(images: [UIImage], completion: @escaping (Bool) -> Void) {
//        self.isLoading = true
//        self.pictures.removeAll()
//        self.user?.profile?.images.removeAll()
////        let dispatchGroup = DispatchGroup()
//        let dispatchQueue = DispatchQueue(label: "taskQueue")
//        let semaphore = DispatchSemaphore(value: 1)
//        var successList: [Bool] = []
//        for (index,image) in images.enumerated(){
//            dispatchQueue.async {
//                let resizedImage = ImageHelper().resizeImage(image: image, targetSize: CGSize(width: 1024, height: 1024))
//                if let data = resizedImage!.jpegData(compressionQuality: 0.8) {
//    //                dispatchGroup.enter()
//                    semaphore.wait()
//                    let file = GraphQLFile(fieldName: "image", originalName: "image\(index)", mimeType: "image/jpeg", data: data)
//                    self.saveImage(file: file, sort: index) { success in
//                        successList.append(success)
//    //                    dispatchGroup.leave()
//                        semaphore.signal()
//                        // TODO: need tests
//                        if index + 1 >= images.count {
//                            self.isLoading = false
//                            print("sending: \(successList.filter{$0}.count) images finished")
//                            completion(successList.filter{$0}.count >= 3)
//                        }
//                    }
//                } else {
//                    print("wrong image data!")
//                    self.isLoading = false
//                    completion(true)
//                }
//            }
//        }
//    }
    
    func uploadMyProfileImages(images: [UIImage], completion: @escaping (Bool) -> Void) {
        self.isLoading = true
        self.pictures.removeAll()
        self.user?.profile?.images.removeAll()
        
        let dispatchGroup = DispatchGroup()
        let dispatchQueue = DispatchQueue(label: "taskQueue")
        let syncQueue = DispatchQueue(label: "syncQueue") // Для потокобезопасного доступа к successList
        
        var successList: [Bool] = []
        
        for (index, image) in images.enumerated() {
            dispatchGroup.enter()
            dispatchQueue.async {
                let resizedImage = ImageHelper().resizeImage(image: image, targetSize: CGSize(width: 1024, height: 1024))
                if let data = resizedImage?.jpegData(compressionQuality: 0.8) {
                    let file = GraphQLFile(fieldName: "image", originalName: "image\(index)", mimeType: "image/jpeg", data: data)
                    
                    self.saveImage(file: file, sort: index) { success in
                        syncQueue.async {
                            successList.append(success)
                        }
                        dispatchGroup.leave()
                    }
                } else {
                    print("wrong image data!")
                    dispatchGroup.leave()
                }
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            self.isLoading = false
            print("sending: \(successList.filter { $0 }.count) images finished")
            completion(successList.filter { $0 }.count >= 3)
        }
    }

    
    
    
    private func saveImage(file: GraphQLFile, sort: Int, completion: @escaping (Bool) -> Void) {
        api.upload(operation: UploadMyProfileImageMutation(image: "image", sort: sort), files: [file]) { result in
            switch result {
            case .success(let value):
                guard value.errors == nil else {
                    print(value.errors as Any)
                    completion(false)
                    return
                }
                
                guard let data = value.data else {
                    print("NO DATA!")
                    completion(false)
                    return
                }
                
                print("Image was successfully uploaded!")
                print(data.uploadMyProfileImage.file?.url)
                print(sort)
                
                if self.user?.profile?.images.count ?? 0 >= sort {
                    
                    //MARK: setting avatarUrl for mutating user
                    if sort == 0 {
                        self.user?.profile?.avatarUrl = data.uploadMyProfileImage.fragments.imageFragment.file?.url
                    }
                    
                    self.user?.profile?.images.insert(MutatingImage(image: data.uploadMyProfileImage.fragments.imageFragment), at: sort)
                } else {
                    self.user?.profile?.images.append(MutatingImage(image: data.uploadMyProfileImage.fragments.imageFragment))
                }
                
                
                let urlString = data.uploadMyProfileImage.file?.url ?? ""
                guard let url = URL(string: urlString) else { return }
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        if self.pictures.count >= sort {
                            self.pictures.insert(PictureModel.newPicture(image, urlString), at: sort)
                        } else {
                            self.pictures.append(PictureModel.newPicture(image, urlString))
                        }
                    }
                }
                completion(true)
            case .failure(let error):
                print(error)
                debugPrint(error.localizedDescription)
                completion(false)
            }
        }
    }
    
//    func uploadBusinessImages(images: [UIImage], completion: @escaping (Bool) -> Void) {
//        self.isLoading = true
//        self.businessPictures.removeAll()
//        self.user?.business?.images?.removeAll()
////        let dispatchGroup = DispatchGroup()
//        let dispatchQueue = DispatchQueue(label: "taskQueue")
//        let semaphore = DispatchSemaphore(value: 1)
//        var successList: [Bool] = []
//        for (index,image) in images.enumerated() {
//            dispatchQueue.async {
//                let resizedImage = ImageHelper().resizeImage(image: image, targetSize: CGSize(width: 1024, height: 1024))
//                
//                if let data = resizedImage!.jpegData(compressionQuality: 0.8) {
//                    //                dispatchGroup.enter()
//                    semaphore.wait()
//                    let file = GraphQLFile(fieldName: "image", originalName: "image", mimeType: "image/jpeg", data: data)
//                    self.saveBusinessImage(file: file, sort: index) { success in
//                        successList.append(success)
//                        semaphore.signal()
//                        //                    dispatchGroup.leave()
//                        // TODO: need tests
//                        if index + 1 >= images.count {
//                            self.isLoading = false
//                            print("sending: \(successList.filter{$0}.count) images finished")
//                            completion(successList.filter{$0}.count >= 3)
//                        }
//                    }
//                } else {
//                    print("wrong image data!")
//                    completion(true)
//                }
//            }
//        }
//    }
    
    func uploadBusinessImages(images: [UIImage], completion: @escaping (Bool) -> Void) {
        self.isLoading = true
        self.businessPictures.removeAll()
        self.user?.business?.images?.removeAll()
        
        let dispatchGroup = DispatchGroup()
        let dispatchQueue = DispatchQueue(label: "taskQueue")
        let syncQueue = DispatchQueue(label: "syncQueue") // Для потокобезопасного доступа к successList
        
        var successList: [Bool] = []
        
        for (index, image) in images.enumerated() {
            dispatchGroup.enter()
            dispatchQueue.async {
                print("\(image.cgImage?.size), index: \(index)")
            
                let resizedImage = ImageHelper().resizeImage(image: image, targetSize: CGSize(width: 1024, height: 1024))
                
                if let data = resizedImage?.jpegData(compressionQuality: 0.8) {
                    let file = GraphQLFile(fieldName: "image", originalName: "image", mimeType: "image/jpeg", data: data)
                    
                    self.saveBusinessImage(file: file, sort: index) { success in
                        syncQueue.async {
                            successList.append(success)
                        }
                        dispatchGroup.leave()
                    }
                } else {
                    print("wrong image data!")
                    dispatchGroup.leave()
                }
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            self.isLoading = false
            print("sending: \(successList.filter { $0 }.count) images finished")
            completion(successList.filter { $0 }.count >= 3)
        }
    }
    
    private func saveBusinessImage(file: GraphQLFile, sort: Int, completion: @escaping (Bool) -> Void) {
        print("business id: \(String(describing: user?.business?.id))")
        api.upload(operation: UploadBusinessImageMutation(businessId: user?.business?.id ?? "", image: "image", sort: sort), files: [file]) { result in
            switch result {
            case .success(let value):
                guard value.errors == nil else {
                    print(value.errors as Any)
                    completion(false)
                    return
                }
                
                guard let data = value.data else {
                    print("NO DATA!")
                    completion(false)
                    return
                }
                
                print("Image: \(data.uploadBusinessImage.file?.url)  ..uploaded!")
                print(sort)
                
                if self.user?.business?.images?.count ?? 0 >= sort {
                    self.user?.business?.images?.insert(MutatingImage(image: data.uploadBusinessImage), at: sort)
                } else {
                    self.user?.business?.images?.append(MutatingImage(image: data.uploadBusinessImage))
                }

                let urlString = data.uploadBusinessImage.file?.url ?? ""
                guard let url = URL(string: urlString) else { return }
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        if self.businessPictures.count >= sort {
                            self.businessPictures.insert(PictureModel.newPicture(image, urlString), at: sort)
                        } else {
                            self.businessPictures.append(PictureModel.newPicture(image, urlString))
                        }
                    }
                }
                
                completion(true)
            case .failure(let error):
                print(error)
                debugPrint(error.localizedDescription)
                completion(false)
            }
        }
    }
    
    func deleteMyAllProfileImages(completion: @escaping (Bool) -> Void) {
        api.perform(mutation: DeleteMyAllProfileImagesMutation()) { result in
            switch result {
            case .success(let value):
                guard value.errors == nil else {
                    print(value.errors as Any)
                    completion(false)
                    return
                }
                
                guard let data = value.data else {
                    print("NO DATA!")
                    completion(false)
                    return
                }
                
                print("Image was successfully deleted!")
                print(data.deleteMyAllProfileImages)
                completion(true)
            case .failure(let error):
                print(error)
                debugPrint(error.localizedDescription)
                completion(false)
            }
        }
    }
    
    func deleteAllBusinessImages(completion: @escaping (Bool) -> Void) {
        guard let id = user?.business?.id else {
            completion(false)
            return
        }
        api.perform(mutation: DeleteAllBusinessImagesMutation(id: id)) { result in
            switch result {
            case .success(let value):
                guard value.errors == nil else {
                    print(value.errors as Any)
                    completion(false)
                    return
                }
                
                guard let data = value.data else {
                    print("NO DATA!")
                    completion(false)
                    return
                }
                
                print("Image was successfully deleted!")
                print(data.deleteAllBusinessImages as Any)
                completion(true)
            case .failure(let error):
                print(error)
                debugPrint(error.localizedDescription)
                completion(false)
            }
        }
    }
   
    func uploadBusinessRegistrationFile(data: Data, completion: @escaping (Bool) -> Void) {
        print("business id: \(String(describing: user?.business?.id))")
        guard let id = user?.business?.id else {
            completion(false)
            return
        }
        let file = GraphQLFile(fieldName: "file", originalName: "file", data: data)
        api.upload(operation: UploadBusinessRegistrationFileMutation(id: id, file: "file"), files: [file]) { result in
            switch result    {
            case .success(let value):
                guard value.errors == nil else {
                    print(value.errors as Any)
                    completion(false)
                    return
                }
                
                guard let data = value.data else {
                    print("NO DATA!")
                    completion(false)
                    return
                }
                
                print("File was successfully uploaded!")
                print(data.uploadBusinessRegistrationFile)
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
                    print(value.errors as Any)
                    completion(false)
                    return
                }
                
                guard let data = value.data else {
                    print("NO DATA!")
                    completion(false)
                    return
                }
                
                print(data.connectInterestsToMyProfile.interests as Any)
                if let interests = data.connectInterestsToMyProfile.interests {
                    self.user?.profile?.interests.removeAll()
                    for interest in interests {
                        if let interest {
                            self.user?.profile?.interests.append(Interest(inter: interest))
                        }
                    }
                }
                
                completion(true)
            case .failure(let error):
                debugPrint(error.localizedDescription)
                completion(false)
            }
        }
    }
    
    func disconnectInterests(ids: [String], completion: @escaping (Bool) -> Void) {
        self.isLoading = true
        api.perform(mutation: DisconnectInterestsFromMyProfileMutation(ids: ids)) { result in
            self.isLoading = false
            switch result {
            case .success(let value):
                guard value.errors == nil else {
                    print(value.errors as Any)
                    completion(false)
                    return
                }
                
                guard let data = value.data else {
                    print("NO DATA!")
                    completion(false)
                    return
                }
                
                print(data.disconnectInterestsFromMyProfile.interests as Any)
                completion(true)
            case .failure(let error):
                debugPrint(error.localizedDescription)
                completion(false)
            }
        }
    }
    
    func reconnectInterests(ids: [String], completion: @escaping (Bool) -> Void) {
        if let interests = user?.profile?.interests {
            self.disconnectInterests(ids: interests.map{ $0.id }) { success in
                self.connectInterests(ids: ids) { success in
                    completion(success)
                }
            }
        } else {
            self.connectInterests(ids: ids) { success in
                completion(success)
            }
        }
    }
    
    func updateProfile(completion: @escaping (Bool) -> Void) {
        let profile = self.user?.profile
            
        
        let input = ProfileData(profile: profile).data
        
        api.perform(mutation: UpsertMyProfileMutation(data: ProfileUpdateInput(input))) { result in
            switch result {
            case .success(let value):
                guard value.errors == nil else {
                    print(value.errors as Any)
                    completion(false)
                    return
                }
                
                guard let data = value.data else {
                    print("NO DATA!")
                    completion(false)
                    return
                }
                
                // Do we even need this variable?
                _ = data.upsertMyProfile
                print(data.upsertMyProfile.id)
                self.user?.profile = profile
                completion(true)
            case .failure(let error):
                debugPrint(error.localizedDescription)
                completion(false)
            }
        }
    }
    
    func getInterests() {
        guard interestCategories.isEmpty else { return }
        api.fetch(query: QueryInterestCategoriesQuery()) { result in
            switch result {
            case .success(let value):
                guard value.errors == nil else {
                    print(value.errors as Any)
                    // MARK: maybe?
//                    self.interestCategories = Constants.interestCategories
                    return
                }
                
                guard let data = value.data else {
                    print("NO DATA!")
                    // MARK: maybe?
//                    self.interestCategories = Constants.interestCategories
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
                    
                    if !self.interestCategories.contains(where: { $0.name == category.name }) {
                        self.interestCategories.append(category)
                    }
                }
            case .failure(let error):
                debugPrint(error.localizedDescription)
                // MARK: maybe?
//                self.interestCategories = Constants.interestCategories
            }
        }
    }
    
    func upsertMyBusiness(business: Business, completion: @escaping (String?) -> Void) {
        self.isLoading = true
        let data = UpdateBusinessData(business: business).data
        let input = BusinessUpdateInput(data)
        
        api.perform(mutation: UpsertMyBusinessMutation(data: input)) { result in
            switch result {
            case .success(let value):
                guard value.errors == nil else {
                    print(value.errors as Any)
                    self.isLoading = false
                    completion(value.errors?.first?.localizedDescription)
                    return
                }
                
                guard let data = value.data else {
                    print("NO DATA!")
                    self.isLoading = false
                    completion("No Data")
                    return
                }
                
                
                self.user?.business = business
                self.user?.business?.id = data.upsertMyBusiness.id
                print("Business was successfully updated!")
                self.isLoading = false
                completion(nil)
            case .failure(let error):
                debugPrint(error.localizedDescription)
                self.isLoading = false
                completion(error.localizedDescription)
            }
        }
    }
    

    func batchUpsertBusinessHours(hours: [BusinessHours], completion: @escaping (Bool) -> Void) {
        guard let id = user?.business?.id else {
            print("id: \(String(describing: user?.business?.id))")
            completion(false)
            return
        }
        
        self.isLoading = true
        
        let input = hours.map({ $0.data })
        api.perform(mutation: BatchUpsertBusinessHoursMutation(businessId: id, data: input)) { result in
            switch result {
            case .success(let value):
                guard value.errors == nil else {
                    print(value.errors as Any)
                    self.isLoading = false
                    completion(false)
                    return
                }
                
                guard value.data != nil else {
                    print("NO DATA!")
                    self.isLoading = false
                    completion(false)
                    return
                }
                
                print("business hours successfully changed!")
                self.user?.business?.businessHours = hours
                self.isLoading = false
                completion(true)
            case .failure(let error):
                debugPrint(error.localizedDescription)
                self.isLoading = false
                completion(false)
            }
        }
    }
    
    func deleteAllBusinessHours(completion: @escaping (Bool) -> Void) {
        guard let id = user?.business?.id else {
            print("id: \(String(describing: user?.business?.id))")
            completion(false)
            return
        }
        
        self.isLoading = true
        
        api.perform(mutation: DeleteAllBusinessHoursMutation(businessId: id)) { result in
            switch result {
            case .success(let value):
                guard value.errors == nil else {
                    print(value.errors as Any)
                    self.isLoading = false
                    completion(false)
                    return
                }
                
                guard value.data != nil else {
                    print("NO DATA!")
                    self.isLoading = false
                    completion(false)
                    return
                }
                
                print("business hours successfully deleted!")
                
                self.isLoading = false
                completion(true)
            case .failure(let error):
                debugPrint(error.localizedDescription)
                self.isLoading = false
                completion(false)
            }
        }
    }
    
    func validateMyPassword(password: String, completion: @escaping (String?) -> Void) {
        self.isLoading = true
        
        api.perform(mutation: ValidateMyPasswordMutation(password: password)) { result in
            switch result {
            case .success(let value):
                guard value.errors == nil else {
                    print(value.errors as Any)
                    self.isLoading = false
                    completion(value.errors?.first?.localizedDescription)
                    return
                }
                
                guard value.data != nil else {
                    print("NO DATA!")
                    self.isLoading = false
                    completion("Oops! Something went wrong")
                    return
                }
                
                print("Password successfully validated!")
                
                self.isLoading = false
                completion(nil)
            case .failure(let error):
                debugPrint(error.localizedDescription)
                self.isLoading = false
                completion(error.localizedDescription)
            }
        }
    }
    
    func makeReport(report: ReportInput, completion: @escaping (String?) -> Void) {
        self.isLoading = true
        
        api.perform(mutation: MakeReportMutation(data: report.data)) { result in
            switch result {
            case .success(let value):
                guard value.errors == nil else {
                    print(value.errors as Any)
                    self.isLoading = false
                    completion(value.errors?.first?.localizedDescription)
                    return
                }
                
                guard value.data != nil else {
                    print("NO DATA!")
                    self.isLoading = false
                    completion("Oops! Something went wrong")
                    return
                }
                
                print("Report successfully was sent!")
                
                self.isLoading = false
                completion(nil)
            case .failure(let error):
                debugPrint(error.localizedDescription)
                self.isLoading = false
                completion(error.localizedDescription)
            }
        }
    }
    
    func generateCheckInToken(completion: @escaping (String?, String?) -> Void) {
        self.isLoading = true
        
        api.perform(mutation: GenerateCheckInTokenMutation()) { result in
            switch result {
            case .success(let value):
                guard value.errors == nil else {
                    print(value.errors as Any)
                    self.isLoading = false
                    completion(value.errors?.first?.localizedDescription, nil)
                    return
                }
                
                guard let data = value.data else {
                    print("NO DATA!")
                    self.isLoading = false
                    completion("Oops! Something went wrong", nil)
                    return
                }
                
                print("CheckIn Token: \(data.generateCheckInToken.token)")
                self.isLoading = false
                completion(nil, data.generateCheckInToken.token)
            case .failure(let error):
                debugPrint(error.localizedDescription)
                self.isLoading = false
                completion(error.localizedDescription, nil)
            }
        }
    }
    
    func createCheckInByToken(token: String, completion: @escaping (String?, AmoringAPI.BusinessInfo?, String?) -> Void) {
        self.isLoading = true
        
        api.perform(mutation: CreateCheckInByTokenMutation(token: token)) { result in
            switch result {
            case .success(let value):
                guard value.errors == nil else {
                    print(value.errors as Any)
                    self.isLoading = false
                    completion(value.errors?.first?.localizedDescription, nil, nil)
                    return
                }
                
                guard let data = value.data else {
                    print("NO DATA!")
                    self.isLoading = false
                    completion("Oops! Something went wrong", nil, nil)
                    return
                }
                
                print("Check in successfully created by token!")
                print(data.createCheckInByToken?.id as Any)
                
                self.isLoading = false
                // TODO: Need tests
                self.newCheckinSubscription { success in
                    self.getVisibleProfiles()
                }
                completion(nil, data.createCheckInByToken?.business?.fragments.businessInfo, data.createCheckInByToken?.id)
                
            case .failure(let error):
                debugPrint(error.localizedDescription)
                self.isLoading = false
                completion(error.localizedDescription, nil, nil)
            }
        }
    }
    
    func updateCheckInStatus(id: String, hasTable: Bool, completion: @escaping (String?, CheckInInfo?) -> Void) {
        self.isLoading = true
        
        api.perform(mutation: UpdateCheckInStatusMutation(id: id, hasTable: hasTable)) { result in
            switch result {
            case .success(let value):
                guard value.errors == nil else {
                    print(value.errors as Any)
                    self.isLoading = false
                    completion(value.errors?.first?.localizedDescription, nil)
                    return
                }
                
                guard let data = value.data else {
                    print("NO DATA!")
                    self.isLoading = false
                    completion("Oops! Something went wrong", nil)
                    return
                }
                
                print("Status successfully updated!")
                
                self.isLoading = false
                
                let checkIn = data.updateCheckInStatus?.fragments.checkInInfo
                completion(nil, checkIn)
            case .failure(let error):
                debugPrint(error.localizedDescription)
                self.isLoading = false
                completion(error.localizedDescription, nil)
            }
        }
    }
    
    func activeCheckIn(completion: @escaping (CheckInInfo?) -> Void) {
        api.fetch(query: ActiveCheckInQuery()) { result in
            switch result {
            case .success(let value):
                guard value.errors == nil else {
                    print(value.errors as Any)
                    completion(nil)
                    return
                }
                
                guard let data = value.data else {
                    print("NO DATA!")
                    completion(nil)
                    return
                }
                print(data.activeCheckIn as Any)
                if data.activeCheckIn != nil {
                    let checkIn = data.activeCheckIn?.fragments.checkInInfo
                    print("Active check in: \(String(describing: checkIn))")
                    
                    completion(checkIn)
                } else {
                    completion(nil)
                }
            case .failure(let error):
                debugPrint(error.localizedDescription)
                completion(nil)
            }
        }
    }
    
    func checkOutFromActive(completion: @escaping (String?) -> Void) {
        self.isLoading = true
        
        api.perform(mutation: CheckOutFromActiveMutation()) { result in
            switch result {
            case .success(let value):
                guard value.errors == nil else {
                    print(value.errors as Any)
                    self.isLoading = false
                    completion(value.errors?.first?.localizedDescription)
                    return
                }
                
                guard value.data != nil else {
                    print("NO DATA!")
                    self.isLoading = false
                    completion("Oops! Something went wrong")
                    return
                }
                
                print("Successfully checked out from active!")
                self.newCheckinSubscription?.cancel()
                self.isLoading = false
                
                completion(nil)
            case .failure(let error):
                debugPrint(error.localizedDescription)
                self.isLoading = false
                completion(error.localizedDescription)
            }
        }
    }
        
    func reactToProfile(id: String, type: ReactType, completion: @escaping (String?, Bool) -> Void) {
        self.isLoading = true
        
        api.perform(mutation: ReactToProfileMutation(profileId: id, type: .case(type == .like ? .like : .dislike))) { result in
            switch result {
            case .success(let value):
                guard value.errors == nil else {
                    print(value.errors as Any)
                    self.isLoading = false
                    completion(value.errors?.first?.localizedDescription, false)
                    return
                }
                
                guard let data = value.data else {
                    print("NO DATA!")
                    self.isLoading = false
                    completion("Oops! Something went wrong", false)
                    return
                }
                
                print("Successfully reacted to Profile!")
                
                self.isLoading = false
                
                completion(nil, data.reactToProfile?.isMatched ?? false)
            case .failure(let error):
                debugPrint(error.localizedDescription)
                self.isLoading = false
                completion(error.localizedDescription, false)
            }
        }
    }
    
    func getConversations(completion: @escaping ([ConversationInfo]?) -> Void) {
        guard let id = self.user?.id else {
            completion(nil)
            return
        }
        api.fetch(query: ConversationsQuery(), cachePolicy: .fetchIgnoringCacheCompletely) { result in
            switch result {
            case .success(let value):
                guard value.errors == nil else {
                    print(value.errors as Any)
                    print("errors")
                    completion(nil)
                    return
                }
                
                guard let data = value.data else {
                    print("NO DATA!")
                    completion(nil)
                    return
                }
                
                print("successfully fetched conversation list")
                print("numbers of conversations: \(data.conversations)")
                completion(data.conversations.compactMap({ $0.fragments.conversationInfo }))
            case .failure(let error):
                print("faliure")
                debugPrint(error.localizedDescription)
                completion(nil)
            }
        }
    }
    
    func getConversation(id: String, completion: @escaping (ConversationInfo?) -> Void) {
        api.fetch(query: ConversationQuery(id: id)) { result in
            switch result {
            case .success(let value):
                guard value.errors == nil else {
                    print(value.errors as Any)
                    completion(nil)
                    return
                }
                
                guard let data = value.data else {
                    print("NO DATA!")
                    completion(nil)
                    return
                }
                print(data.conversation?.fragments.conversationInfo)
                
                completion(data.conversation?.fragments.conversationInfo)
            case .failure(let error):
                debugPrint(error.localizedDescription)
                completion(nil)
            }
        }
    }
    
    func getReactions(completion: @escaping (String?, [ReactionInfo]) -> Void) {
        api.fetch(query: ReactionsQuery(), cachePolicy: .returnCacheDataAndFetch) { result in
            switch result {
            case .success(let value):
                guard value.errors == nil else {
                    print(value.errors as Any)
                    completion(value.errors?.first?.errorDescription, [])
                    return
                }
                
                guard let data = value.data else {
                    print("NO DATA!")
                    completion(value.errors?.first?.errorDescription, [])
                    return
                }
                
                print("successfully got list of reactions. Number: \(data.reactions.count)")
                if !data.reactions.isEmpty {
                    completion(nil, data.reactions.map({ $0!.fragments.reactionInfo }))
                }
                
            case .failure(let error):
                debugPrint(error.localizedDescription)
                completion(error.localizedDescription, [])
            }
        }
    }
    
    func sendMessage(body: String, id: String, completion: @escaping (String?, MessageInfo?) -> Void) {
        self.isLoading = true
        
        api.perform(mutation: SendMessageMutation(body: body, conversationId: id)) { result in
            switch result {
            case .success(let value):
                guard value.errors == nil else {
                    print(value.errors as Any)
                    self.isLoading = false
                    completion(value.errors?.first?.localizedDescription, nil)
                    return
                }
                
                guard let data = value.data else {
                    print("NO DATA!")
                    self.isLoading = false
                    completion("Oops! Something went wrong", nil)
                    return
                }
                
                print("Message successfully was sent!")
                
                self.isLoading = false
                
                completion(nil, data.sendMessage.fragments.messageInfo)
            case .failure(let error):
                debugPrint(error.localizedDescription)
                self.isLoading = false
                completion(error.localizedDescription, nil)
            }
        }
    }
    
    func deleteConversation(id: String, completion: @escaping (String?) -> Void) {
        self.isLoading = true
        
        api.perform(mutation: DeleteConversationMutation(id: id)) { result in
            switch result {
            case .success(let value):
                guard value.errors == nil else {
                    print(value.errors as Any)
                    self.isLoading = false
                    completion(value.errors?.first?.localizedDescription)
                    return
                }
                
                guard let data = value.data else {
                    print("NO DATA!")
                    self.isLoading = false
                    completion("Oops! Something went wrong")
                    return
                }
                
                print("Conversation successfully was deleted!")
                
                self.isLoading = false
                
                completion(nil)
            case .failure(let error):
                debugPrint(error.localizedDescription)
                self.isLoading = false
                completion(error.localizedDescription)
            }
        }
    }
    
    func reportConversation(id: String, completion: @escaping (String?) -> Void) {
        self.isLoading = true
        
        api.perform(mutation: ReportConversationMutation(id: id)) { result in
            switch result {
            case .success(let value):
                guard value.errors == nil else {
                    print(value.errors as Any)
                    self.isLoading = false
                    completion(value.errors?.first?.localizedDescription)
                    return
                }
                
                guard let data = value.data else {
                    print("NO DATA!")
                    self.isLoading = false
                    completion("Oops! Something went wrong")
                    return
                }
                
                print("Conversation successfully was reported!")
                
                self.isLoading = false
                
                completion(nil)
            case .failure(let error):
                debugPrint(error.localizedDescription)
                self.isLoading = false
                completion(error.localizedDescription)
            }
        }
    }
    
    func reportUser(userId: String, completion: @escaping (String?) -> Void) {
        self.isLoading = true
        
        api.perform(mutation: ReportUserMutation(userId: userId)) { result in
            switch result {
            case .success(let value):
                guard value.errors == nil else {
                    print(value.errors as Any)
                    self.isLoading = false
                    completion(value.errors?.first?.localizedDescription)
                    return
                }
                
                guard let data = value.data else {
                    print("NO DATA!")
                    self.isLoading = false
                    completion("Oops! Something went wrong")
                    return
                }
                
                print("User successfully was reported!")
                
                self.isLoading = false
                
                completion(nil)
            case .failure(let error):
                debugPrint(error.localizedDescription)
                self.isLoading = false
                completion(error.localizedDescription)
            }
        }
    }
    
    func blockUser(id: String, completion: @escaping (String?) -> Void) {
        self.isLoading = true
        
        api.perform(mutation: BlockUserMutation(id: id)) { result in
            switch result {
            case .success(let value):
                guard value.errors == nil else {
                    print(value.errors as Any)
                    self.isLoading = false
                    completion(value.errors?.first?.localizedDescription)
                    return
                }
                
                guard let data = value.data else {
                    print("NO DATA!")
                    self.isLoading = false
                    completion("Oops! Something went wrong")
                    return
                }
                
                print("User successfully was blocked!")
                
                self.isLoading = false
                
                completion(nil)
            case .failure(let error):
                debugPrint(error.localizedDescription)
                self.isLoading = false
                completion(error.localizedDescription)
            }
        }
    }
    
    func changeStateWithAnimation(state: UserState) {
        DispatchQueue.main.async {
            withAnimation {
                self.userState = state
            }
        }
    }
    
    var messageSubscription: Cancellable?
    var reactionSubscription: Cancellable?
    var conversationSubscription: Cancellable?
    var newCheckinSubscription: Cancellable?
    var connectedUserOnlineStatusChanged: Cancellable?
    @Published var newMessage: MessageInfo? = nil
    @Published var statusChanged: NewStatusReader? = nil
    
    deinit {
        self.messageSubscription?.cancel()
    }
    
    func connectedUserOnlineStatusChanged(completion: @escaping (ProfileInfo?) -> Void) {
        self.connectedUserOnlineStatusChanged = WSApi.subscribe(subscription: ConnectedUserOnlineStatusChangedSubscription()) { result in
//            print("online status changed")
//            print(result)
            guard let data = try? result.get().data else { return }
            if let profile = data.connectedUserOnlineStatusChanged?.fragments.userInfo.profile?.fragments.profileInfo {
                print("user \(profile.id) is \(profile.isOnline ? "online" : "offline")")
                self.statusChanged = NewStatusReader(id: profile.id, isOnline: profile.isOnline)
                completion(profile)
            } else {
                print("online status changed with errors")
                completion(nil)
            }
        }
    }
    
    func newCheckinSubscription(completion: @escaping (Bool) -> Void) {
        self.newCheckinSubscription = WSApi.subscribe(subscription: NewCheckinSubscription()) { result in
            print("New checkin listening")
            print(result)
            guard let data = try? result.get().data else { return }
            if let id = data.checkIn?.fragments.checkInInfo.profileId {
                print("New checkin id: \(id)")
                completion(true)
            } else {
                print("New checkin with errors")
                completion(false)
            }
        }
    }
    
    func messageSubscription(completion: @escaping (MessageInfo?) -> Void) {
        self.messageSubscription = WSApi.subscribe(subscription: MessageSentSubscription()) { result in
            guard let data = try? result.get().data else { return }
            if let message = data.messageSent?.fragments.messageInfo {
                print("New message: \(message.body)")
                self.newMessage = message
                completion(message)
            } else {
                completion(nil)
            }
        }
    }
        
    func reactionSubscription(completion: @escaping (ReactionInfo?) -> Void) {
        self.reactionSubscription = WSApi.subscribe(subscription: ReactionAddedSubscription()) { result in
            guard let data = try? result.get().data else { return }
            if let reaction = data.reactionAdded?.fragments.reactionInfo {
                print("received reaction by: \(reaction.byProfileId)")
                print("reaction: \(reaction)")
                completion(reaction)
            } else {
                print("reaction: ERROR!!")
                completion(nil)
            }
        }
    }
    
    func conversationSubscription(completion: @escaping (String?, String?) -> Void) {
        self.conversationSubscription = WSApi.subscribe(subscription: ConversationDeletedSubscription()) { result in
            guard let data = try? result.get().data else { return }
            if let id = data.conversationDeleted?.id, let deletedBy = data.conversationDeleted?.deletedBy?.profile?.fragments.profileInfo.name {
                print("received conversation deleted: \(id)")
                completion(id, deletedBy)
            } else {
                completion(nil, nil)
            }
        }
    }
    
    // TODO: move to another Manager
//    func getBusinesses() {
//        api.fetch(query: QueryAllBusinessesQuery()) { result in
//            switch result {
//            case .success(let value):
//                guard value.errors == nil else {
//                    print(value.errors as Any)
//                    return
//                }
//                
//                guard let data = value.data else {
//                    print("NO DATA!")
//                    return
//                }
//                
//                let businesss = data.businesses
//                self.businesses = []
//                self.businessesInit = []
//                
//                for bus in businesss {
//                    self.businesses.append(bus.fragments.businessInfo)
//                }
//                self.businessesInit = self.businesses
//                print(self.businesses.map({ $0.id }))
//            case .failure(let error):
//                debugPrint(error.localizedDescription)
//            }
//        }
//    }
    
    func getBusinesses(
        lat: Double? = nil,
        lng: Double? = nil,
        districts: [String]? = nil,
        sort: BusinessSortField? = nil,
        typeId: String? = nil,
        nearByOnly: Bool? = nil,
        take: Int? = nil,
        skip: Int? = nil,
        completion: @escaping () -> Void) {
            var input: NearLocationInput? = nil
            var districtsList: [String]? = nil
            var businessSortBy: BusinessSortBy? = nil
            var typeIdList: [String] = []
            if let lat {
                input = NearLocationInput(InputDict(["lat": lat, "lng": lng]))
            }
            if let districts {
                districtsList = districts
            }
            if let sort {
                businessSortBy = BusinessSortBy(field: .case(sort), order: .case(.asc))
            }
            if let typeId {
                typeIdList = [typeId]
            }
            let query = QueryBusinessesQuery(
                near: GraphQLHelper.graphQLNullableFrom(input),
                districts: GraphQLHelper.graphQLNullableFrom(districtsList),
                sort: GraphQLHelper.graphQLNullableFrom(businessSortBy),
                typeId: GraphQLHelper.graphQLNullableFrom(typeIdList),
                nearByOnly: nearByOnly ?? false,
                take: GraphQLHelper.graphQLNullableFrom(take),
                skip: GraphQLHelper.graphQLNullableFrom(skip)
            )
            api.fetch(query: query) { result in
                switch result {
                case .success(let value):
                    guard value.errors == nil else {
                        print(value.errors as Any)
                        completion()
                        return
                    }
                    
                    guard let data = value.data else {
                        print("NO DATA!")
                        completion()
                        return
                    }
                    
                    
                    self.businesses = []
                    print(data.businesses.items.map({ $0.businessName }))
                    for bus in data.businesses.items {
                        self.businesses.append(bus.fragments.businessInfo)
                    }
                    self.total = data.businesses.total
                    if sort == .businessName {
                        self.businesses.sort { $0.businessName ?? "" < $1.businessName ?? "" }
                    }
                    print("total: \(self.total)")
                    completion()
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                    completion()
                }
            }
        }
    
    @Published var districts: [District] = []
    func getBusinessDistricts() {
        api.fetch(query: BusinessDistrictsQuery()) { result in
            switch result {
            case .success(let value):
                guard value.errors == nil else {
                    print(value.errors as Any)
                    return
                }
                
                guard let data = value.data else {
                    print("NO DATA!")
                    return
                }
                
                if let dists = data.businessDistricts?.map({ $0.fragments.districtFragment }) {
                    self.districts = dists.map({ District(districtFragment: $0) })
                }
                
                print(self.businesses.map({ $0.id }))
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    @Published var businessTypes: [BusinessTypeModel] = [BusinessTypeModel(id: "ALL", name: "전체")]
    func getBusinessTypes() {
        api.fetch(query: BusinessTypesQuery()) { result in
            switch result {
            case .success(let value):
                guard value.errors == nil else {
                    print(value.errors as Any)
                    return
                }
                
                guard let data = value.data else {
                    print("NO DATA!")
                    return
                }
                
                if let types = data.businessTypes {
                    self.businessTypes = types.map({ BusinessTypeModel(id: $0.id, name: $0.name) })
                    self.businessTypes.insert(BusinessTypeModel(id: "ALL", name: "전체"), at: 0)
                }
                print("Business types count: \(self.businessTypes.count)")
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    // MARK: fetching all profiles [use for tests]
//    func getProfiles() {
//        api.fetch(query: ProfilesQuery()) { result in
//            switch result {
//            case .success(let value):
//                guard value.errors == nil else {
//                    print(value.errors as Any)
//                    return
//                }
//                
//                guard let data = value.data else {
//                    print("NO DATA!")
//                    return
//                }
//                
//                let profiles = data.profiles
//                self.profiles = []
//                
////                self.profiles.append(contentsOf: Dummy.profiles)
//                
//                for profile in profiles {
//                    if let profile {
//                        //MARK:  excepting default db profile, excepting myself
//                        if profile.id != "3" && profile.id != self.user?.profile?.id {
//                            self.profiles.append(profile.fragments.profileInfo)
//                        }
//                    }
//                }
//                
//            case .failure(let error):
//                debugPrint(error.localizedDescription)
//            }
//        }
//    }
    
    func getVisibleProfiles() {
        api.fetch(query: VisibleProfilesQuery(includeNearby: GraphQLHelper.graphQLNullableFrom(self.includeNearby)), cachePolicy: .fetchIgnoringCacheCompletely) { result in
            switch result {
            case .success(let value):
                print("includeNearby: \(self.includeNearby)")
                guard value.errors == nil else {
                    print("errors")
                    print(value.errors as Any)
                    return
                }
                
                guard let data = value.data else {
                    print("NO DATA!")
                    return
                }
                let profiles = data.visibleProfiles.reversed()

                
                self.profiles = []
//                print("visible profiles: ")
//                print(profiles.map({ $0?.id }))
//                print(profiles.map({ $0?.createdAt }))
                for profile in profiles {
                    if let profile {
                        self.profiles.append(profile.fragments.profileInfo)
                    }
                }
                print(self.profiles.map({ $0.id }))
            case .failure(let error):
                print("faliure")
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    func useCoupon(id: String, completion: @escaping (String?) -> Void) {
        self.isLoading = true
        
        api.perform(mutation: UseActiveCouponMutation(id: id)) { result in
            switch result {
            case .success(let value):
                guard value.errors == nil else {
                    print(value.errors as Any)
                    self.isLoading = false
                    completion(value.errors?.first?.localizedDescription)
                    return
                }
                
                guard let data = value.data else {
                    print("NO DATA!")
                    self.isLoading = false
                    completion("Oops! Something went wrong")
                    return
                }
                
                print("Coupon was successfully used! id: \(id)")
                
                self.isLoading = false
                completion(nil)
            case .failure(let error):
                debugPrint(error.localizedDescription)
                self.isLoading = false
                completion(error.localizedDescription)
            }
        }
    }
    
    // MARK: Purcahse Controller
    @Published var purchaseType: PurchaseModel.type? = nil
    @Published var products: [Product] = []
    @Published var purchasedIDs: [String] = []
    @Published var selectedPlan: PurchaseProduct = .ios_5_likes
    
    func openPurchase(purchaseType: PurchaseModel.type) {
        switch purchaseType {
        case .like:
            if !self.products.contains(where: { $0.displayName.contains("like") }) {
                return
            }
            self.selectedPlan = .ios_10_likes
        case .lounge:
            return
//            if !self.products.contains(where: { $0.id == PurchaseProduct.lounge_extension_pass.rawValue }) {
////                self.sele
//                return
//            }
//            self.selectedPlan = .lounge_extension_pass
        case .transparent:
            if !self.products.contains(where: { $0.id == PurchaseProduct.ios_hidden_mode_pass.rawValue }) {
                return
            }
            self.selectedPlan = .ios_hidden_mode_pass
        case .list:
            if !self.products.contains(where: { $0.id == PurchaseProduct.ios_list_view_pass.rawValue }) {
                return
            }
            self.selectedPlan = .ios_list_view_pass
        }
        withAnimation {
            self.purchaseType = purchaseType
        }
    }
    
    
    
//    static let products = ["amoring_likes_5", "amoring_likes_10", "amoring_likes_50", "hidden_mode_pass", "lounge_extension_pass", "list_view_pass"]
    
    func fetchProducts() {
        Task.init(priority: .background) {
            do {
                let products = try await Product.products(for: PurchaseProduct.allCases.map({ $0.rawValue }))
                DispatchQueue.main.async {
                    print("get products: \(products.map({ $0.id }))")
                    self.products = products
                }
                // MARK: use it for non-consumable products ?
//                if let product = products.first {
//                    await isPurchased(product: product)
//                }
            } catch {
                print("There's an error fetching products. \(error.localizedDescription)")
            }
        }
    }
    
//    func isPurchased(product: Product) async {
//        guard let state = await product.currentEntitlement else { return }
//
//        switch state {
//        case .verified(let transaction):
//            print("isPurchased")
//            DispatchQueue.main.async {
//                self.purchasedIDs.append(transaction.productID)
//            }
//        case .unverified(_, _):
//            print("is not purchased")
//            break
//        }
//    }
    
    func purchase(completion: @escaping (String?) -> Void) {
        self.isLoading = true
        Task.init(priority: .high) {
            guard let product = products.first(where: { $0.id == self.selectedPlan.rawValue }) else {
                completion("no products")
                self.isLoading = false
                return
            }
            print(product.description)
            print(product.id)
            do {
                let result = try await product.purchase()
                
                switch result {
                    
                case .success(let verification):
                    print("verification: \(verification)")
                    switch verification {
                    case .verified(let transaction):
                        print("transaction: \(transaction)")
                        
                        DispatchQueue.main.async {
                            self.purchasedIDs.append(transaction.productID)
                            self.createPurchase(transactionId: String(transaction.id)) { error, user in
                                self.onPurchaseSuccess(user: user)
                                
                                Task {
                                    await transaction.finish()
                                }
                                self.isLoading = false
                                completion(error)
                            }
                        }
                    case .unverified(_, let error):
                        print("unverified error: \(error)")
                        self.isLoading = false
                        completion(error.localizedDescription)
                        break
                    }
                case .userCancelled:
                    print("canceled")
                    self.isLoading = false
                    completion("canceled")
                    break
                case .pending:
                    print("pending...")
                    self.isLoading = false
                    completion("pending...")
                    break
                @unknown default:
                    self.isLoading = false
                    completion("unknown error")
                    break
                }
            } catch {
                print("There's an error purchasing products. \(error.localizedDescription)")
                self.isLoading = false
                completion(error.localizedDescription)
            }
        }
    }
    
    func onPurchaseSuccess(user: UserInfo?) {
        DispatchQueue.main.async {
            withAnimation {
                print("purchase...")
                
                if let likesCredit = user?.likesCredit {
                    self.user?.likesCredit = likesCredit
                }
                if let loungePassExpiredAt = user?.loungePassExpiredAt {
                    self.user?.loungePassExpiredAt = loungePassExpiredAt.toDate(format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
                }
                if let invisiblePassExpiredAt = user?.invisiblePassExpiredAt {
                    self.user?.invisiblePassExpiredAt = invisiblePassExpiredAt.toDate(format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
                }
                if let visibleReactionsPassExpiredAt = user?.visibleReactionsPassExpiredAt {
                    self.user?.visibleReactionsPassExpiredAt = visibleReactionsPassExpiredAt.toDate(format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
                }
                
                self.purchaseType = nil
            }
        }
    }
    
    func createPurchase(transactionId: String, completion: @escaping (String?, UserInfo?) -> Void) {
        self.isLoading = true
        
        api.perform(mutation: CreatePurchaseMutation(transactionId: transactionId)) { result in
            switch result {
            case .success(let value):
                guard value.errors == nil else {
                    print(value.errors as Any)
                    self.isLoading = false
                    completion(value.errors?.first?.localizedDescription, nil)
                    return
                }
                
                guard let data = value.data else {
                    print("NO DATA!")
                    self.isLoading = false
                    completion("Oops! Something went wrong", nil)
                    return
                }
                print(data.createPurchase?.id)
                print("Purchase successfully was created!")
                
                self.isLoading = false
                let userInfo = data.createPurchase?.user?.fragments.userInfo
                completion(nil, userInfo)
            case .failure(let error):
                debugPrint(error.localizedDescription)
                self.isLoading = false
                completion(error.localizedDescription, nil)
            }
        }
    }
    
    func disableLikes() -> Bool {
        return user?.likesCredit ?? 0 <= 0 && user?.usedLikesCount ?? 0 >= user?.maxLikes ?? 10
    }
    
    func loungePassEnabled() -> Bool {
        return self.user?.loungePassExpiredAt ?? Date() > Date()
    }
    
    func invisiblePassEnabled() -> Bool {
        return self.user?.invisiblePassExpiredAt ?? Date() > Date()
    }
    
    func visibleReactionsPassEnabled() -> Bool {
        return self.user?.visibleReactionsPassExpiredAt ?? Date() > Date()
    }
}

enum ReactType {
    case like, dislike
}
