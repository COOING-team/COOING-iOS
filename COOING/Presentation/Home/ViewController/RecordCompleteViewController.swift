//
//  RecordCompleteViewController.swift
//  COOING
//
//  Created by 최지우 on 12/3/23.
//

import UIKit

class RecordCompleteViewController: BaseViewController {
    
    // MARK: - Properties
    
//    private let authProvider = MoyaProvider<AuthRouter>(plugins: [MoyaLoggingPlugin()])
    
    // MARK: - UI Components
    
    private let completeImage = UIImageView(image: Image.completeIcon)
    var completeLabel = UILabel()
    private let homeButton = UIButton()

    // MARK: - override Functions
    
    override func hieararchy() {
        view.addSubview(completeImage)
        view.addSubview(completeLabel)
    }
    
    override func configureUI() {
        super.configureUI()
        
        completeLabel.do {
            $0.text = "100일 째의 기록이 완료되었어요."
            $0.font = .body2()
        }
    }
    
    override func setLayout() {
        completeImage.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(256)
            $0.centerX.equalToSuperview()
        }
        completeLabel.snp.makeConstraints {
            $0.top.equalTo(completeImage.snp.bottom).offset(18)
            $0.centerX.equalToSuperview()
        }
    }
    
    override func setButtonEvent() {
//        kakaoLoginButton.addTarget(self, action: #selector(kakaoLoginButtonDidTapped), for: .touchUpInside)

    }
    
    // MARK: - Custom Method
}

