//
//  HistoryDetailViewController.swift
//  COOING
//
//  Created by 박윤빈 on 2023/12/09.
//

import UIKit

final class HistoryDetailViewController: BaseViewController {
    
    // MARK: - UI Components
    
    let historyDetailView = HistoryDetailView()

    // MARK: - override Functions
    
    override func hieararchy() {
        view.addSubview(historyDetailView)
    }
    
    override func configureUI() {
        super.configureUI()

//        navigationController?.isNavigationBarHidden = true
    }
    
    override func setLayout() {
        historyDetailView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func setButtonEvent() {
        
    }
    
    // MARK: - Custom Method
    
}


