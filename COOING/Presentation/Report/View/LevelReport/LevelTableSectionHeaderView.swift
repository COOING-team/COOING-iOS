//
//  LevelTableViewHeaderView.swift
//  COOING
//
//  Created by 박윤빈 on 2023/12/03.
//

import UIKit

import SnapKit
import Then

final class LevelTableViewHeaderView: UITableViewHeaderFooterView {
    
    // MARK: - Properties
    
    static let identifier = "LevelTableViewHeaderView"
    
    // MARK: - UI Components
    
    private let titleLabel = UILabel()
    
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
        titleLabel.do {
            $0.text = "구문 구조"
            $0.font = .body1()
            $0.textColor = .cooingBrown
        }
    }
    
    private func hieararchy() {
        self.addSubview(titleLabel)
    }
    
    private func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
    }
    
    func configureHeader(title: String) {
        titleLabel.text = title
    }
}
