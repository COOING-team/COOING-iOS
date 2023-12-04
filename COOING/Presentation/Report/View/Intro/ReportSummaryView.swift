//
//  ReportSummaryView.swift
//  COOING
//
//  Created by 박윤빈 on 2023/12/01.
//

import UIKit

import SnapKit
import Then

final class ReportSummaryView: BaseView {

    // MARK: - UI Components
    
    private let wordLabel = UILabel()
    private let wordCountLabel = UILabel()
    private let favoriteWordLabel = UILabel()
    private let cooingFavoriteWordLabel = UILabel()
    private let characterImageView = UIImageView(image: Image.baby)
    private lazy var wordStackView = UIStackView(arrangedSubviews: [wordLabel,
                                                                    wordCountLabel])
    private lazy var favoriteWordStackView = UIStackView(arrangedSubviews: [favoriteWordLabel,
                                                                            cooingFavoriteWordLabel])
    private lazy var totalStackView = UIStackView(arrangedSubviews: [wordStackView, favoriteWordStackView])

    // MARK: - Functions

    override func configureUI() {
        self.do {
            $0.layer.cornerRadius = 10
            $0.backgroundColor = .white
        }
        
        wordLabel.do {
            $0.font = .body4()
            $0.textColor = .cooingBrown
            $0.text = "Jiwoo가 사용한 단어 수"
        }
        
        wordCountLabel.do {
            $0.font = .button1()
            $0.textColor = .cooingBrown
            $0.text = "46개"
        }
        
        favoriteWordLabel.do {
            $0.font = .body4()
            $0.textColor = .cooingBrown
            $0.text = "Jiwoo의 애착 단어"
        }
        
        cooingFavoriteWordLabel.do {
            $0.font = .button1()
            $0.textColor = .cooingBrown
            $0.text = "오늘"
        }
        
        wordStackView.do {
            $0.axis = .vertical
            $0.spacing = 8.adjusted
            $0.alignment = .center
        }
        
        favoriteWordStackView.do {
            $0.axis = .vertical
            $0.spacing = 8.adjusted
            $0.alignment = .center
        }
        
        totalStackView.do {
            $0.axis = .vertical
            $0.spacing = 10.adjusted
            $0.alignment = .center
        }
    }
    
    override func hieararchy() {
        self.addSubViews(totalStackView, characterImageView)
    }
    
    override func setLayout() {
        totalStackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(23.adjusted)
        }
        
        characterImageView.snp.makeConstraints {
            $0.height.width.equalTo(79.adjusted)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(45.adjusted)
        }
    }
    
    func configureSummaryView(data: ReportTotalDTO) {
        wordCountLabel.text = "\(data.totalWordNum) 개"
        cooingFavoriteWordLabel.text = "\(data.mostUseWord ?? "아직 없어요!")"
    }
}
