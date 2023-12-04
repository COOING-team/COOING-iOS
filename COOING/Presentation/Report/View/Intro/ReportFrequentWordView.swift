//
//  ReportFrequentWordView.swift
//  COOING
//
//  Created by 박윤빈 on 2023/12/01.
//

import UIKit

import SnapKit
import Then

// MARK: - Home의 최상단 View

final class ReportFrequentWordView: BaseView {
    
    // MARK: - UI Components
    
    private let titleLabel = UILabel()
    private let subTitleLabel = UILabel()
    private lazy var totalStackView = UIStackView(arrangedSubviews: [titleLabel, subTitleLabel])

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
            $0.layer.cornerRadius = 10
            $0.backgroundColor = .white
        }

        titleLabel.do {
            $0.font = .button1()
            $0.textColor = .cooingBrown
            $0.text = "빈출 단어"
        }
        
        subTitleLabel.do {
            $0.font = .body6()
            $0.textColor = .cooingBrown.withAlphaComponent(0.7)
            $0.text = "Jiwoo가 자주 말한 단어예요."
        }
        
        totalStackView.do {
            $0.axis = .vertical
            $0.alignment = .leading
            $0.spacing = 7
        }
    }
    
    override func hieararchy() {
        self.addSubview(totalStackView)
    }
    
    override func setLayout() {
        totalStackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(28.adjusted)
            $0.leading.equalToSuperview().inset(12.adjusted)
        }
    }
}
