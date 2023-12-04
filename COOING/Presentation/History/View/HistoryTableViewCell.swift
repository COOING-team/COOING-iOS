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
    
    func configureCell(data: HistoryData) {
        dateLabel.text = data.date
        rightView.wordLabel.text = data.text
    }
}


