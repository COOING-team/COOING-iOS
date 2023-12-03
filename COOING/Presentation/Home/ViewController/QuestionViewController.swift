//
//  QuestionViewController.swift
//  COOING
//
//  Created by 박윤빈 on 2023/11/06.
//

import UIKit

class QuestionViewController: BaseViewController {
    
    // MARK: - UI Components
    
    private let questionView = QuestionView()

    // MARK: - override Functions
    
    override func hieararchy() {
        view.addSubview(questionView)
    }
    
    override func configureUI() {
        super.configureUI()
//        navigationController?.isNavigationBarHidden = true
    }
    
    override func setLayout() {
        questionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func setButtonEvent() {
        questionView.nextButton.addTarget(self, action: #selector(nextButtonDidTapped), for: .touchUpInside)
    }
    
    // MARK: - Custom Method
    
    @objc
    private func nextButtonDidTapped() {
        let recordViewController = RecordViewController()
        navigationController?.pushViewController(recordViewController, animated: true)
    }
}
