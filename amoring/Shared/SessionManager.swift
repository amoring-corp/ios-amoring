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
    ///Publishing changes from background threads is not allowed; make sure to publish values from the main thread (via operators like receive(on:)) on model updates.
    @Published var isLoading: Bool = true
    @Published var token: String? = nil
    @Published var goToUserOnboarding = false
    @Published var goToBusinessOnboarding = false
    
    @AppStorage("signedIn") var signedIn: Bool = false
    @AppStorage("isBusiness") var BusinessSignedIn: Bool = false
//    @Published var signedIn: Bool = false
//    @Published var isBusiness: Bool = true
    

    func getCurrentSession() {
        
        NetworkService.shared.amoring.fetch(query: QueryAuthenticatedUserQuery()) { result in
            print("getting session .... ")
            switch result {
            case .success(let value):
                if let errors = value.errors {
                    print(errors)
                    return
                } else {
                    print(value.data?.authenticatedUser)
                    print(value.data?.authenticatedUser?.email)
                }
            case .failure(let error):
                
                debugPrint(error.localizedDescription)
            }
            DispatchQueue.main.async {
                withAnimation {
                    self.isLoading = false
                }
                
            }
        }
    }
    
//    func signIn() async {
//        isLoading = true
//        sleep(2)
//        
//            self.signedIn = true
//        
//        
//        isLoading = false
//        print("signed in")
//    }
//    
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
    
    func authorizationController(controller: ASAuthorizationController,
                                 didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIdCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let token = appleIdCredential.identityToken?.base64EncodedString()  else {
                return
            }
            let UserIdentifier = appleIdCredential.user
            self.token = token
            print("token\n")
            print(token)
            print("UserIdentifier\n")
            print(UserIdentifier)
            self.signedIn = true
        }
    }
    
    func signInWithGoogle() {
        guard let presentingViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController else { return }
        
        GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController) { result, error in
            if let error {
                print(error.localizedDescription)
                self.signedIn = true
            } else {
                print(result?.user.profile?.name)
                print(result?.user.profile?.email)
                print(result?.user.accessToken.tokenString)
                print(result?.user.accessToken.expirationDate)
                print(result?.user.idToken?.tokenString)
                print(result?.user.idToken?.expirationDate)
                print(result?.user.fetcherAuthorizer.description)
                print(result?.user.userID)
                self.signedIn = true
            }
        }
    }
    
    func signInWithKakao() {
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error {
                    print(error)
                    self.signedIn = true
                } else {
                    print("oauthToken::")
                    print(oauthToken)
                    
                    UserApi.shared.me() { (user, error) in
                        print("---------")
                        print(user)
                        print(error)
                    }
                    
                    self.signedIn = true
                }
            }
        } else {
            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                if let error {
                    print(error)
                    self.signedIn = true
                } else {
                    print("oauthToken::")
                    print(oauthToken)
                    UserApi.shared.me() { (user, error) in
                        print("--------- ++++++++")
                        print(user)
                        print(error)
                    }
                    self.signedIn = true
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
                    print(data.user?.email)
                    print(UserDefaults.standard.string(forKey: "sessionToken"))
                } else {
                    print("Wrong data!")
                    
                }
                
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        }
    }
}
