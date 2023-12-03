//
//  LevelTableViewCell.swift
//  COOING
//
//  Created by 박윤빈 on 2023/12/03.
//

import UIKit

import SnapKit
import Then

final class LevelTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier = "LevelTableViewCell"
    
    // MARK: - UI Components
    
    private lazy var isPossibleButton = UIButton()
    private let levelTableViewCellRightView = LevelTableViewCellRightView()
    
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
    
    private func configureUI() {
        isPossibleButton.do {
            $0.setImage(Image.yes, for: .normal)
            $0.setImage(Image.no, for: .selected)
            $0.isUserInteractionEnabled = false
        }
    }
    
    private func hieararchy() {
        self.contentView.addSubViews(isPossibleButton, levelTableViewCellRightView)
    }
    
    private func setLayout() {
        isPossibleButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.height.width.equalTo(15.adjusted)
        }
        
        levelTableViewCellRightView.snp.makeConstraints {
            $0.height.equalTo(26.adjusted)
            $0.centerY.equalTo(isPossibleButton)
            $0.leading.equalTo(isPossibleButton.snp.trailing).offset(10.adjusted)
        }
    }
}
