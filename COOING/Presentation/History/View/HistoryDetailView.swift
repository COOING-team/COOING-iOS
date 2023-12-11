//
//  HistoryDetailView.swift
//  COOING
//
//  Created by 박윤빈 on 2023/12/09.
//

import AVFoundation
import UIKit

import SnapKit
import Then

final class HistoryDetailView: BaseView {
    
    // MARK: - Properties

        
    // MARK: - UI Components
    
    private var countDayLabel = UILabel()
    var dateLabel = UILabel()
    private var questionLabel = UILabel()
    
    private var transformView = UIView()
    private let answerImageView = UIImageView(image: Image.answer)
    private let answerTitleLabel = UILabel()
    var answerTextView = UITextView()
    
    private var answerView = UIView()
    var parentAnswerTextView = UITextView()
    
    var transformButton = CooingButton()
    private var scrollView = UIScrollView()
    private var contentView = UIView()
    
    // MARK: - override Method
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
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
            $0.text = "\(HomeViewController.cooingInfo.name)의 답변과 부모님의 코멘트 톺아보기"
            $0.font = .title3()
            $0.textColor = .cooingBrown
        }
        
        transformView.do {
            $0.backgroundColor = .d9Gray
            $0.layer.cornerRadius = 20.0
        }
      
        answerTitleLabel.do {
            $0.text = "\(HomeViewController.cooingInfo.name)의 답변"
            $0.font = .body2()
        }
        
        answerTextView.do {
            $0.text = "재미있는 일이 있는 하루였어.등등등\n쿠잉이가 한 답변이 여기에 텍스트로 들어갑니다."
            $0.font = .body4()
            $0.backgroundColor = UIColor.clear
            $0.textAlignment = .center
            $0.isEditable = false
        }
        
        transformButton.do {
            $0.setTitle("녹음 들어보기", for: .normal)
        }
        
        answerView.do {
            $0.backgroundColor = .d9Gray
            $0.layer.cornerRadius = 20.0
        }
        
        parentAnswerTextView.do {
            $0.text = "부모님이 코멘트를 입력 해 주세요"
            $0.font = .body4()
            $0.backgroundColor = .clear
            $0.textAlignment = .center
            $0.isEditable = false
        }
    }
    
    override func setLayout() {

        countDayLabel.snp.makeConstraints {
//            $0.top.equalToSuperview().inset(170.adjusted)
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(countDayLabel.snp.bottom).inset(2.adjusted)
            $0.centerX.equalToSuperview()
        }
        
        questionLabel.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(38.adjusted)
            $0.centerX.equalToSuperview()
        }
        
        transformView.snp.makeConstraints {
            $0.top.equalTo(questionLabel.snp.bottom).offset(32.adjusted)
            $0.horizontalEdges.equalToSuperview().inset(32.adjusted)
            $0.height.equalTo(236.adjusted)
        }
        
        answerImageView.snp.makeConstraints {
            $0.top.equalTo(transformView.snp.top).offset(25.adjusted)
            $0.centerX.equalTo(transformView)
        }
        
        answerTitleLabel.snp.makeConstraints {
            $0.top.equalTo(answerImageView.snp.bottom).offset(19.adjusted)
            $0.centerX.equalTo(transformView)
        }
        
        answerTextView.snp.makeConstraints {
            $0.top.equalTo(answerTitleLabel.snp.bottom).offset(39.adjusted)
            $0.centerX.equalTo(transformView)
            $0.horizontalEdges.equalTo(transformView).inset(35.adjusted)
            $0.bottom.equalTo(transformView)
        }
        
        transformButton.snp.makeConstraints {
            $0.top.equalTo(transformView.snp.bottom).offset(39.adjusted)
            $0.horizontalEdges.equalToSuperview().inset(32.adjusted)
            $0.height.equalTo(48.adjusted)
        }
        
        answerView.snp.makeConstraints {
            $0.top.equalTo(transformButton.snp.bottom).offset(32.adjusted)
            $0.leading.trailing.equalToSuperview().inset(32.adjusted)
            $0.height.equalTo(355.adjusted)
            $0.bottom.equalTo(contentView)
        }
        
        parentAnswerTextView.snp.makeConstraints {
            $0.edges.equalTo(answerView).inset(20.adjusted)
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalToSuperview()

        }
        
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func hieararchy() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubViews(countDayLabel,
                                dateLabel,
                                questionLabel,
                                transformView,
                                answerImageView,
                                answerTitleLabel,
                                answerTextView,
                                answerView,
                                parentAnswerTextView,
                                transformButton
        )
    }
    
    private func isoToDate(isoDate: String) -> String{
        // ISO 8601 형식의 날짜를 파싱하기 위한 DateFormatter
        let isoFormatter = DateFormatter()
        isoFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        isoFormatter.locale = Locale(identifier: "en_US_POSIX") // 중요: 고정된 날짜 형식을 처리하기 위한 로케일 설정
        isoFormatter.timeZone = TimeZone(secondsFromGMT: 0) // 시간대 설정

        // 문자열을 Date 객체로 변환
        if let date = isoFormatter.date(from: isoDate) {
            // 원하는 형식으로 날짜를 다시 변환하기 위한 DateFormatter
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "yyyy/MM/dd"

            // 변환된 날짜 문자열
            let outputDateString = outputFormatter.string(from: date)
            return outputDateString
        } else {
            print("날짜 형식 변환 실패")
            return ""
        }
    }
    
    func bindData(data: HistoryDetailDTO) {
        countDayLabel.text = "\(data.cooingDay)일 째의 기록"
        answerTextView.text = data.answerText
        if data.comment == "" {
            parentAnswerTextView.text = "해당 날짜에는 부모님의 코멘트가 없어요!"
        } else {
            parentAnswerTextView.text = data.comment
        }
        dateLabel.text = isoToDate(isoDate: data.createAt)
        questionLabel.text = data.content
    }
}
