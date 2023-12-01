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
//    
//    private var countDayLabel = UILabel()
//    private var dateLabel = UILabel()
//    private var questionLabel = UILabel()
//    
//    private var transformView = UIView()
//    private let answerImageView = UIImageView(image: Image.answer)
//    let modifyButton = UIButton()
//    private let answerTitleLabel = UILabel()
//    private var answerTextView = UITextView()
//    
//    var transformButton = CooingButton()
//    let backButton = UIButton()
//    let nextButton = UIButton()
//
//    
//    // MARK: - override Method
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        
//        setDelegate()
//    }
//    
//    override func configureUI() {
//        countDayLabel.do {
//            $0.text = "100일 째의 기록"
//            $0.font = .body1()
//            $0.textColor = .cooingBrown
//        }
//        
//        dateLabel.do {
//            let formatter = DateFormatter()
//            formatter.dateFormat = "yyyy/MM/dd"
//            let current_date_string = formatter.string(from: Date())
//            $0.text = current_date_string
//            $0.font = .body2()
//            $0.textColor = .cooingBrown
//        }
//        
//        questionLabel.do {
//            $0.text = "오늘 쿠잉이의 하루는 어땠어?"
//            $0.font = .title3()
//            $0.textColor = .cooingBrown
//        }
//        
//        transformView.do {
//            $0.backgroundColor = .d9Gray
//            $0.layer.cornerRadius = 20.0
//        }
//        
//        modifyButton.do {
//            $0.setImage(Image.modify, for: .normal)
//        }
//        
//      
//        answerTitleLabel.do {
//            $0.text = "쿠잉이의 답변"
//            $0.font = .body2()
//        }
//        
//        answerTextView.do {
//            $0.text = "재미있는 일이 있는 하루였어.등등등\n쿠잉이가 한 답변이 여기에 텍스트로 들어갑니다."
//            $0.font = .body4()
//            $0.backgroundColor = .d9Gray
//        }
//        
//        transformButton.do {
//            $0.setTitle("음성 분석하기", for: .normal)
//        }
//        
//        backButton.do {
//            $0.setImage(Image.back, for: .normal)
//        }
//        
//        nextButton.do {
//            $0.setImage(Image.next, for: .normal)
//        }
//    }
//    
//    override func setLayout() {
//
//        countDayLabel.snp.makeConstraints {
//            $0.top.equalToSuperview().inset(170)
//            $0.centerX.equalToSuperview()
//        }
//        
//        dateLabel.snp.makeConstraints {
//            $0.top.equalTo(countDayLabel.snp.bottom).inset(2)
//            $0.centerX.equalToSuperview()
//        }
//        
//        questionLabel.snp.makeConstraints {
//            $0.top.equalTo(dateLabel.snp.bottom).offset(38)
//            $0.centerX.equalToSuperview()
//        }
//        
//        transformView.snp.makeConstraints {
//            $0.top.equalTo(questionLabel.snp.bottom).offset(32)
//            $0.horizontalEdges.equalToSuperview().inset(32)
//            $0.height.equalTo(236)
//        }
//        
//        answerImageView.snp.makeConstraints {
//            $0.top.equalTo(transformView.snp.top).offset(25)
//            $0.centerX.equalTo(transformView)
//        }
//        
//        modifyButton.snp.makeConstraints {
//            $0.top.equalTo(transformView.snp.top).offset(20)
//            $0.trailing.equalTo(transformView.snp.trailing).inset(10)
//        }
//        
//        answerTitleLabel.snp.makeConstraints {
//            $0.top.equalTo(answerImageView.snp.bottom).offset(19)
//            $0.centerX.equalTo(transformView)
//        }
//        
//        answerTextView.snp.makeConstraints {
//            $0.top.equalTo(answerTitleLabel.snp.bottom).offset(39)
//            $0.centerX.equalTo(transformView)
//            $0.horizontalEdges.equalTo(transformView).inset(35)
//            $0.bottom.equalTo(transformView)
//        }
//        
//        transformButton.snp.makeConstraints {
//            $0.top.equalTo(transformView.snp.bottom).offset(39)
//            $0.horizontalEdges.equalToSuperview().inset(32)
//            $0.height.equalTo(48)
//        }
//        
//        backButton.snp.makeConstraints {
//            $0.top.equalTo(transformButton.snp.bottom).offset(77)
//            $0.leading.equalToSuperview().inset(22)
//        }
//        
//        nextButton.snp.makeConstraints {
//            $0.top.equalTo(transformButton.snp.bottom).offset(77)
//            $0.trailing.equalToSuperview().inset(22)
//        }
//    }
//    
//    override func hieararchy() {
//        addSubViews(countDayLabel,
//                    dateLabel,
//                    questionLabel,
//                    transformView,
//                    answerImageView,
//                    modifyButton,
//                    answerTitleLabel,
//                    answerTextView,
//                    transformButton,
//                    backButton,
//                    nextButton
//        )
//    }
//    
//    func setDelegate() {
//        answerTextView.delegate = self
//    }
//
//}
//
//
//extension TransformRecordView: UITextViewDelegate {
//    func textViewDidBeginEditing(_ textView: UITextView) {
//            if textView.text == "재미있는 일이 있는 하루였어.등등등\n쿠잉이가 한 답변이 여기에 텍스트로 들어갑니다." {
//                textView.text = ""
//                textView.textColor = .black
//            }
//        }
//
//        func textViewDidEndEditing(_ textView: UITextView) {
//            if textView.text.isEmpty {
//                textView.text = "재미있는 일이 있는 하루였어.등등등\n쿠잉이가 한 답변이 여기에 텍스트로 들어갑니다."
//                textView.textColor = .lightGray
//            }
//        }
}


