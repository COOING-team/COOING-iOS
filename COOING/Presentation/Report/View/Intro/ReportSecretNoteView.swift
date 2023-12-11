//
//  ReportSecretNoteView.swift
//  COOING
//
//  Created by 박윤빈 on 2023/12/01.
//

import UIKit

import SnapKit
import Then

// MARK: - Home의 최상단 View

final class ReportSecretNoteView: BaseView {
    
    // MARK: - UI Components
    
    var titleLabel = UILabel()
    var subTitleLabel = UILabel()
    private lazy var totalStackView = UIStackView(arrangedSubviews: [titleLabel, subTitleLabel])
    private let noteImageView = UIImageView(image: Image.reportImage)

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
        }
        
        subTitleLabel.do {
            $0.font = .body6()
            $0.textColor = .cooingBrown.withAlphaComponent(0.7)
        }
        
        totalStackView.do {
            $0.axis = .vertical
            $0.alignment = .leading
            $0.spacing = 7.adjusted
        }
    }
    
    override func hieararchy() {
        self.addSubViews(totalStackView, noteImageView)
    }
    
    override func setLayout() {
        totalStackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(28.adjusted)
            $0.leading.equalToSuperview().inset(12.adjusted)
        }
        
        noteImageView.snp.makeConstraints {
            $0.height.width.equalTo(69.adjusted)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20.adjusted)
        }
    }
}
