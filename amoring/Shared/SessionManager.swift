//
//  SessionManager.swift
//  amoring
//
//  Created by 이준녕 on 11/20/23.
//

import SwiftUI
import AuthenticationServices
import GoogleSignInSwift
import GoogleSignIn
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser
import Apollo
import AmoringAPI
import NaverThirdPartyLogin
import ApolloWebSocket
import AWSSNS

class WebSocketApiManager {
    static let shared = WebSocketApiManager()
    
    private(set) var apollo: ApolloClient?
    private var webSocketTransport: WebSocketTransport?

    func initWSApi(token: String) {
        let url = URL(string: "wss://api.amoring.info/graphql")!
        let webSocketClient = WebSocket(url: url, protocol: .graphql_transport_ws)
        let langStr = UserDefaults.standard.string(forKey: "language") ?? Locale.current.languageCode
        let authPayload: JSONEncodableDictionary = [
            "Authorization": "Bearer \(token)",
            "Accept-Language": langStr ?? "ko"
        ]
        let config = WebSocketTransport.Configuration(connectingPayload: authPayload)
        
        let transport = WebSocketTransport(websocket: webSocketClient, config: config)
        self.webSocketTransport = transport
        
        let store = ApolloStore(cache: InMemoryNormalizedCache())
        self.apollo = ApolloClient(networkTransport: transport, store: store)
    }
    
    func cancel() {
        webSocketTransport?.closeConnection()
        webSocketTransport = nil
        apollo = nil
    }
}


func initApi(token: String) -> ApolloClient {
    return {
        let url = URL(string: "\(Constants.domain)/graphql")!
        let configuration = URLSessionConfiguration.default
        
        var langStr = UserDefaults.standard.string(forKey: "language") ?? Locale.current.languageCode
        if langStr == "en_KR" {
            langStr = "en"
            UserDefaults.standard.set(langStr, forKey: "language")
        }
        
        print("my current language is: \(langStr)")
        configuration.httpAdditionalHeaders = [
            "Authorization": "Bearer \(token)",
            "Accept-Language": langStr ?? "en"
        ] // Add your headers here
        
        let client = URLSessionClient(sessionConfiguration: configuration)
        let store = ApolloStore(cache: InMemoryNormalizedCache())
        let provider = DefaultInterceptorProvider(client: client, store: store)
        let networkTransport = RequestChainNetworkTransport(interceptorProvider: provider, endpointURL: url)
        
        return ApolloClient(networkTransport: networkTransport, store: store)
    }()
}

func initWSApi(token: String) -> ApolloClient {
    return {
        let url = URL(string: "wss://api.amoring.info/graphql")!
        let webSocketClient = WebSocket(url: url, protocol: .graphql_transport_ws)
        let langStr = UserDefaults.standard.string(forKey: "language") ?? Locale.current.languageCode
        let authPayload: JSONEncodableDictionary = [
            "Authorization": "Bearer \(token)",
            "Accept-Language": langStr ?? "ko"
        ]
        let config = WebSocketTransport.Configuration(connectingPayload: authPayload)
        let WSTransport = WebSocketTransport(websocket: webSocketClient, config: config)
        let store = ApolloStore(cache: InMemoryNormalizedCache())
        return ApolloClient(networkTransport: WSTransport, store: store)
    }()
}

class SessionManager: NSObject, ObservableObject, ASAuthorizationControllerDelegate {
    @Published var appState: AppState = .initializing
    
    @Published var isLoading: Bool = false
    @Published var fetchingData: Bool = false

    @AppStorage("sessionToken") var sessionToken: String = UserDefaults.standard.string(forKey: "sessionToken") ?? ""
    @AppStorage("lastProvider") var lastProvider: lastProvider = .google
    @AppStorage("businessEmail") var businessEmail: String = ""
    @AppStorage("userEmail") var userEmail: String = ""
    @AppStorage("rememberEmail") var rememberEmail: Bool = true
    
