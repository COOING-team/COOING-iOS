//
//  TestLoginViewController.swift
//  COOING
//
//  Created by 최지우 on 12/2/23.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKUser

class TestLoginViewController: BaseViewController {
    
    // MARK: - Properties

        
    // MARK: - UI Components
    
    let kakaoLoginButton = UIButton()

    // MARK: - override Method

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func configureUI() {
        kakaoLoginButton.do {
            $0.setImage(Image.kakaoLoginButton, for: .normal)
        }
    }

    override func setLayout() {
        
        kakaoLoginButton.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    override func hieararchy() {
        view.addSubViews(kakaoLoginButton)
    }

}
