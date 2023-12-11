//
//  FrequentWordView.swift
//  COOING
//
//  Created by 박윤빈 on 2023/12/02.
//

import UIKit

import SnapKit
import Then

final class FrequentWordView: BaseView {
    
    // MARK: - UI Components
    
    private let wordTitleLabel = UILabel()
    var wordSubTitleLabel = UILabel()
    var rankingTableView = UITableView()

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
        wordTitleLabel.do {
            $0.text = "빈출단어"
            $0.font = .title2()
            $0.textColor = .cooingBrown
        }
        
        wordSubTitleLabel.do {
            $0.text = "Jiwoo가 지난 한 주 동안 가장 많이 사용한 단어예요."
            $0.font = .body3()
            $0.textColor = .cooingBrown
        }
        
        rankingTableView.do {
            $0.separatorStyle = .none
            $0.showsVerticalScrollIndicator = false
        }
    }
    
    override func hieararchy() {
        self.addSubViews(wordTitleLabel,
                         wordSubTitleLabel,
                         rankingTableView)
    }
    
    override func setLayout() {
        wordTitleLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(20.adjusted)
            $0.leading.equalToSuperview().inset(33.adjusted)
        }
        
        wordSubTitleLabel.snp.makeConstraints {
            $0.top.equalTo(wordTitleLabel.snp.bottom).offset(5.adjusted)
            $0.leading.equalTo(wordTitleLabel)
        }
        
        rankingTableView.snp.makeConstraints {
            $0.top.equalTo(wordSubTitleLabel.snp.bottom).offset(23.adjusted)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}
