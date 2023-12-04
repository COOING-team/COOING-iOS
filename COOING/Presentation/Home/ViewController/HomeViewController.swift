//
//  HomeViewController.swift
//  COOING
//
//  Created by 박윤빈 on 2023/11/05.
//

import UIKit

import Moya

class HomeViewController: BaseViewController {
    
    // MARK: - Properties
    
    private let homeProvider = MoyaProvider<HomeRouter>(plugins: [MoyaLoggingPlugin()])
    static var cooingInfo = CooingDefaultInfoDTO(name: "지우", month: 10, cooingDay: 3, todayRecord: false)
    
    // MARK: - UI Components
    
    private let homeView = HomeView()

    // MARK: - override Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("♥️")
        getHomeInfo()
    }
    
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

// MARK: - Network

extension HomeViewController {
    func getHomeInfo() {
        homeProvider.request(.getInfo) { response in
                switch response {
                case .success(let response):
                    do {
                        print(response.statusCode)

                        let responseData = try response.map(GenericResponse<CooingDefaultInfoDTO>.self)
                        HomeViewController.cooingInfo = responseData.result

                        print("🔆\(responseData.result)")
                    } catch let error {
                        print(error)
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
}
