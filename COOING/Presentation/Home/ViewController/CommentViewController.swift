//
//  CommentViewController.swift
//  COOING
//
//  Created by 최지우 on 12/1/23.
//

import UIKit

class CommentViewController: BaseViewController {
    
    static var todayRecord = TodayRecordDTO(answerText: "", fileUrl: "", comment: "")
    
    // MARK: - UI Components
    
    var cooingAnswer: String = ""
    private let commentView = CommentView()

    // MARK: - override Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("🌈🌈🌈🌈🌈🌈🌈🌈🌈🌈\(CommentViewController.todayRecord)")
    }
    
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
         self.view.endEditing(true)
   }
    
    // MARK: - Custom Method
    
    @objc
    private func backButtonDidTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func nextButtonDidTapped() {
        CommentViewController.todayRecord.comment = commentView.answerTextView.text
        
        
        uploadTodayRecord(cooingIndex: (HomeViewController.cooingInfo.cooingDay+1))
        let recordCompleteViewController = RecordCompleteViewController()
        navigationController?.pushViewController(recordCompleteViewController, animated: true)
    }
}

// MARK: - Network

extension CommentViewController {
    func uploadTodayRecord(cooingIndex: Int) {
        RecordViewController.recordProvider.request(.todayRecord(cooingIndex: cooingIndex, 
                                                                 param: CommentViewController.todayRecord)) { response in
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
