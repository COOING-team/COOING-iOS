//
//  LoginViewController.swift
//  COOING
//
//  Created by 최지우 on 12/3/23.
//

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

    // MARK: - override Functions
    
    override func hieararchy() {
        view.addSubview(loginCooingLogoImage)
        view.addSubview(kakaoLoginButton)
                        
    }
    
    override func configureUI() {
        super.configureUI()
        
        kakaoLoginButton.do {
            $0.setImage(Image.kakaoLoginButton, for: .normal)
        }
    }
    
    override func setLayout() {
        loginCooingLogoImage.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(205)
            $0.centerX.equalToSuperview()
        }
        kakaoLoginButton.snp.makeConstraints {
            $0.top.equalTo(loginCooingLogoImage.snp.bottom).offset(148)
            $0.centerX.equalToSuperview()
        }
    }
    
    override func setButtonEvent() {
        kakaoLoginButton.addTarget(self, action: #selector(kakaoLoginButtonDidTapped), for: .touchUpInside)

    }
    
    // MARK: - Custom Method
    
    @objc
    func kakaoLoginButtonDidTapped() {
        
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

                    //카카오 로그인을 통해 사용자 토큰을 발급 받은 후 사용자 관리 API 호출
                    self.setUserInfo()
                }
            }
        } else {
            // 카카오 계정을 통한 웹 로그인 시도
            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    self.getUserInfo()
                    _ = oauthToken
                }
            }
        }
    }
    
    private func getUserInfo() {
        UserApi.shared.me { user, error in
            if let error = error {
                print("🎃", error)
            } else {
                guard let providerId = user?.id else { return }
                guard let nickname = user?.kakaoAccount?.profile?.nickname else { return }
                guard let email = user?.kakaoAccount?.email else { return }

                self.postKakaoLoginRequest(providerId: String(providerId), nickname: nickname, email: email)
//                print("email🌈: \(email)  id: \(id)  nickname: \(nickname)")
            }
        }
    }
    
    private func addTokenInRealm(accessToken:String, refreshToken:String) {
        RealmService.shared.addToken(accessToken: accessToken, refreshToken: refreshToken)
        print("⭐️⭐️토큰 저장 성공~⭐️⭐️")
        print(RealmService.shared.getToken())
        print(RealmService.shared.getRefreshToken())
    }


    func setUserInfo() {
        UserApi.shared.me() {(user, error) in
            if let error = error {
                print(error)
            }
            else {
                print("me() success.")
                //do something
                _ = user
//                self.infoLabel.text = user?.kakaoAccount?.profile?.nickname

//                if let url = user?.kakaoAccount?.profile?.profileImageUrl,
//                    let data = try? Data(contentsOf: url) {
//                    self.profileImageView.image = UIImage(data: data)
//                }
            }
        }
    }
     
}

// MARK: - Network

extension LoginViewController {
    func postKakaoLoginRequest(providerId: String, nickname: String, email: String) {
        self.authProvider.request(.kakaoLogin(param: KakaoLoginRequestDTO(providerId: providerId,
                                                                          nickname: nickname,
                                                                          email: email))) { response in
            switch response {
            case .success(let response):
                do {
                    print(response.statusCode)
//                    let responseData = try response.data.map(
                    print(response)
                } catch(let err) {
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            
            }
        }
    }
}
