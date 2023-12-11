//
//  SecretNoteView.swift
//  COOING
//
//  Created by 박윤빈 on 2023/12/03.
//

import UIKit

import SnapKit
import Then

final class SecretNoteView: BaseView {
    
    // MARK: - UI Components
    
    private let titleLabel = UILabel()
    var wordTitleLabel = UILabel()
    var wordSubTitleLabel = UILabel()
    var weeklyReportTableView = UITableView()

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
            $0.font = .title2()
            $0.textColor = .cooingBrown
        }
        
        wordSubTitleLabel.do {
            $0.font = .body3()
            $0.textColor = .cooingBrown
        }
        
        weeklyReportTableView.do {
            $0.separatorStyle = .none
            $0.showsVerticalScrollIndicator = false
        }
    }
    
    override func hieararchy() {
        self.addSubViews(titleLabel,
                         wordTitleLabel,
                         wordSubTitleLabel,
                         weeklyReportTableView)

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
        
        weeklyReportTableView.snp.makeConstraints {
            $0.top.equalTo(wordSubTitleLabel.snp.bottom).offset(23.adjusted)
            $0.leading.trailing.equalToSuperview().inset(30.adjusted)
            $0.bottom.equalToSuperview()
        }
    }
}
