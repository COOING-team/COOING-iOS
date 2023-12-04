//
//  QuestionViewController.swift
//  COOING
//
//  Created by 박윤빈 on 2023/11/06.
//

import UIKit

import Moya

class QuestionViewController: BaseViewController {
    
    // MARK: - Properties
    
    private let questionProvider = MoyaProvider<QuestionRouter>(plugins: [MoyaLoggingPlugin()])
    static var todayQuestion = ""
    
    // MARK: - UI Components
    
    private let questionView = QuestionView()

    // MARK: - override Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchQuestion(cooingIndex: (HomeViewController.cooingInfo.cooingDay+1))
    }
    
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


// MARK: - Network

extension QuestionViewController {
    func fetchQuestion(cooingIndex: Int) {
            questionProvider.request(.getQuestion(cooingIndex: cooingIndex)) { response in
                switch response {
                case .success(let response):
                    do {
                        print(response.statusCode)
                        
                        let responseData = try response.map(GenericResponse<QuestionDTO>.self)
                        QuestionViewController.todayQuestion = responseData.result.content
                        self.questionView.questionLabel.text = QuestionViewController.todayQuestion
                        print("🔆\(QuestionViewController.todayQuestion)")
                    } catch {
                        print("Error decoding response: \(error.localizedDescription)")
                    }
                case .failure(let error):
                    print("Error making request: \(error.localizedDescription)")
                }
            }
        }
}
