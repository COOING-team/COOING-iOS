//
//  TestLoginViewController.swift
//  COOING
//
//  Created by 최지우 on 12/2/23.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKUser
import RealmSwift

class TestLoginViewController: BaseViewController {
    
    // MARK: - Properties

        
    // MARK: - UI Components
    
    let kakaoLoginButton = UIButton()
    var infoLabel = UILabel()

    // MARK: - override Method

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func configureUI() {
        super.configureUI()
        
        kakaoLoginButton.do {
            $0.setImage(Image.kakaoLoginButton, for: .normal)
        }
        
        infoLabel.do {
            $0.text = "---------"
        }
    }

    override func setLayout() {
        
        kakaoLoginButton.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        infoLabel.snp.makeConstraints {
            $0.top.equalTo(kakaoLoginButton.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
    }
    
    override func hieararchy() {
        view.addSubViews(kakaoLoginButton,
                         infoLabel)
    }
    
    override func setButtonEvent() {
        kakaoLoginButton.addTarget(self, action: #selector(kakaoLoginButtonDidTapped), for: .touchUpInside)
    }
    
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
                guard let email = user?.kakaoAccount?.email else { return }
                guard let id = user?.id else { return }
//                self.postKakaoLoginRequest(email: email, id: String(id))
                print("email🌈: \(email)  id: \(id)")
            }
        }
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
                self.infoLabel.text = user?.kakaoAccount?.profile?.nickname

//                if let url = user?.kakaoAccount?.profile?.profileImageUrl,
//                    let data = try? Data(contentsOf: url) {
//                    self.profileImageView.image = UIImage(data: data)
//                }
            }
        }
    }

}
