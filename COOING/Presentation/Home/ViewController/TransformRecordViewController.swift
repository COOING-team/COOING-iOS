//
//  TransformRecordViewController.swift
//  COOING
//
//  Created by 최지우 on 12/1/23.
//

import UIKit

class TransformRecordViewController: BaseViewController {
    
    // MARK: - UI Components
    
    private let transformRecordView = TransformRecordView()

    // MARK: - override Functions
    
    override func hieararchy() {
        view.addSubview(transformRecordView)
    }
    
    override func configureUI() {
//        navigationController?.isNavigationBarHidden = true
    }
    
    override func setLayout() {
        transformRecordView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func setButtonEvent() {
        transformRecordView.modifyButton.addTarget(self, action: #selector(transformButtonDidTapped), for: .touchUpInside)
        transformRecordView.backButton.addTarget(self, action: #selector(backButtonDidTapped), for: .touchUpInside)
        transformRecordView.nextButton.addTarget(self, action: #selector(nextButtonDidTapped), for: .touchUpInside)

    }
    
    // MARK: - Custom Method
    
    @objc 
    private func transformButtonDidTapped() {
        showAlert(title: "주의", text: "새로운 단어를 추가하게 되면,\n쿠잉이의 정확한 언어 발달 상황을 측정하기 어려워요! \n쿠잉이의 음성을 수정하시겠어요? ", style: .default)
    }
    
    @objc
    private func backButtonDidTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func nextButtonDidTapped() {
        let commentViewController = CommentViewController()
        navigationController?.pushViewController(commentViewController, animated: true)
    }
}

