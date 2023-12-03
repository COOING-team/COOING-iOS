//
//  SecretNoteTableViewCell.swift
//  COOING
//
//  Created by 박윤빈 on 2023/12/03.
//

import UIKit

import SnapKit
import Then

final class SecretNoteTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier = "SecretNoteTableViewCell"
    
    // MARK: - UI Components
    
    private let dateLabel = UILabel()
    private let reportImageView = UIImageView(image: Image.reportImage)
    private let goLabel = UILabel()
    private let nextImageView = UIImageView(image: Image.next)
    private lazy var nextStackView = UIStackView(arrangedSubviews: [reportImageView, goLabel, nextImageView])
    
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
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 7.0.adjusted,
                                                                     left: 0.0,
                                                                     bottom: 7.0.adjusted,
                                                                     right: 0.0))
    }
    
    private func configureUI() {
        contentView.do {
            $0.backgroundColor = .cooingGray2
            $0.layer.cornerRadius = 15
        }
        
        dateLabel.do {
            $0.text = "7월 1째주 레포트"
            $0.font = .report1()
            $0.textColor = .cooingBrown
        }
        
        goLabel.do {
            $0.text = "보러가기"
            $0.font = .report2()
            $0.textColor = .cooingBrown
        }
        
        nextStackView.do {
            $0.axis = .horizontal
            $0.spacing = 4.adjusted
            $0.alignment = .center
        }
    }
    
    private func hieararchy() {
        self.contentView.addSubViews(dateLabel, nextStackView)
    }
    
    private func setLayout() {
        dateLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12.adjusted)
            $0.leading.equalToSuperview().inset(15.adjusted)
        }
        
        reportImageView.snp.makeConstraints {
            $0.height.width.equalTo(36.adjusted)
        }
        
        nextImageView.snp.makeConstraints {
            $0.height.width.equalTo(14.adjusted)
        }
        
        nextStackView.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(10.adjusted)
            $0.trailing.equalToSuperview().inset(25.adjusted)
        }
    }
}

