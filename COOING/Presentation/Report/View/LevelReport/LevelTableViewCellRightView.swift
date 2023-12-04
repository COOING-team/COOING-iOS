//
//  LevelTableViewCellRightView.swift
//  COOING
//
//  Created by 박윤빈 on 2023/12/03.
//

import UIKit

import SnapKit
import Then

final class LevelTableViewCellRightView: BaseView {
    
    // MARK: - UI Components
    
    var text: String = "" {
        didSet {
            wordLabel.text = text
            self.snp.updateConstraints {
                $0.width.equalTo(Double(wordLabel.intrinsicContentSize.width).adjusted)
            }
        }
    }
    var wordLabel = UILabel()

    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions

    override func configureUI() {
        self.do {
            $0.backgroundColor = .cooingGray2
            $0.layer.cornerRadius = 5
        }
        
        wordLabel.do {
            $0.font = .body6()
            $0.text = " 한 낱말 이상의 문장 구조가 나타나요."
            $0.textColor = .cooingBrown
        }
    }
    
    override func hieararchy() {
        self.addSubViews(wordLabel)
    }
    
    override func setLayout() {
        self.snp.makeConstraints {
            $0.width.equalTo(Double(wordLabel.intrinsicContentSize.width).adjusted)
        }
        
        wordLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}

