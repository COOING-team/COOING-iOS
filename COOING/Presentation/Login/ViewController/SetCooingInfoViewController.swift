//
//  SetCooingInfoViewController.swift
//  COOING
//
//  Created by 최지우 on 12/4/23.
//

import UIKit

import Moya

class SetCooingInfoViewController: BaseViewController, UITextFieldDelegate {
    
    // MARK: - Properties
    
    private let cooingInfoRouter = MoyaProvider<CooingInfoRouter>(plugins: [MoyaLoggingPlugin()])
    var manChecked = false
    var womanChecked = false
    var checkedSex = "Male"
    
    // MARK: - UI Components
    
    private let setCooingInfoView = SetCooingInfoView()

    // MARK: - override Functions
    
    override func hieararchy() {
        view.addSubview(setCooingInfoView)
        
//        setCooingInfoView.nameTextField.delegate = self
//        dismissKeyboard()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
            self.view.endEditing(true)
      }
    
    override func setLayout() {
        setCooingInfoView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func setButtonEvent() {
        setCooingInfoView.nextButton.addTarget(self, action: #selector(nextButtonDidTapped), for: .touchUpInside)
        setCooingInfoView.manButton.addTarget(self, action: #selector(manButtonClicked), for: .touchUpInside)
        setCooingInfoView.womanButton.addTarget(self, action: #selector(womanButtonClicked), for: .touchUpInside)

    }
    
    // MARK: - Custom Method
    
    @objc
    private func nextButtonDidTapped() {
        checkSex()
        createBaby(name: setCooingInfoView.nameTextField.text ?? "CJW", sex: checkedSex, birth: setCooingInfoView.dateFormat)
        
        let cooingTabBarController = CooingTabBarController()

        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let keyWindow = windowScene.windows.first(where: { $0.isKeyWindow }) {
            keyWindow.replaceRootViewController(UINavigationController(rootViewController: cooingTabBarController), animated: true, completion: nil)
        }
    }
    
    
    @objc func manButtonClicked() {
        
        manChecked.toggle()
        if manChecked {
            setCooingInfoView.manButton.setImage(Image.selectedMan, for: .normal)
        } else {
            setCooingInfoView.manButton.setImage(Image.unselectedMan, for: .normal)
        }

    }
    
    @objc func womanButtonClicked() {
        
        womanChecked.toggle()
        if womanChecked {
            setCooingInfoView.womanButton.setImage(Image.selectedWoman, for: .normal)
        } else {
            setCooingInfoView.womanButton.setImage(Image.unselectedWoman, for: .normal)
        }

    }
    
    func checkSex() {
        if manChecked {
            checkedSex = "Male"
        } else {
            checkedSex = "Female"
        }
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

