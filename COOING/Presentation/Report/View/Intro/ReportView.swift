//
//  ReportView.swift
//  COOING
//
//  Created by 박윤빈 on 2023/12/01.
//

import UIKit

import SnapKit
import Then

// MARK: - ReportViewController의 최상단 View

final class ReportView: BaseView {
    
    // MARK: - Properties
    
    var frequentWordHandler: (() -> (Void))?
    var secretNoteHandler: (() -> (Void))?
    var usingWordHandler: (() -> (Void))?
    
    // MARK: - UI Components
    
    private let titleLabel = UILabel()
    private let weekNoticeLabel = UILabel()
    private let cooingBirthLabel = UILabel()
    private let reportSummaryView = ReportSummaryView()
    private let frequentWordView = ReportFrequentWordView()
    private let usingWordView = ReportUsingWordView()
    private let secretNoteView = ReportSecretNoteView()
    private lazy var wordStackView = UIStackView(arrangedSubviews: [frequentWordView, usingWordView])

    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setViewGestureRecognizer()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions

    override func configureUI() {
        self.backgroundColor = .cooingGray2
        titleLabel.do {
            $0.text = "레포트"
            $0.font = .button1()
            $0.textColor = .cooingBrown2
        }
        
        weekNoticeLabel.do {
            $0.text = "7월 1째주 쿠잉이의 주간 레포트"
            $0.textColor = .cooingBrown
            $0.font = .title3()
        }
        
        cooingBirthLabel.do {
            $0.text = "박쿠잉, 태어난 지 29개월 째"
            $0.font = .body5()
            $0.textColor = .cooingBrown
        }
        
        wordStackView.do {
            $0.axis = .horizontal
            $0.spacing = 6.adjusted
            $0.alignment = .center
        }
    }
    
    override func hieararchy() {
        self.addSubViews(titleLabel,
                         weekNoticeLabel,
                         cooingBirthLabel,
                         reportSummaryView,
                         wordStackView,
                         secretNoteView)
    }
    
    override func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.centerX.equalToSuperview()
        }
        
        weekNoticeLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(35.adjusted)
            $0.centerX.equalToSuperview()
        }
        
        cooingBirthLabel.snp.makeConstraints {
            $0.top.equalTo(weekNoticeLabel.snp.bottom).offset(10.adjusted)
            $0.centerX.equalToSuperview()
        }
        
        reportSummaryView.snp.makeConstraints {
            $0.top.equalTo(cooingBirthLabel.snp.bottom).offset(25.adjusted)
            $0.leading.trailing.equalToSuperview().inset(29.adjusted)
            $0.height.equalTo(157.adjusted)
        }
        
        frequentWordView.snp.makeConstraints {
            $0.height.equalTo(105.adjusted)
            $0.width.equalTo(154.adjusted)
        }
        
        usingWordView.snp.makeConstraints {
            $0.height.equalTo(105.adjusted)
            $0.width.equalTo(154.adjusted)
        }
        
        wordStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(29.adjusted)
            $0.top.equalTo(reportSummaryView.snp.bottom).offset(11.adjusted)
        }
        
        secretNoteView.snp.makeConstraints {
            $0.top.equalTo(wordStackView.snp.bottom).offset(11.adjusted)
            $0.leading.trailing.equalToSuperview().inset(29.adjusted)
            $0.height.equalTo(94.adjusted)
        }
    }
    
    private func setViewGestureRecognizer() {
        let frequentWordViewTappedGesture = UITapGestureRecognizer(target: self, action: #selector(frequentViewDidTapped))
        frequentWordView.addGestureRecognizer(frequentWordViewTappedGesture)
        
        let secretNoteViewTappedGesture = UITapGestureRecognizer(target: self, action: #selector(secretNoteViewDidTapped))
        secretNoteView.addGestureRecognizer(secretNoteViewTappedGesture)
        
        let usingWordViewTappedGesture = UITapGestureRecognizer(target: self, action: #selector(usingWordViewDidTapped))
        usingWordView.addGestureRecognizer(usingWordViewTappedGesture)
    }
    
    @objc
    private func frequentViewDidTapped() {
        frequentWordHandler?()
    }
    
    @objc
    private func secretNoteViewDidTapped() {
        secretNoteHandler?()
    }
    
    @objc
    private func usingWordViewDidTapped() {
        usingWordHandler?()
    }
}
