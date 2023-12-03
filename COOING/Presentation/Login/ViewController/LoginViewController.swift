//
//  LoginViewController.swift
//  COOING
//
//  Created by 최지우 on 12/3/23.
//

import UIKit

class LoginViewController: BaseViewController {
    
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


    }
    
    // MARK: - Custom Method
    
    @objc
    private func transformButtonDidTapped() {
        
    }
     
}
