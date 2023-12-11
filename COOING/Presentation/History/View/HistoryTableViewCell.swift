//
//  HistoryTableViewCell.swift
//  COOING
//
//  Created by 박윤빈 on 2023/12/03.
//

import UIKit

import SnapKit
import Then

struct HistoryData {
    let date: String
    let text: String
}

final class HistoryTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier = "HistoryTableViewCell"
    var handler: (() -> (Void))?
    
    // MARK: - UI Components
    
    private var dateLabel = UILabel()
    private var divideLineImageView = UIImageView(image: Image.divideLine)
    private var rightView = HistoryRightView()
    
    // MARK: - init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        configureUI()
        hieararchy()
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Functions
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//
//        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 7.0.adjusted,
//                                                                     left: 0.0,
//                                                                     bottom: 7.0.adjusted,
//                                                                     right: 0.0))
//    }
    
    private func configureUI() {
        dateLabel.do {
            $0.text = "12/1"
            $0.font = .body1()
            $0.textColor = .cooingBrown.withAlphaComponent(0.7)
        }
    }
    
    private func hieararchy() {
        self.contentView.addSubViews(dateLabel,
                                     divideLineImageView,
                                     rightView)
    }
    
    private func setLayout() {
        dateLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        
        divideLineImageView.snp.makeConstraints {
            $0.height.equalTo(40.adjusted)
            $0.width.equalTo(3.adjusted)
            $0.leading.equalTo(dateLabel.snp.trailing).offset(10.adjusted)
            $0.centerY.equalToSuperview()
        }
        
        rightView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(56.adjusted)
            $0.leading.equalTo(divideLineImageView.snp.trailing).offset(16.adjusted)
        }
    }
    
    private func isoToMonthDay(isoDate: String) -> String{
        // ISO 8601 형식의 날짜를 파싱하기 위한 DateFormatter
        let isoFormatter = DateFormatter()
        isoFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        isoFormatter.locale = Locale(identifier: "en_US_POSIX") // 중요: 고정된 날짜 형식을 처리하기 위한 로케일 설정
        isoFormatter.timeZone = TimeZone(secondsFromGMT: 0) // 시간대 설정

        // 문자열을 Date 객체로 변환
        if let date = isoFormatter.date(from: isoDate) {
            // 원하는 형식으로 날짜를 다시 변환하기 위한 DateFormatter
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "MM/dd"

            // 변환된 날짜 문자열
            let outputDateString = outputFormatter.string(from: date)
            return outputDateString
        } else {
            print("날짜 형식 변환 실패")
            return ""
        }
    }

    func configureCell(data: HistoryListDTO) {
        dateLabel.text = isoToMonthDay(isoDate: data.createAt)
        rightView.wordLabel.text = data.content
    }
}