    @Published var confirmationNumber: String? = nil
    @Published var emailConfirmationToken: String = ""
    @Published var verificationNumber: String? = nil
    @Published var verificationToken: String = ""
    @Published var user: UserInfo? = nil

    @Published var api: ApolloClient = initApi(token: UserDefaults.standard.string(forKey: "sessionToken") ?? "")
//    @Published var wsApi: ApolloClient = WebSocketApiManager().apollo
//    initWSApi(token: UserDefaults.standard.string(forKey: "sessionToken") ?? "")
    
    private(set) var wsApi: ApolloClient?
    private var webSocketTransport: WebSocketTransport?
    
    func initWSApi(token: String) {
        let url = URL(string: "wss://api.amoring.info/graphql")!
        let webSocketClient = WebSocket(url: url, protocol: .graphql_transport_ws)
        let langStr = UserDefaults.standard.string(forKey: "language") ?? Locale.current.languageCode
        let authPayload: JSONEncodableDictionary = [
            "Authorization": "Bearer \(token)",
            "Accept-Language": langStr ?? "ko"
        ]
        let config = WebSocketTransport.Configuration(connectingPayload: authPayload)
        
        let transport = WebSocketTransport(websocket: webSocketClient, config: config)
        self.webSocketTransport = transport
        
        let store = ApolloStore(cache: InMemoryNormalizedCache())
        self.wsApi = ApolloClient(networkTransport: transport, store: store)
    }
    
    func cancelSubscriptions() {
        webSocketTransport?.closeConnection()
        webSocketTransport = nil
        wsApi = nil
    }
    
