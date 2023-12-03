//
//  SetCooingInfoViewController.swift
//  COOING
//
//  Created by 최지우 on 12/4/23.
//

import UIKit

import Moya

class SetCooingInfoViewController: BaseViewController {
    
    private let cooingInfoRouter = MoyaProvider<CooingInfoRouter>(plugins: [MoyaLoggingPlugin()])
    
    // MARK: - UI Components
    
    private let setCooingInfoView = SetCooingInfoView()

    // MARK: - override Functions
    
    override func hieararchy() {
        view.addSubview(setCooingInfoView)
    }
    
    override func setLayout() {
        setCooingInfoView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func setButtonEvent() {
        setCooingInfoView.nextButton.addTarget(self, action: #selector(nextButtonDidTapped), for: .touchUpInside)
    }
    
    // MARK: - Custom Method
    
    @objc
    private func nextButtonDidTapped() {
        let cooingTabBarController = CooingTabBarController()
        navigationController?.pushViewController(cooingTabBarController, animated: true)
    }
}

// MARK: - Network

extension SetCooingInfoViewController {
    func createBaby(name: String, sex: String, birth: String) {
        cooingInfoRouter.request(.createBaby(name: name, sex: sex, birth: birth)) { result in
                switch result {
                case .success(let response):
                    do {

                        print(response.statusCode)

                        let responseData = try response.map(GenericResponse<String>.self)
                        print("🐽\(responseData.message)")
                        
                    } catch let error {
                        print(error)
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
}

