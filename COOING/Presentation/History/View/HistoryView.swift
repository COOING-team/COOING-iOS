//
//  HistoryView.swift
//  COOING
//
//  Created by 박윤빈 on 2023/12/03.
//

import UIKit

import SnapKit
import Then

final class HistoryView: BaseView {
    
    // MARK: - Properties
    
    var monthStackViewHandler: (() -> (Void))?
    
    // MARK: - UI Components
    
    private let titleLabel = UILabel()
    var historyTableView = UITableView()
    private let monthButton = UIButton()
    private let monthLabel = UILabel()
    private lazy var monthStackView = UIStackView(arrangedSubviews: [monthButton, monthLabel])
    var monthPickerView = UIPickerView()


    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setGestureRecognizer()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions

    override func configureUI() {
        titleLabel.do {
            $0.text = "이번 달\n\(HomeViewController.cooingInfo.name)의 답변 모아보기"
            $0.textAlignment = .left
            $0.font = .title2()
            $0.textColor = .cooingBrown
            $0.numberOfLines = 2
        }
        
        monthButton.do {
            $0.setImage(Image.selectLevel, for: .normal)
        }
        
        monthLabel.do {
            $0.text = "\(CurrentDate.year)년 \(CurrentDate.month)월"
            $0.font = .body3()
            $0.textColor = .cooingBrown.withAlphaComponent(0.7)
        }
        
        monthStackView.do {
            $0.axis = .horizontal
            $0.spacing = 5
            $0.alignment = .center
        }
        
        historyTableView.do {
            $0.separatorStyle = .none
            $0.showsVerticalScrollIndicator = false
        }
        
        monthPickerView.do {
            $0.backgroundColor = .lightGray
            $0.isHidden = true
        }
    }
    
    override func hieararchy() {
        self.addSubViews(titleLabel,
                         monthStackView,
                         historyTableView,
                         monthPickerView)
    }
    
    override func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.equalToSuperview().inset(36.adjusted)
        }
        
        monthButton.snp.makeConstraints {
            $0.height.width.equalTo(20.adjusted)
        }
        
        monthStackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(52.adjusted)
            $0.leading.equalTo(titleLabel)
        }
        
        historyTableView.snp.makeConstraints {
            $0.top.equalTo(monthStackView.snp.bottom).offset(11.adjusted)
            $0.leading.trailing.equalToSuperview().inset(25.adjusted)
            $0.bottom.equalToSuperview().inset(100.adjusted)
        }
        
        monthPickerView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(100.adjusted)
            $0.height.equalTo(180.adjusted)
        }
    }
    
    private func setGestureRecognizer() {
        let monthStackViewTappedGesture = UITapGestureRecognizer(target: self, action: #selector(monthStackViewDidTapped))
        monthStackView.addGestureRecognizer(monthStackViewTappedGesture)
    }
    
    @objc
    private func monthStackViewDidTapped() {
        monthStackViewHandler?()
    }
    
    func configureMonthButton(text: String) {
        monthLabel.text = text
    }
}
