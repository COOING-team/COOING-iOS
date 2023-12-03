//
//  CommentViewController.swift
//  COOING
//
//  Created by 최지우 on 12/1/23.
//

import UIKit

class CommentViewController: BaseViewController {
    
    // MARK: - UI Components
    
    var cooingAnswer: String = ""
    private let commentView = CommentView()

    // MARK: - override Functions
    
    override func hieararchy() {
        view.addSubview(commentView)
    }
    
    override func configureUI() {
        super.configureUI()

//        navigationController?.isNavigationBarHidden = true
    }
    
    override func setLayout() {
        commentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func setButtonEvent() {
        commentView.backButton.addTarget(self, action: #selector(backButtonDidTapped), for: .touchUpInside)
        commentView.nextButton.addTarget(self, action: #selector(nextButtonDidTapped), for: .touchUpInside)

    }
    
    // MARK: - Custom Method
    
    @objc
    private func backButtonDidTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func nextButtonDidTapped() {
        let recordCompleteViewController = RecordCompleteViewController()
        navigationController?.pushViewController(recordCompleteViewController, animated: true)
    }
}

// MARK: - Network

extension CommentViewController {
    func uploadTodayRecord(cooingIndex: Int, answerText: String, fileUrl: String, comment: String) {
        RecordViewController.recordProvider.request(.todayRecord(cooingIndex: cooingIndex, 
                                                                 param: TodayRecordDTO(answerText: answerText,
                                                                                       fileUrl: fileUrl,
                                                                                       comment: comment))) { response in
            switch response {
            case .success(let response):
                do {
                    print(response.statusCode)

                    let responseData = try response.map(GenericResponse<String>.self)


                    print("🔆\(responseData.result)")

                    
                } catch(let err) {
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            
            }
        }
    }
}
