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
//        navigationController?.isNavigationBarHidden = true
    }
    
    override func setLayout() {
        questionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
