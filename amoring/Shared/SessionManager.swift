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

class SessionManager: NSObject, ObservableObject, ASAuthorizationControllerDelegate {
    @Published var isLoading: Bool = true
    @Published var goToUserOnboarding = false
    @Published var goToBusinessOnboarding = false
    
    @AppStorage("signedIn") var signedIn: Bool = false
    @AppStorage("isBusiness") var businessSignedIn: Bool = false
    
    @AppStorage("sessionToken") var sessionToken: String = ""
//    @Published var signedIn: Bool = false
//    @Published var isBusiness: Bool = true
    

    func getCurrentSession() {
        self.isLoading = true
        NetworkService.shared.amoring.fetch(query: QueryAuthenticatedUserQuery()) { result in
            print("getting session .... ")
            
            switch result {
            case .success(let value):
                guard value.errors == nil else {
                    print(value.errors)
                    self.stopLoading()
                    return
                }
                
                guard let data = value.data else {
                    print("WRONG DATA")
                    self.stopLoading()
                    return
                }
                
                guard let authenticatedUser = data.authenticatedUser else {
                    print("NO USER")
                    self.stopLoading()
                    return
                }
                
                guard let role = authenticatedUser.role?.value else {
                    print("NO ROLE")
                    self.stopLoading()
                    return
                }
                
                switch role {
                case .business:
                    print("I'm a business")
                    
                    if let businessProfile = authenticatedUser.business {
                        print("going to Business Session")
                        print(businessProfile)
                        self.goToBusinessOnboarding = false
                    } else {
                        print("Business not onboarded yet")
                        self.goToBusinessOnboarding = true
                    }
                    self.signedIn = false
                    self.businessSignedIn = true
                    self.stopLoading()
                case .user:
                    print("I'm a user")

                    if let userProfile = authenticatedUser.userProfile {
                        print("going to User Session")
                        print(userProfile)
                        self.goToUserOnboarding = false
                    } else {
                        print("User not onboarded yet")
                        self.goToUserOnboarding = true
                    }
                    self.businessSignedIn = false
                    self.signedIn = true
                    self.stopLoading()
                case .admin:
                    print("I'm an admin")
                    self.stopLoading()
                }
            case .failure(let error):
                debugPrint(error.localizedDescription)
                self.stopLoading()
            }
        }
    }
    
    private func stopLoading() {
        DispatchQueue.main.async {
            withAnimation {
                self.isLoading = false
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
    
    func signInWithGoogle() {
        guard let presentingViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController else { return }
        
        GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController) { result, error in
            if let error {
                print(error.localizedDescription)
            } else {
                if let token = result?.user.idToken?.tokenString {
                    self.signInWithToken(token: token)
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
    
    func businessSignIn(email: String, password: String) {
        NetworkService.shared.amoring.perform(mutation: SignInMutation(email: email, password: password)) { result in
            switch result {
            case .success(let value):
                if let errors = value.errors {
                    print(errors)
                    return
                }
                
                if let data = value.data?.signIn {
                    UserDefaults.standard.setValue(data.sessionToken, forKey: "sessionToken")
                    print(data.sessionToken)
                } else {
                    print("Wrong data!")
                    
                }
                
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    private func signInWithToken(token: String) {
        NetworkService.shared.amoring.perform(mutation: SignInWithGoogleMutation(idToken: token)) { result in
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
                
                guard let sessionToken = data.signInWithGoogle.sessionToken else {
                    print("NO TOKEN!")
                    return
                }
                
                if let user = data.signInWithGoogle.user {
                    print(user)
                    self.goToUserOnboarding = false
                } else {
                    self.goToUserOnboarding = true
                }
                
                print(sessionToken)
                self.sessionToken = sessionToken
                self.signedIn = true
                
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    func signOut() {
        DispatchQueue.main.async {
            self.sessionToken = ""
            withAnimation {
                self.signedIn = false
                self.businessSignedIn = false
                self.goToUserOnboarding = false
                self.goToBusinessOnboarding = false
            }
        }
    }
}
