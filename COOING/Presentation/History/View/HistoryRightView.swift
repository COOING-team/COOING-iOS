//
//  HistoryRightView.swift
//  COOING
//
//  Created by 박윤빈 on 2023/12/03.
//

import UIKit

import SnapKit
import Then

final class HistoryRightView: BaseView {
    
    // MARK: - UI Components
    
    private var wordLabel = UILabel()

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
            $0.layer.cornerRadius = 10
        }
        
        wordLabel.do {
            $0.font = .report1()
            $0.text = "재미있는 일이 있는 하루였어"
            $0.textColor = .cooingBrown
            $0.numberOfLines = 2
        }
    }
    
    override func hieararchy() {
        self.addSubview(wordLabel)
    }
    
    override func setLayout() {
        wordLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
