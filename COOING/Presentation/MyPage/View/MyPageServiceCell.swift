//
//  MyPageServiceCell.swift
//  COOING
//
//  Created by 최지우 on 12/10/23.
//

import UIKit

import SnapKit

class MyPageServiceCell: UITableViewCell {
    
    // MARK: = Properties
    
    static let identifier = "MyPageServiceCell"
    
    // MARK: - UI Components
    
    var serviceLable = UILabel()
    var rightItemLabel = UILabel()
    
    // MARK: - init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
        hieararchy()
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Functions
    
    func configureUI() {
        
        serviceLable.do {
            $0.font = .body3()
        }
        rightItemLabel.do {
            $0.font = .body3()
        }
    
    }
    
    private func hieararchy() {
        contentView.addSubViews(serviceLable,
                                rightItemLabel)
    }
    
    private func setLayout() {
        serviceLable.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(30)
        }
        rightItemLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(30)
        }
    }
}
