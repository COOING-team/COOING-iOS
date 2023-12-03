//
//  LevelTableSectionFooterView.swift
//  COOING
//
//  Created by 박윤빈 on 2023/12/03.
//

import UIKit

import SnapKit
import Then

final class LevelTableSectionFooterView: UITableViewHeaderFooterView {
    
    // MARK: - Properties
    
    static let identifier = "LevelTableSectionFooterView"
    
    // MARK: - UI Components
    
    private let divideView = UIView()
    
    // MARK: - init
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        configureUI()
        hieararchy()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    
    private func configureUI() {
        divideView.do {
            $0.backgroundColor = .cooingGray2
        }
    }
    
    private func hieararchy() {
        self.addSubview(divideView)
    }
    
    private func setLayout() {
        divideView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.height.equalTo(2.adjusted)
        }
    }
}
