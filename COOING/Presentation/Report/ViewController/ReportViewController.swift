//
//  ReportViewController.swift
//  COOING
//
//  Created by 박윤빈 on 2023/11/05.
//

import UIKit

class ReportViewController: BaseViewController {
    
    // MARK: - UI Components
    
    private let reportView = ReportView()
    
    // MARK: - Life Cycles

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        setViewGesture()
    }
    
    // MARK: - Functions

    override func configureUI() {
        
    }

    override func hieararchy() {
        self.view.addSubview(reportView)
    }

    override func setLayout() {
        reportView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    override func setButtonEvent() {
        //override Point
    }
    
    private func setViewGesture() {
        reportView.frequentWordHandler = {[weak self] in
            guard let self else { return }
            let frequentWordViewController = FrequentWordViewController()
            self.navigationController?.pushViewController(frequentWordViewController, animated: true)
        }
        
        reportView.secretNoteHandler = {[weak self] in
            guard let self else { return }
            let secretNoteViewController = SecretNoteViewController()
            self.navigationController?.pushViewController(secretNoteViewController, animated: true)
        }
    }
}
