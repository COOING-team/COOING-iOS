//
//  FrequentWordRightView.swift
//  COOING
//
//  Created by 박윤빈 on 2023/12/02.
//

import UIKit

import SnapKit
import Then

final class FrequentWordRightView: BaseView {
    
    // MARK: - UI Components
    
    var wordLabel = UILabel()
    var countLabel = UILabel()

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
            $0.layer.cornerRadius = 15
        }
        
        wordLabel.do {
            $0.font = .body1()
            $0.text = "친구"
            $0.textColor = .cooingBrown
        }
        
        countLabel.do {
            $0.font = .body1()
            $0.text = "50회"
            $0.textColor = .cooingBrown
        }
    }
    
    override func hieararchy() {
        self.addSubViews(wordLabel,
                         countLabel)
    }
    
    override func setLayout() {
        wordLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(30.adjusted)
        }
        
        countLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(30.adjusted)
        }
    }
}
