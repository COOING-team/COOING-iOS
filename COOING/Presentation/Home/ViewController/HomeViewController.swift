//
//  HomeViewController.swift
//  COOING
//
//  Created by 박윤빈 on 2023/11/05.
//

import UIKit

class HomeViewController: BaseViewController {
    
    // MARK: - UI Components
    
    private let homeView = HomeView()

    // MARK: - override Functions
    
    override func hieararchy() {
        view.addSubview(homeView)
    }
    
    override func setLayout() {
        homeView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func setButtonEvent() {
        homeView.nextButton.addTarget(self, action: #selector(nextButtonDidTapped), for: .touchUpInside)
    }
    
    // MARK: - Custom Method
    
    @objc
    private func nextButtonDidTapped() {
        let questionViewController = QuestionViewController()
        navigationController?.pushViewController(questionViewController, animated: true)
    }
}
