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
    
    private let titleLabel = UILabel()
    private let wordTitleLabel = UILabel()
    private let wordSubTitleLabel = UILabel()
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
        titleLabel.do {
            $0.text = "레포트"
            $0.font = .button1()
            $0.textColor = .cooingBrown2
        }
        
        wordTitleLabel.do {
            $0.text = "빈출단어"
            $0.font = .title2()
            $0.textColor = .cooingBrown
        }
        
        wordSubTitleLabel.do {
            $0.text = "쿠잉이가 지난 한 주 동안 가장 많이 사용한 단어예요."
            $0.font = .body3()
            $0.textColor = .cooingBrown
        }
        
        rankingTableView.do {
            $0.separatorStyle = .none
            $0.showsVerticalScrollIndicator = false
        }
    }
    
    override func hieararchy() {
        self.addSubViews(titleLabel,
                         wordTitleLabel,
                         wordSubTitleLabel,
                         rankingTableView)
    }
    
    override func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.centerX.equalToSuperview()
        }
        
        wordTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(29.adjusted)
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
