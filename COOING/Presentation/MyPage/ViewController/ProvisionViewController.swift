//
//  ProvisionViewController.swift
//  COOING
//
//  Created by 최지우 on 12/11/23.
//

import UIKit

class ProvisionViewController: BaseViewController {
    
    // MARK: - Properties
    
    var navigationTitle = "개인 정보 약관"
    
    // MARK: - UI Components
    
    let provisionView = ProvisionView()
    
    // MARK: - Life Cycles

    
    // MARK: - Functions
    
    override func customNavigationBar() {
        super.customNavigationBar()
        navigationItem.title = navigationTitle
    }
    
    override func configureUI() {
        view.addSubview(provisionView)
    }
    
    override func setLayout() {
        provisionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
