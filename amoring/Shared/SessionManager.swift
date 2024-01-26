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

func initApi(token: String) -> ApolloClient {
    return {
        let url = URL(string: "https://amoring-be.antonmaker.com/graphql")!
        
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = ["Authorization": "Bearer \(token)"] // Add your headers here
        
        let client = URLSessionClient(sessionConfiguration: configuration)
        let store = ApolloStore(cache: InMemoryNormalizedCache())
        let provider = DefaultInterceptorProvider(client: client, store: store)
        let networkTransport = RequestChainNetworkTransport(interceptorProvider: provider, endpointURL: url)
        
        return ApolloClient(networkTransport: networkTransport, store: store)
    }()
}

class SessionManager: NSObject, ObservableObject, ASAuthorizationControllerDelegate {
    @Published var appState: AppState = .initializing
    
    @Published var isLoading: Bool = false

    @AppStorage("sessionToken") var sessionToken: String = ""
    @AppStorage("lastProvider") var lastProvider: lastProvider = .google
    @AppStorage("businessEmail") var businessEmail: String = ""
    @AppStorage("rememberEmail") var rememberEmail: Bool = true
    
    @Published var confirmationNumber: String? = nil
    @Published var emailConfirmationToken: String = ""
    @Published var user: User? = nil

    @Published var api: ApolloClient = initApi(token: UserDefaults.standard.string(forKey: "sessionToken") ?? "")

    func getCurrentSession(delay: Double = 1.5, completion: @escaping (Bool, String) -> Void) {
        self.api = initApi(token: self.sessionToken)
        self.appState = .initializing
        api.fetch(query: QueryAuthenticatedUserQuery()) { result in
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                print("getting session .... ")
                
                switch result {
                case .success(let value):
                    guard value.errors == nil else {
                        print(value.errors)
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
                    self.user = User(id: authUser.id).from(authUser)
                    self.changeStateWithAnimation(state: .session(user: User(id: authUser.id).from(authUser)))
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
    
    func appleButton() -> some View {
        SignInWithAppleButton(
            onRequest: { request in
                request.requestedScopes = [.fullName, .email]
            },
            onCompletion: { result in
                switch result {
                case .success(let authResults):
                    print("Apple Login Successful")
                    switch authResults.credential{
                    case let appleIDCredential as ASAuthorizationAppleIDCredential:
                        let UserIdentifier = appleIDCredential.user
                        let fullName = appleIDCredential.fullName
                        let name =  (fullName?.familyName ?? "") + (fullName?.givenName ?? "")
                        let email = appleIDCredential.email
                        let IdentityToken = String(data: appleIDCredential.identityToken!, encoding: .utf8)
                        let AuthorizationCode = String(data: appleIDCredential.authorizationCode!, encoding: .utf8)
                        
//                        print(appleIDCredential)
                        print(UserIdentifier)
//                        print(name)
//                        print(email)
//                        print(IdentityToken)
//                        print(AuthorizationCode)
                        self.lastProvider = .apple
                    default:
                        break
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    print("error")
                }
            }
        )
        .signInWithAppleButtonStyle(.white)
        .labelStyle(.iconOnly)
        .frame(width : 50, height: 50, alignment: .leading)
                .cornerRadius(25)
    }
    
    func signInWithApple() {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.performRequests()
        
    }
    
//    func authorizationController(controller: ASAuthorizationController,
//                                 didCompleteWithAuthorization authorization: ASAuthorization) {
//        if let appleIdCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
//            guard let token = appleIdCredential.identityToken?.base64EncodedString()  else {
//                return
//            }
//            let UserIdentifier = appleIdCredential.user
//            self.token = token
//            print("token\n")
//            print(token)
//            print("UserIdentifier\n")
//            print(UserIdentifier)
//            self.signedIn = true
//        }
//    }
    
    func signInWithGoogle(completion: @escaping (Bool, String) -> Void) {
        guard let presentingViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController else { return }
        
        GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController) { result, error in
            if let error {
                completion(false, error.localizedDescription)
                print(error.localizedDescription)
            } else {
                if let token = result?.user.idToken?.tokenString {
                    self.lastProvider = .google
                    self.signInWithToken(token: token, completion: completion)
                }
            }
        }
    }
    
    func signInWithKakao() {
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error {
                    print(error)
                    
                } else {
                    print("oauthToken::")
                    print(oauthToken)
                    self.lastProvider = .kakao
                    UserApi.shared.me() { (user, error) in
                        print("---------")
                        print(user)
                        print(error)
                    }
                    
                    
                }
            }
        } else {
            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                if let error {
                    print(error)
//                    self.signedIn = true
                } else {
                    print("oauthToken::")
                    print(oauthToken)
                    self.lastProvider = .kakao
                    UserApi.shared.me() { (user, error) in
                        print("--------- ++++++++")
                        print(user)
                        print(error)
                    }
//                    self.signedIn = true
                }
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
                    if self.rememberEmail {
                        self.businessEmail = email
                    }
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
    
    func signUp(email: String, password: String, completion: @escaping (Bool) -> Void) {
        self.isLoading = true
        api.perform(mutation: SignUpMutation(email: email, password: password)) { result in
            self.isLoading = false
            switch result {
            case .success(let value):
                if let errors = value.errors {
                    print(errors)
                    completion(false)
                    return
                }
                
                if let confirmationNumber = value.data?.signUp.confirmationNumber, let emailConfirmationToken = value.data?.signUp.emailConfirmationToken, let authUser = value.data?.signUp.user {
                    self.emailConfirmationToken = emailConfirmationToken
                    // FIXME: ! create a decoder
                    self.user = User(
                        id: authUser.id,
                        email: authUser.email,
                        role: UserRole.business
                    )
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation {
                            self.confirmationNumber = confirmationNumber
                        }
                    }
                    completion(true)
                } else {
                    print("Wrong data!")
                    completion(false)
                }
                
            case .failure(let error):
                debugPrint(error.localizedDescription)
                completion(false)
            }
        }
    }
    
    func verifyEmail(code: String, email: String, password: String, completion: @escaping (Bool, String) -> Void) {
        if let user = self.user {
            self.isLoading = true
            api.perform(mutation: VerifyUserEmailMutation(userId: user.id, confirmationCode: code, emailConfirmationToken: self.emailConfirmationToken)) { result in
                self.isLoading = false
                switch result {
                case .success(let value):
                    guard let passed = value.data?.verifyUserEmailResolver else {
                        print("Wrong data format!")
                        completion(false, "Wrong data format")
                        return
                    }

                    if passed {
                        print("OTP successfully veryfied")
                        self.businessSignIn(email: email, password: password) { success, error in
                            completion(success, error)
                        }
//                        self.changeStateWithAnimation(state: .session(user: user))
                    } else {
                        print("Failed to verify email")
                        completion(false, "Failed to verify email")
                    }
                    
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                    completion(false, error.localizedDescription)
                }
            }
        }
    }
    
    private func signInWithToken(token: String, completion: @escaping (Bool, String) -> Void) {
        api.perform(mutation: SignInWithGoogleMutation(idToken: token)) { result in
            switch result {
            case .success(let value):
                guard value.errors == nil else {
                    print(value.errors)
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
                
                guard let authUser = data.signInWithGoogle.user else {
                    print("NO USER!")
                    completion(false, "No user")
                    return
                }
                
                print(sessionToken)
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
    
    
    func signOut() {
        DispatchQueue.main.async {
            self.sessionToken = ""
            self.changeStateWithAnimation(state: .auth)
            print("Successfully signed out")
        }
    }
}
