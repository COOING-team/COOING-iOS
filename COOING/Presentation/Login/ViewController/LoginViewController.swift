//
//  LoginViewController.swift
//  COOING
//
//  Created by 최지우 on 12/3/23.
//

import AuthenticationServices
import UIKit

import KakaoSDKAuth
import KakaoSDKUser
import Moya
import RealmSwift

class LoginViewController: BaseViewController {
    
    // MARK: - Properties
    
    private let authProvider = MoyaProvider<AuthRouter>(plugins: [MoyaLoggingPlugin()])
    
    // MARK: - UI Components
    
    private let loginCooingLogoImage = UIImageView(image: Image.loginCooingLogo)
    private let kakaoLoginButton = UIButton()
    private let appleLoginButton = UIButton()

    // MARK: - override Functions
    
    override func hieararchy() {
        
        view.addSubview(loginCooingLogoImage)
        view.addSubview(kakaoLoginButton)
        view.addSubview(appleLoginButton)

    }
    
    override func configureUI() {
        super.configureUI()
        
        kakaoLoginButton.do {
            $0.setImage(Image.kakaoLoginButton, for: .normal)
        }
        
        appleLoginButton.do {
            $0.setImage(Image.appleLoginButton, for: .normal)
        }
    }
    
    override func setLayout() {
        loginCooingLogoImage.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(205)
            $0.centerX.equalToSuperview()
        }
        appleLoginButton.snp.makeConstraints {
            $0.top.equalTo(loginCooingLogoImage.snp.bottom).offset(148)
            $0.centerX.equalToSuperview()
        }
        kakaoLoginButton.snp.makeConstraints {
            $0.top.equalTo(appleLoginButton.snp.bottom).offset(18)
            $0.centerX.equalToSuperview()
        }

    }
    
    override func setButtonEvent() {
        appleLoginButton.addTarget(self, action: #selector(appleLoginButtonDidTapped), for: .touchUpInside)
        kakaoLoginButton.addTarget(self, action: #selector(kakaoLoginButtonDidTapped), for: .touchUpInside)
    }
    
    // MARK: - Custom Method
    
    @objc
    func appleLoginButtonDidTapped() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email] //유저로 부터 알 수 있는 정보들(name, email)
               
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    @objc
    func kakaoLoginButtonDidTapped() {
        
        if RealmService.shared.isAccessTokenPresent() {
            pushToHomeVC()
        } else {
            // 카카오톡 설치 여부 확인
            if (UserApi.isKakaoTalkLoginAvailable()) {
                UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                    if let error = error {
                        print(error)
                    }
                    else {
                        print("loginWithKakaoTalk() success.")
                        // do something
                        _ = oauthToken
                        // 어세스토큰
                        let accessToken = oauthToken?.accessToken
                        
                        self.getKakaoUserInfo()
                        
                    }
                }
            } else {
                // 카카오 계정을 통한 웹 로그인 시도
                UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                    if let error = error {
                        print(error)
                    }
                    else {
                        self.getKakaoUserInfo()
                        _ = oauthToken
                    }
                }
            }
        }
    }
    
    private func getKakaoUserInfo() {
        UserApi.shared.me { user, error in
            if let error = error {
                print(error)
            } else {
                guard let name = user?.kakaoAccount?.profile?.nickname else { return }
                guard let email = user?.kakaoAccount?.email else { return }

                self.postLoginRequest(name: name, email: email, oauthProvider: "KAKAO")
            }
        }
    }
    
    private func addTokenInRealm(accessToken: String, refreshToken: String) {
        RealmService.shared.addToken(accessToken: accessToken, refreshToken: refreshToken)
        print("⭐️⭐️ restore token ⭐️⭐️")
    }
    
    private func pushToHomeVC() {
        let cooingTabBarController = CooingTabBarController()

        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let keyWindow = windowScene.windows.first(where: { $0.isKeyWindow }) {
            keyWindow.replaceRootViewController(UINavigationController(rootViewController: cooingTabBarController), animated: true, completion: nil)
        }
    }
    
    private func pushToSetInfoVC() {
        let setCooingInfoViewController = SetCooingInfoViewController()

        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let keyWindow = windowScene.windows.first(where: { $0.isKeyWindow }) {
            keyWindow.replaceRootViewController(UINavigationController(rootViewController: setCooingInfoViewController), animated: true, completion: nil)
        }
    }
}

// MARK: - Network

extension LoginViewController {
    func postLoginRequest(name: String, email: String, oauthProvider: String) {
        self.authProvider.request(.login(param: LoginRequestDTO(name: name,
                                                                email: email,
                                                                oauthProvider: oauthProvider))) { response in
            switch response {
            case .success(let response):
                do {
                    print(response.statusCode)

                    let responseData = try response.map(GenericResponse<IdentityTokenDTO>.self)
                    self.addTokenInRealm(accessToken: responseData.result.accessToken,
                                         refreshToken: responseData.result.refreshToken)
                    self.pushToSetInfoVC()
                } catch(let err) {
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            
            }
        }
    }
}

extension LoginViewController: ASAuthorizationControllerPresentationContextProviding, ASAuthorizationControllerDelegate {
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    // Apple ID 연동 성공 시
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
            // Apple ID
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            
            // 계정 정보 가져오기
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            let idToken = appleIDCredential.identityToken!
            let tokeStr = String(data: idToken, encoding: .utf8)
    
            postLoginRequest(name: String((fullName?.givenName)!), email: email!, oauthProvider: "APPLE")
            print("User ID : \(userIdentifier)")
            print("User Email : \(email ?? "")")
            print("User Name : \((fullName?.givenName ?? "") + (fullName?.familyName ?? ""))")
            print("token : \(String(describing: tokeStr))")
            
        default:
            break
        }
    }
    
    // Apple ID 연동 실패 시
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Login in Fail.")
    }
}

