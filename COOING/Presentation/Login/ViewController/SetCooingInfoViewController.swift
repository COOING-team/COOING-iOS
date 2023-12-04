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
        setCooingInfoView.manButton.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        setCooingInfoView.womanButton.addTarget(self, action: #selector(button1Clicked), for: .touchUpInside)

    }
    
    // MARK: - Custom Method
    
    @objc
    private func nextButtonDidTapped() {
        createBaby(name: setCooingInfoView.nameTextField.text ?? "CJW", sex: "Female", birth: setCooingInfoView.dateFormat)
        
        let cooingTabBarController = CooingTabBarController()

        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let keyWindow = windowScene.windows.first(where: { $0.isKeyWindow }) {
            keyWindow.replaceRootViewController(UINavigationController(rootViewController: cooingTabBarController), animated: true, completion: nil)
        }
    }
    
    
    @objc func buttonClicked() {
        setCooingInfoView.manButton.setImage(Image.selectedMan, for: .normal)

    }
    
    @objc func button1Clicked() {
        setCooingInfoView.womanButton.setImage(Image.selectedWoman, for: .normal)

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

