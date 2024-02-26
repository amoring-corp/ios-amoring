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
    @Published var profiles: [Profile] = []
    
    @Published var pictures: [PictureModel] = []
    @Published var businessPictures: [PictureModel] = []
    
    @Published var confirmRemoveImageIndex: Int = 0
    
    
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
            
            if let business = authUser.business, ((business.phoneNumber?.isEmpty) != nil) {
                print("going to Business Session")
                print(business)
                //TODO:  pass whole business user here!
                self.setBusinessPhotos()
                self.changeStateWithAnimation(state: .businessSession)
            } else {
//                print("Business not onboarded yet")
                self.changeStateWithAnimation(state: .businessOnboarding)
            }
        case .user:
            print("I'm a user")
            if let profile = authUser.profile {
                self.setCurrentPhotos()
                self.changeStateWithAnimation(state: .session)
            } else {
                print("User not onboarded yet")
                self.changeStateWithAnimation(state: .userOnboarding)
            }
        case .admin:
            print("I'm an admin")
            self.changeStateWithAnimation(state: .debugging)
        }
    }
    
    private func setCurrentPhotos() {
        print(self.pictures.count)
        guard let images = self.user?.profile?.images else { return }
      
        if self.pictures.map({ $0.url }).sorted() == images.map({ $0.file?.url ?? "" }).sorted() {
            
        }
        
        for image in images {
            let urlString = image.file?.url ?? ""
            guard let url = URL(string: urlString) else { return }
            print(urlString)
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
            print(urlString)
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    self.businessPictures.append(PictureModel.newPicture(image, urlString))
                }
            }
        }
    }
    
    func removePicture() {
        self.pictures.remove(at: confirmRemoveImageIndex)
    }
    
    func removeBusinessPicture() {
        self.businessPictures.remove(at: confirmRemoveImageIndex)
    }
    
    func refreshUser() {
        self.isLoading = true
        api.fetch(query: QueryAuthenticatedUserQuery()) { result in
            self.isLoading = false
                switch result {
                case .success(let value):
                    guard value.errors == nil else {
                        print(value.errors)
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
                    
                    self.user = User.fromData(authUser)
                    
                    print(self.user?.profile?.images)
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
                
                self.user?.profile = profile
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
        var successList: [Bool] = []
        for (index,image) in images.enumerated(){
            let resizedImage = ImageHelper().resizeImage(image: image, targetSize: CGSize(width: 1024, height: 1024))
            if let data = resizedImage!.jpegData(compressionQuality: 0.8) {
                dispatchGroup.enter()

                // TODO: test with image\(index).jpeg
                let file = GraphQLFile(fieldName: "image", originalName: "image\(index)", mimeType: "image/jpeg", data: data)
                self.saveImage(file: file, sort: index) { success in
                    successList.append(success)
                    dispatchGroup.leave()
                }
            } else {
                print("wrong image data!")
                completion(true)
            }
        }
        dispatchGroup.notify(queue: DispatchQueue.main, execute: {
            self.isLoading = false
            print("sending: \(successList.filter{$0}.count) images finished")
            completion(successList.filter{$0}.count >= 3)
        })
    }
    
    
    private func saveImage(file: GraphQLFile, sort: Int, completion: @escaping (Bool) -> Void) {
        api.upload(operation: UploadMyProfileImageMutation(image: "image", sort: sort), files: [file]) { result in
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
                print(data.uploadMyProfileImage)
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
        var successList: [Bool] = []
        for (index,image) in images.enumerated(){
            let resizedImage = ImageHelper().resizeImage(image: image, targetSize: CGSize(width: 1024, height: 1024))
            
            if let data = resizedImage!.jpegData(compressionQuality: 0.8) {
                dispatchGroup.enter()
                
                let file = GraphQLFile(fieldName: "image", originalName: "image", mimeType: "image/jpeg", data: data)
                self.saveBusinessImage(file: file, sort: index) { success in
                    successList.append(success)
                    dispatchGroup.leave()
                }
            } else {
                print("wrong image data!")
                completion(true)
            }
        }
        dispatchGroup.notify(queue: DispatchQueue.main, execute: {
            self.isLoading = false
            print("sending: \(successList.filter{$0}.count) images finished")
            completion(successList.filter{$0}.count >= 3)
        })
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
    
    func deleteMyAllProfileImages(completion: @escaping (Bool) -> Void) {
        api.perform(mutation: DeleteMyAllProfileImagesMutation()) { result in
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
                    print(value.errors)
                    completion(false)
                    return
                }
                
                guard let data = value.data else {
                    print("NO DATA!")
                    completion(false)
                    return
                }
                
                print("Image was successfully deleted!")
                print(data.deleteAllBusinessImages)
                completion(true)
            case .failure(let error):
                print(error)
                debugPrint(error.localizedDescription)
                completion(false)
            }
        }
    }
   
    func uploadBusinessRegistrationFile(data: Data, completion: @escaping (Bool) -> Void) {
        print("business id: \(user?.business?.id)")
        guard let id = user?.business?.id else {
            completion(false)
            return
        }
        let file = GraphQLFile(fieldName: "file", originalName: "file", data: data)
        api.upload(operation: UploadBusinessRegistrationFileMutation(id: id, file: "file"), files: [file]) { result in
            switch result    {
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
                if let interests = data.connectInterestsToMyProfile.interests {
                    self.user?.profile?.interests.removeAll()
                    for interest in interests {
                        if let interest {
                            self.user?.profile?.interests.append(Interest.fromData(data: interest))
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
                    print(value.errors)
                    completion(false)
                    return
                }
                
                guard let data = value.data else {
                    print("NO DATA!")
                    completion(false)
                    return
                }
                
                print(data.disconnectInterestsFromMyProfile.interests)
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
    
    func updateProfile(profile: Profile, completion: @escaping (Bool) -> Void) {
        let input = ProfileData(profile: profile).data
        
        api.perform(mutation: UpsertMyProfileMutation(data: ProfileUpdateInput(input))) { result in
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
                let fetchedProfile = data.upsertMyProfile
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
                    print(value.errors)
                    self.interestCategories = Constants.interestCategories
                    return
                }
                
                guard let data = value.data else {
                    print("NO DATA!")
                    self.interestCategories = Constants.interestCategories
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
                self.interestCategories = Constants.interestCategories
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
                    print(value.errors)
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
            print("id: \(user?.business?.id)")
            completion(false)
            return
        }
        
        self.isLoading = true
        
        let input = hours.map({ $0.data })
        api.perform(mutation: BatchUpsertBusinessHoursMutation(businessId: id, data: input)) { result in
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
            print("id: \(user?.business?.id)")
            completion(false)
            return
        }
        
        self.isLoading = true
        
        api.perform(mutation: DeleteAllBusinessHoursMutation(businessId: id)) { result in
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
                    print(value.errors)
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
                    print(value.errors)
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
                    print(value.errors)
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
                
                print("Token successfully was generated!")
                    //TODO: set timer for expiration period to update token
                print(data.generateCheckInToken.expiresAt)
                print(data.generateCheckInToken.token)
                self.isLoading = false
                completion(nil, data.generateCheckInToken.token)
            case .failure(let error):
                debugPrint(error.localizedDescription)
                self.isLoading = false
                completion(error.localizedDescription, nil)
            }
        }
    }
    
    func createCheckInByToken(token: String, completion: @escaping (String?, String?, String?) -> Void) {
        self.isLoading = true
        
        api.perform(mutation: CreateCheckInByTokenMutation(token: token)) { result in
            switch result {
            case .success(let value):
                guard value.errors == nil else {
                    print(value.errors)
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
                    
                
                print(data.createCheckInByToken?.id)
                
                self.isLoading = false
                completion(nil, data.createCheckInByToken?.business?.businessName, data.createCheckInByToken?.id)
            case .failure(let error):
                debugPrint(error.localizedDescription)
                self.isLoading = false
                completion(error.localizedDescription, nil, nil)
            }
        }
    }
    
    func updateCheckInStatus(id: String, completion: @escaping (String?, CheckIn?) -> Void) {
        self.isLoading = true
        
        api.perform(mutation: UpdateCheckInStatusMutation(id: id)) { result in
            switch result {
            case .success(let value):
                guard value.errors == nil else {
                    print(value.errors)
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
                
                print("Check in successfully created by token!")
                
                self.isLoading = false
                
                let checkIn = CheckIn.fromData(data: data.updateCheckInStatus)
                completion(nil, checkIn)
            case .failure(let error):
                debugPrint(error.localizedDescription)
                self.isLoading = false
                completion(error.localizedDescription, nil)
            }
        }
    }
    
    func activeCheckIn(completion: @escaping (CheckIn?) -> Void) {
        print("here")
        api.fetch(query: ActiveCheckInQuery()) { result in
            print("here2")
            switch result {
            case .success(let value):
                guard value.errors == nil else {
                    print(value.errors)
                    completion(nil)
                    return
                }
                
                guard let data = value.data else {
                    print("NO DATA!")
                    completion(nil)
                    return
                }
                print("here3")
                print(data.activeCheckIn)
                if let activeCheckIn = data.activeCheckIn {
                    let checkIn = CheckIn.fromData(data: data.activeCheckIn)
                    print("Active check in: \(checkIn)")
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
                    return
                }
                
                guard let data = value.data else {
                    print("NO DATA!")
                    return
                }
                
                let businesss = data.businesses
                self.businesses = []
                self.businessesInit = []
                
                for bus in businesss {
                    if let busForSave = Business.fromData(data: bus) {
                        self.businesses.append(busForSave)
                        self.businessesInit.append(busForSave)
                    }
                }
                
//                self.businesses.append(contentsOf: Dummy.businesses)
//                self.businessesInit.append(contentsOf: Dummy.businesses)
                print(self.businesses)
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    // TODO: move to another Manager
    func getProfiles() {
        api.fetch(query: ProfilesQuery()) { result in
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
                
                let profiles = data.profiles
                self.profiles = []
                
                self.profiles.append(contentsOf: Dummy.profiles)
                
                for profile in profiles {
                    if let profile = Profile.fromData(data: profile) {
                        //MARK:  excepting default db profile, excepting myself
                        if profile.id != "3" && profile.id != self.user?.profile?.id {
                            self.profiles.append(profile)
                        }
                    }
                }
                
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        }
    }
}