    func getCurrentSession(delay: Double = 1.5, completion: @escaping (Bool, String) -> Void) {
        self.api = initApi(token: self.sessionToken)
//        self.wsApi = initWSApi(token: self.sessionToken)
        initWSApi(token: self.sessionToken)
        self.appState = .initializing
        api.fetch(query: QueryAuthenticatedUserQuery()) { result in
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                print("getting session .... ")
                
                switch result {
                case .success(let value):
                    guard value.errors == nil else {
                        print(value.errors as Any)
                        self.changeStateWithAnimation(state: .auth)
                        completion(false, value.errors?.first?.localizedDescription ?? "")
                        return
                    }
                    
                    guard let data = value.data else {
                        print("WRONG DATA")
                        self.changeStateWithAnimation(state: .auth)
                        completion(false, "Something went wrong...")
                        return
                    }
                    
                    guard let authUser = data.authenticatedUser else {
                        print("NO USER")
                        print(self.sessionToken)
                        self.changeStateWithAnimation(state: .auth)
                        completion(true, "")
                        return
                    }
                    
                    print("Current Token: \(self.sessionToken)")
                    print("Current User: \(authUser.id)")
                    print("email: \(authUser.fragments.userInfo.email)")
                    self.user = authUser.fragments.userInfo
                    if self.shouldSendNotifications {
                        self.recreateEndPoint()
                    }
                    
                    self.changeStateWithAnimation(state: .session(user: authUser.fragments.userInfo))
                    completion(true, "")
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                    self.changeStateWithAnimation(state: .auth)
                }
            }
        }
    }
    
    func changeStateWithAnimation(state: AppState) {
        DispatchQueue.main.async {
            withAnimation {
                self.appState = state
            }
        }
    }
    
    func signInWithApple() {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.performRequests()
        
    }
    
    func authorizationController(controller: ASAuthorizationController,
                                 didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIdCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let code = appleIdCredential.authorizationCode else {
                print("no code")
                return
                    
            }
//            guard let token = appleIdCredential.identityToken?.base64EncodedString()  else {
//                return
//            }
            
            if let codeString = String(bytes: code, encoding: .utf8) {
                print("code utf: \(codeString)")
                self.signInWithAppleCode(code: codeString) { _,_ in }
            } else {
                print("not a valid UTF-8 sequence")
                
            }
        } else {
            print("No apple credentials")
        }
    }
    
    private func signInWithAppleCode(code: String, completion: @escaping (Bool, String) -> Void) {
        api.perform(mutation: SignInWithAppleMutation(code: code)) { result in
            switch result {
            case .success(let value):
                guard value.errors == nil else {
                    print(value.errors as Any)
                    completion(false, value.errors?.first?.localizedDescription ?? "")
                    return
                }
                
                guard let data = value.data else {
                    print("NO DATA!")
                    completion(false, "Something went wrong")
                    return
                }
                
                guard let sessionToken = data.signInWithApple.sessionToken else {
                    print("NO TOKEN!")
                    completion(false, "No authentication token")
                    return
                }
                
                guard data.signInWithApple.user != nil else {
                    print("NO USER!")
                    completion(false, "No user")
                    return
                }
                
                print(sessionToken)
                
                /// setting push notification
                //MARK: Move it if we need pushes for business account
                self.setupAWSSNSService()
                self.lastProvider = .apple
                self.sessionToken = sessionToken
                self.getCurrentSession(delay: 0) { success, error in
                        completion(success, error)
                }
//                self.changeStateWithAnimation(state: .session(user: User(id: authUser.id).from(authUser)))
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    func signInWithGoogle(completion: @escaping (Bool, String) -> Void) {
        guard let presentingViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController else { return }
        
        GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController) { result, error in
            if let error {
                completion(false, error.localizedDescription)
                print(error.localizedDescription)
            } else {
                if let token = result?.user.idToken?.tokenString {
                    self.signInWithGoogleToken(token: token, completion: completion)
                }
            }
        }
    }
    
    private func signInWithGoogleToken(token: String, completion: @escaping (Bool, String) -> Void) {
        api.perform(mutation: SignInWithGoogleMutation(idToken: token)) { result in
            switch result {
            case .success(let value):
                guard value.errors == nil else {
                    print(value.errors as Any)
                    completion(false, value.errors?.first?.localizedDescription ?? "")
                    return
                }
                
                guard let data = value.data else {
                    print("NO DATA!")
                    completion(false, "Something went wrong")
                    return
                }
                
                guard let sessionToken = data.signInWithGoogle.sessionToken else {
                    print("NO TOKEN!")
                    completion(false, "No authentication token")
                    return
                }
                
                guard data.signInWithGoogle.user != nil else {
                    print("NO USER!")
                    completion(false, "No user")
                    return
                }
                
                print(sessionToken)
                
                /// setting push notification
                //MARK: Move it if we need pushes for business account
                self.setupAWSSNSService()
                self.lastProvider = .google
                self.sessionToken = sessionToken
                self.getCurrentSession(delay: 0) { success, error in
                        completion(success, error)
                }
//                self.changeStateWithAnimation(state: .session(user: User(id: authUser.id).from(authUser)))
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    func signInWithKakao() {
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error {
                    print(error)
                } else {
                    print("oauthToken: \(String(describing: oauthToken))")
                    self.lastProvider = .kakao
                    UserApi.shared.me() { (user, error) in
                        print("---------")
                        print(oauthToken)
//                        print(user as Any)
                        print("user?.kakaoAccount?.email: \(user?.kakaoAccount?.email)")
//                        print(error as Any)
                        
                    }
                }
            }
        } else {
            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                if let error {
                    print(error)
//                    self.signedIn = true
                } else {
                    print("oauthToken: \(oauthToken as Any)")
                    self.lastProvider = .kakao
                    UserApi.shared.me() { (user, error) in
                        print("--------- ++++++++")
                        print(oauthToken)
                        print(user)
                        print(error)
                    }
//                    self.signedIn = true
                }
            }
        }
    }
    
    func signInWithNaver() {
        if NaverThirdPartyLoginConnection
            .getSharedInstance()
            .isPossibleToOpenNaverApp() // Naver App이 깔려있는지 확인하는 함수
        {
            NaverThirdPartyLoginConnection.getSharedInstance().delegate = self
            NaverThirdPartyLoginConnection
                .getSharedInstance()
                .requestThirdPartyLogin()
        } else { // 네이버 앱 안깔려져 있을때
            // Appstore에서 네이버앱 열기
            NaverThirdPartyLoginConnection.getSharedInstance().openAppStoreForNaverApp()
            
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            guard let tokenType = NaverThirdPartyLoginConnection.getSharedInstance().tokenType else { return }
            guard let accessToken = NaverThirdPartyLoginConnection.getSharedInstance().accessToken else { return }
            print(tokenType)
            print(accessToken)
        }
    }

    func signInWithEmail(email: String, password: String, completion: @escaping (Bool, String) -> Void) {
        self.isLoading = true
        api.perform(mutation: SignInMutation(email: email, password: password)) { result in
            self.isLoading = false
            switch result {
            case .success(let value):
                if let errors = value.errors {
                    print(errors)
                    completion(false, errors.first?.localizedDescription ?? "")
                    return
                }
                
                if let sessionToken = value.data?.signIn.sessionToken {
                    print(sessionToken)
                    self.setupAWSSNSService()
                    self.sessionToken = sessionToken
                    self.lastProvider = .none
                    self.userEmail = email
                    self.getCurrentSession(delay: 0) { success, error in
                            completion(success, error)
                    }
                    completion(true, "")
                } else {
                    print("Wrong data!")
                    completion(false, "Wrong data")
                }
                
            case .failure(let error):
                debugPrint(error.localizedDescription)
                completion(false, error.localizedDescription)
            }
        }
    }
    
    func businessSignIn(email: String, password: String, completion: @escaping (Bool, String) -> Void) {
        self.isLoading = true
        api.perform(mutation: SignInMutation(email: email, password: password)) { result in
            self.isLoading = false
            switch result {
            case .success(let value):
                if let errors = value.errors {
                    print(errors)
                    completion(false, errors.first?.localizedDescription ?? "")
                    return
                }
                
                if let sessionToken = value.data?.signIn.sessionToken {
                    print(sessionToken)
                    self.sessionToken = sessionToken
                    self.businessEmail = self.rememberEmail ? email : ""
                    self.lastProvider = .none
                    self.getCurrentSession(delay: 0) { success, error in
                            completion(success, error)
                    }
                    completion(true, "")
                } else {
                    print("Wrong data!")
                    completion(false, "Wrong data")
                }
                
            case .failure(let error):
                debugPrint(error.localizedDescription)
                completion(false, error.localizedDescription)
            }
        }
    }
    
    func signUp(email: String, password: String, completion: @escaping (String?) -> Void) {
        self.isLoading = true
        api.perform(mutation: SignUpMutation(email: email, password: password)) { result in
            self.isLoading = false
            switch result {
            case .success(let value):
                if let errors = value.errors {
                    print(errors)
                    completion(errors.first?.localizedDescription)
                    return
                }
                
                if let confirmationNumber = value.data?.signUp.confirmationNumber, let emailConfirmationToken = value.data?.signUp.emailConfirmationToken, let authUser = value.data?.signUp.user {
                    self.emailConfirmationToken = emailConfirmationToken
                    self.user = authUser.fragments.userInfo
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation {
                            self.confirmationNumber = confirmationNumber
                        }
                    }
                    completion(nil)
                } else {
                    print("Wrong data!")
                    completion("Wrong data!")
                }
                
            case .failure(let error):
                debugPrint(error.localizedDescription)
                completion(error.localizedDescription)
            }
        }
    }
    
    // MARK: FOR TESTS
    func signUpUser(email: String, password: String, completion: @escaping (String?) -> Void) {
        self.isLoading = true
        api.perform(mutation: SignUpUserMutation(email: email, password: password)) { result in
            self.isLoading = false
            switch result {
            case .success(let value):
                if let errors = value.errors {
                    print(errors)
                    completion(errors.first?.localizedDescription)
                    return
                }
                
                if let confirmationNumber = value.data?.signUp.confirmationNumber, let emailConfirmationToken = value.data?.signUp.emailConfirmationToken, let authUser = value.data?.signUp.user {
                    self.emailConfirmationToken = emailConfirmationToken
                    self.user = authUser.fragments.userInfo
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation {
                            self.confirmationNumber = confirmationNumber
                        }
                    }
                    completion(nil)
                } else {
                    print("Wrong data!")
                    completion("Wrong data!")
                }
                
            case .failure(let error):
                debugPrint(error.localizedDescription)
                completion(error.localizedDescription)
            }
        }
    }
    
    func verifyEmail(completion: @escaping (Bool, String) -> Void) {
        if let user = self.user, let verificationNumber {
            self.isLoading = true
            api.perform(mutation: VerifyUserEmailMutation(userId: user.id, confirmationCode: verificationNumber, emailConfirmationToken: self.verificationToken)) { result in
                self.isLoading = false
                switch result {
                case .success(let value):
                    if let errors = value.errors {
                        print(errors)
                        completion(false, errors.first?.localizedDescription ?? "error")
                    }
                    
                    guard let passed = value.data?.verifyUserEmail else {
                        print("Wrong data format! Code: \(verificationNumber)")
                        completion(false, "Wrong code! Code: \(verificationNumber)")
                        return
                    }

                    if passed {
                        
                        print("OTP successfully veryfied")
                        completion(true, "")
//                        self.getCurrentSession(delay: 0) { success, error in
//                            completion(success, error)
//                        }
//                        self.businessSignIn(email: email, password: password) { success, error in
//                            
//                        }
//                        self.changeStateWithAnimation(state: .session(user: user))
                    } else {
                        print("Failed to verify email. Code: \(verificationNumber)")
                        completion(false, "Failed to verify email")
                    }
                    
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                    completion(false, error.localizedDescription)
                }
            }
        }
    }
    
    func startPhoneNumberVerification(phoneNumber: String, completion: @escaping (String?) -> Void) {
        self.isLoading = true
        api.perform(mutation: StartPhoneNumberVerificationMutation(phoneNumber: phoneNumber)) { result in
            self.isLoading = false
            switch result {
            case .success(let value):
                if let errors = value.errors {
                    print(errors)
                    completion(errors.first?.localizedDescription)
                    return
                }
                
                if let verificationNumber = value.data?.startPhoneNumberVerification.verificationNumber, let verificationToken = value.data?.startPhoneNumberVerification.verificationToken {
                    self.verificationToken = verificationToken
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation {
                            self.verificationNumber = verificationNumber
                        }
                    }
                    completion(nil)
                } else {
                    print("Wrong data!")
                    completion("Wrong data!")
                }
                
            case .failure(let error):
                debugPrint(error.localizedDescription)
                completion(error.localizedDescription)
            }
        }
    }
    
    func verifyPhoneNumber(phoneNumber: String, completion: @escaping (Bool, String) -> Void) {
        self.isLoading = true
        if let verificationNumber {
            api.perform(mutation: VerifyPhoneNumberMutation(phoneNumber: phoneNumber, verificationNumber: verificationNumber, verificationToken: self.verificationToken)) { result in
                self.isLoading = false
                switch result {
                case .success(let value):
                    value.errors?.forEach { print($0.localizedDescription) }
                    guard let passed = value.data?.verifyPhoneNumber else {
                        print("Wrong data format!")
                        completion(false, "Wrong code!")
                        return
                    }
                    
                    if passed {
                        print("OTP successfully veryfied")
                        completion(true, "")
                    } else {
                        print("Failed to verify phone number")
                        completion(false, "Failed to verify email")
                    }
                    
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                    completion(false, error.localizedDescription)
                }
            }
        }
    }
    
    func startEmailVerification(completion: @escaping (String?) -> Void) {
        self.isLoading = true
        api.perform(mutation: StartEmailVerificationMutation()) { result in
            self.isLoading = false
            switch result {
            case .success(let value):
                if let errors = value.errors {
                    print(errors)
                    completion(errors.first?.localizedDescription)
                    return
                }
                
                if let verificationNumber = value.data?.startEmailVerification.verificationNumber, let verificationToken = value.data?.startEmailVerification.verificationToken {
                    self.verificationToken = verificationToken
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation {
                            self.verificationNumber = verificationNumber
                        }
                    }
                    completion(nil)
                } else {
                    print("Wrong data!")
                    completion("Wrong data!")
                }
                
            case .failure(let error):
                debugPrint(error.localizedDescription)
                completion(error.localizedDescription)
            }
        }
    }
    
    func signOut() {
        DispatchQueue.main.async {
            
            self.deleteEndPoint() { _ in
                self.disconnectUserDevice()
            }
            self.sessionToken = ""
            self.cancelSubscriptions()
            self.changeStateWithAnimation(state: .auth)
            print("Successfully signed out")
        }
    }
    
    /// The SNS Platform application ARN
    let SNSPlatformApplicationArn = "arn:aws:sns:ap-northeast-2:767397851737:app/APNS/Amoring-IOS"
