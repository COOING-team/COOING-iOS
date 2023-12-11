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
    private let homeButton = CooingButton()

    // MARK: - override Functions
    
    override func hieararchy() {
        view.addSubview(completeImage)
        view.addSubview(completeLabel)
        view.addSubview(homeButton)
    }
    
    override func configureUI() {
        super.configureUI()
        
        completeLabel.do {
            $0.text = "기록이 완료되었어요."
            $0.font = .body2()
        }
        
        homeButton.do {
            $0.setTitle("홈으로 가기", for: .normal)
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
        homeButton.snp.makeConstraints {
            $0.top.equalTo(completeLabel.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(100)
        }
    }
    
    override func setButtonEvent() {
        homeButton.addTarget(self, action: #selector(homeButtonDidTapped), for: .touchUpInside)

    }
    
    // MARK: - Custom Method
    
    @objc
    func homeButtonDidTapped() {
        if let cooingTabBarController = self.navigationController?.viewControllers.first(where: { $0 is CooingTabBarController }) {
            self.navigationController?.popToViewController(cooingTabBarController, animated: true)
        }
    }
}

