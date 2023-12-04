//
//  QuestionView.swift
//  COOING
//
//  Created by 박윤빈 on 2023/11/06.
//

import UIKit

import SnapKit
import Then

final class QuestionView: BaseView {
        
    // MARK: - UI Components
    
    private var countDayLabel = UILabel()
    private var dateLabel = UILabel()
    private let babyImageView = UIImageView(image: Image.baby)
    var questionLabel = UILabel()
    var nextButton = CooingButton()
    
    // MARK: - override Method
    
    override func configureUI() {
        countDayLabel.do {
            $0.text = "\(HomeViewController.cooingInfo.cooingDay)일 째의 기록"
            $0.font = .body1()
            $0.textColor = .cooingBrown
        }
        
        dateLabel.do {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy/MM/dd"
            let current_date_string = formatter.string(from: Date())
            $0.text = current_date_string
            $0.font = .body2()
            $0.textColor = .cooingBrown
        }
        questionLabel.do {
            $0.text = QuestionViewController.todayQuestion
            $0.font = .title3()
            $0.textColor = .cooingBrown
        }
        
        nextButton.do {
            $0.setTitle("답변 녹음하기", for: .normal)
        }
        
    }
    
    override func setLayout() {

        countDayLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(200)
            $0.centerX.equalToSuperview()
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(countDayLabel.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
        
        babyImageView.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(100)
            $0.centerX.equalToSuperview()
            $0.height.width.equalTo(118)
        }
        
        questionLabel.snp.makeConstraints {
            $0.top.equalTo(babyImageView.snp.bottom).offset(60)
            $0.centerX.equalToSuperview()
        }
        
        nextButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(186)
            $0.leading.trailing.equalToSuperview().inset(32)
        }
    }
    
    override func hieararchy() {
        addSubViews(countDayLabel,
                    dateLabel,
                    babyImageView,
                    questionLabel,
                    nextButton)
    }

}

