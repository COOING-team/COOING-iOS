//
//  RecordView.swift
//  COOING
//
//  Created by 최지우 on 11/6/23.
//

import AVFoundation
import UIKit

import SnapKit
import Then

final class RecordView: BaseView {
    
    // MARK: - Properties

        
    // MARK: - UI Components
    
    private var countDayLabel = UILabel()
    private var dateLabel = UILabel()
    var recordButton = UIButton()
    private var questionLabel = UILabel()
    var reRecordButton = CooingButton()
    var listenButton = CooingButton()
    let nextButton = UIButton()

    
    // MARK: - override Method
    
    override func configureUI() {
        countDayLabel.do {
            $0.text = "100일 째의 기록"
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
            $0.text = "오늘 쿠잉이의 하루는 어땠어?"
            $0.font = .title3()
            $0.textColor = .cooingBrown
        }
        
        recordButton.do {
            $0.setImage(Image.recording, for: .normal)
            $0.sizeToFit()
        }
      
        reRecordButton.do {
            $0.setTitle("다시 녹음하기", for: .normal)
        }
        
        listenButton.do {
            $0.setTitle("녹음 들어보기", for: .normal)
        }
        
        nextButton.do {
            $0.setImage(Image.next, for: .normal)
        }
    }
    
    override func setLayout() {

        countDayLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(170)
            $0.centerX.equalToSuperview()
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(countDayLabel.snp.bottom).inset(2)
            $0.centerX.equalToSuperview()
        }
        
        questionLabel.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(38)
            $0.centerX.equalToSuperview()
        }
        
        recordButton.snp.makeConstraints {
            $0.top.equalTo(questionLabel.snp.bottom).offset(120)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(100)
        }
        
        reRecordButton.snp.makeConstraints {
            $0.top.equalTo(recordButton.snp.bottom).offset(118)
            $0.leading.equalToSuperview().offset(45)
            $0.width.equalTo(146)
        }
        
        listenButton.snp.makeConstraints {
            $0.top.equalTo(recordButton.snp.bottom).offset(118)
            $0.leading.equalTo(reRecordButton.snp.trailing).offset(8)
            $0.width.equalTo(146)
        }
        
        nextButton.snp.makeConstraints {
            $0.top.equalTo(reRecordButton.snp.bottom).offset(77)
            $0.trailing.equalToSuperview().inset(22)
        }
    }
    
    override func hieararchy() {
        addSubViews(countDayLabel,
                    dateLabel,
                    questionLabel,
                    recordButton,
                    reRecordButton,
                    listenButton,
                    nextButton)
    }

}


