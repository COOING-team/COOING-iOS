//
//  CommentView.swift
//  COOING
//
//  Created by 최지우 on 12/1/23.
//

import AVFoundation
import UIKit

import SnapKit
import Then

final class CommentView: BaseView {
    
    // MARK: - Properties

        
    // MARK: - UI Components
    
    private var countDayLabel = UILabel()
    private var dateLabel = UILabel()
    private var questionLabel = UILabel()
    
    private var transformView = UIView()
    var answerTextView = UITextView()
    
    let backButton = UIButton()
    let nextButton = UIButton()

    
    // MARK: - override Method
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setDelegate()
    }
    
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
            $0.text = "오늘 쿠잉이의 답변에 기록 남기기"
            $0.font = .title3()
            $0.textColor = .cooingBrown
        }
        
        transformView.do {
            $0.backgroundColor = .d9Gray
            $0.layer.cornerRadius = 20.0
        }
        
        answerTextView.do {
            $0.text = "부모님이 코멘트를 입력 해 주세요"
            $0.font = .body4()
            $0.backgroundColor = .clear
        }
        
        backButton.do {
            $0.setImage(Image.back, for: .normal)
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
        
        transformView.snp.makeConstraints {
            $0.top.equalTo(questionLabel.snp.bottom).offset(32)
            $0.horizontalEdges.equalToSuperview().inset(32)
            $0.height.equalTo(355)
        }
        
        answerTextView.snp.makeConstraints {
            $0.edges.equalTo(transformView).inset(20)
        }
        
        backButton.snp.makeConstraints {
            $0.top.equalTo(transformView.snp.bottom).offset(77)
            $0.leading.equalToSuperview().inset(22)
        }
        
        nextButton.snp.makeConstraints {
            $0.top.equalTo(transformView.snp.bottom).offset(77)
            $0.trailing.equalToSuperview().inset(22)
        }
    }
    
    override func hieararchy() {
        addSubViews(countDayLabel,
                    dateLabel,
                    questionLabel,
                    transformView,
                    answerTextView,
                    backButton,
                    nextButton
        )
    }
    
    func setDelegate() {
        answerTextView.delegate = self
    }

}


extension CommentView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
            if textView.text == "부모님이 코멘트를 입력 해 주세요" {
                textView.text = ""
                textView.textColor = .black
            }
        }

        func textViewDidEndEditing(_ textView: UITextView) {
            if textView.text.isEmpty {
                textView.text = "부모님이 코멘트를 입력 해 주세요"
                textView.textColor = .lightGray
            }
        }
}