//    let SNSPlatformApplicationArn = "arn:aws:cognito-identity:ap-northeast-2:767397851737:identitypool/ap-northeast-2:db7d8417-60c6-4f6c-95ce-010cea9c05ca"
    @AppStorage("deviceTokenForSNS") var deviceToken: String?
    @AppStorage("endpointArnForSNS") var endpointArnForSNS: String?
    @AppStorage("shouldSendNotifications") var shouldSendNotifications = true
    func setupAWSSNSService() {
        createEndPoint { error in
            guard error != nil else { return }
            self.recreateEndPoint()
        }
    }
    
    func createEndPoint(completion: @escaping (Error?) -> Void) {
        /// Create a platform endpoint. In this case,  the endpoint is a
        /// device endpoint ARN
        if let deviceToken, let user {
            let sns = AWSSNS.default()
            let request = AWSSNSCreatePlatformEndpointInput()
            request?.token = deviceToken
            request?.attributes = ["UserId": user.id]
            request?.platformApplicationArn = SNSPlatformApplicationArn
            sns.createPlatformEndpoint(request!).continueWith(executor: AWSExecutor.mainThread(), block: { (task: AWSTask!) -> AnyObject? in
                if task.error != nil {
                    print("Error: \(String(describing: task.error))")
                    completion(task.error)
                } else {
                    let createEndpointResponse = task.result! as AWSSNSCreateEndpointResponse

                    if let endpointArnForSNS = createEndpointResponse.endpointArn {
                        print("endpointArn: \(endpointArnForSNS)")
                        self.endpointArnForSNS = endpointArnForSNS
                        self.upsertUserDevice(deviceToken: deviceToken) { error in
                        }
                    }
                    completion(nil)
                }
                return nil
            })
        } else {
            completion(nil)
        }
    }
    /// Delete a platform endpoint. In this case,  the endpoint is a
    /// device endpoint ARN
    func deleteEndPoint(completion: @escaping (Error?) -> Void) {
        let sns = AWSSNS.default()
        let deleteRequest = AWSSNSDeleteEndpointInput()
        deleteRequest?.endpointArn = self.endpointArnForSNS
        sns.deleteEndpoint(deleteRequest!) { response in
            completion(response)
            
        }
    }
    func recreateEndPoint() {
        deleteEndPoint { response in
            print("deleteEndpoint response: \(response?.localizedDescription)")
            self.createEndPoint { _ in  }
        }
    }
    
    func upsertUserDevice(deviceToken: String, deviceOs: String? = nil, completion: @escaping (String?) -> Void) {
        self.isLoading = true
        
        api.perform(mutation: UpsertUserDeviceMutation(deviceToken: deviceToken, deviceEndpointArn: self.endpointArnForSNS ?? "ERROR FROM FRONTEND!", deviceOs: GraphQLNullable<String>.some(UIDevice.current.systemVersion))) { result in
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
                
                print("Device token successfully was sent!")
                
                self.isLoading = false
                
                completion(nil)
            case .failure(let error):
                debugPrint(error.localizedDescription)
                self.isLoading = false
                completion(error.localizedDescription)
            }
        }
    }
    
    func disconnectUserDevice() {
        if let deviceToken {
            self.isLoading = true
            api.perform(mutation: DisconnectUserDeviceMutation(deviceToken: deviceToken)) { result in
                switch result {
                case .success(let value):
                    guard value.errors == nil else {
                        print(value.errors as Any)
                        self.isLoading = false
                        return
                    }
                    
                    guard let data = value.data else {
                        print("NO DATA!")
                        self.isLoading = false
                        return
                    }
                    
                    print("Device token successfully was disconnected!")
                    
                    self.isLoading = false
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                    self.isLoading = false
                }
            }
        } else {
            return
        }
    }
    
    func requestUserPasswordReset(email: String, completion: @escaping (String?, String?) -> Void) {
        self.isLoading = true
        
        api.perform(mutation: RequestUserPasswordResetMutation(email: email)) { result in
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
                
                print("Request for User Password Reset was successfully send!")
                
                self.isLoading = false
                completion(nil, data.requestUserPasswordReset.confirmationToken)
            case .failure(let error):
                debugPrint(error.localizedDescription)
                self.isLoading = false
                completion(error.localizedDescription, nil)
            }
        }
    }
    
    func redeemUserPasswordResetToken(code: String, email: String, password: String, token: String, completion: @escaping (Bool, String?) -> Void) {
            self.isLoading = true
            api.perform(mutation: RedeemUserPasswordResetTokenMutation(confirmationToken: token, confirmationNumber: code, email: email, password: password)) { result in
                self.isLoading = false
                switch result {
                case .success(let value):
                    guard let passed = value.data?.redeemUserPasswordResetToken else {
                        print("Wrong data format!")
                        completion(false, "Wrong code!")
                        return
                    }

                    completion(true, nil)
                    
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                    completion(false, error.localizedDescription)
                }
            }
    }
    
    func deleteMyAccount(completion: @escaping (String?) -> Void) {
        if let user {
        self.isLoading = true
            api.perform(mutation: DeleteMyAccountMutation()) { result in
//            api.perform(mutation: TempDeleteUserResolverMutation(id: user.id)) { result in
                self.isLoading = false
                switch result {
                case .success(let value):
                    if let errors = value.errors {
                        print(errors)
                        completion(errors.first?.localizedDescription)
                        return
                    }
                    
                    guard let _ = value.data?.deleteMyAccount else {
                        completion("something went wrong")
                        return
                    }
                    
                    completion(nil)
                   
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                    completion(error.localizedDescription)
                }
            }
        }
    }
}

extension SessionManager : UIApplicationDelegate, NaverThirdPartyLoginConnectionDelegate {
    // 토큰 발급 성공시
    func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
        print("oauth20ConnectionDidFinishRequestACTokenWithAuthCode")
    }
    // 토큰 갱신시
    func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
        print("oauth20ConnectionDidFinishRequestACTokenWithRefreshToken")
    }
    // 로그아웃(토큰 삭제)시
    func oauth20ConnectionDidFinishDeleteToken() {
        print("oauth20ConnectionDidFinishDeleteToken")
    }
    // Error 발생
    func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
        print("\(String(describing: error))")
    }
}
