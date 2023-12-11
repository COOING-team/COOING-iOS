//
//  LevelReportView.swift
//  COOING
//
//  Created by 박윤빈 on 2023/12/03.
//

import UIKit

import SnapKit
import Then

final class LevelReportView: BaseView {
    
    // MARK: - Properties
    
    var backStackViewHandler: (() -> (Void))?
    var levelStackViewHandler: (() -> (Void))?
    
    // MARK: - UI Components
    
    private let footerView = UIView(frame: CGRect(x: 0,
                                                  y: 0,
                                                  width: UIScreen.main.bounds.width,
                                                  height: 150.adjusted))
    private let footerLabel = UILabel()
    private let backButton = UIButton()
    var dateLabel = UILabel()
    private let levelButton = UIButton()
    private let levelLabel = UILabel()
    private lazy var levelStackView = UIStackView(arrangedSubviews: [levelButton, levelLabel])
    private lazy var backStackView = UIStackView(arrangedSubviews: [backButton, dateLabel])
    var levelReportTableView = UITableView(frame: .zero, style: .insetGrouped)
    var levelPickerView = UIPickerView()
    
    // MARK: - init
    
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
        backButton.do {
            $0.setImage(Image.backGray, for: .normal)
            $0.addTarget(self, action: #selector(backStackViewDidTapped), for: .touchUpInside)
        }
        
        dateLabel.do {
            $0.text = "\(CurrentDate.month)월 \(CurrentDate.week)째주"
            $0.font = .title1()
            $0.textColor = .cooingBrown
        }
        
        levelButton.do {
            $0.setImage(Image.selectLevel, for: .normal)
        }
        
        levelLabel.do {
            $0.text = "1단계"
            $0.font = .body3()
            $0.textColor = .cooingBrown.withAlphaComponent(0.4)
        }
        
        backStackView.do {
            $0.axis = .horizontal
            $0.spacing = 4
            $0.alignment = .center
        }
        
        levelStackView.do {
            $0.axis = .horizontal
            $0.spacing = 5
            $0.alignment = .center
        }
        
        levelReportTableView.do {
            $0.separatorStyle = .none
            $0.backgroundColor = .white
            $0.tableFooterView = footerView
            $0.showsVerticalScrollIndicator = false
        }
        
        levelPickerView.do {
            $0.backgroundColor = .lightGray
            $0.isHidden = true
        }
        
        
        footerLabel.do {
            $0.text = "*의학적 근거가 아닌 참고용 자료로 사용해야 합니다.*"
            $0.font = .body4()
            $0.textColor = .cooingBrown2
        }
    }
    
    override func hieararchy() {
        self.addSubViews(backStackView, levelStackView, levelReportTableView, levelPickerView)
        footerView.addSubview(footerLabel)
    }
    
    override func setLayout() {
        backButton.snp.makeConstraints {
            $0.height.width.equalTo(24.adjusted)
        }
        backStackView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(32.adjusted)
            $0.height.equalTo(34.adjusted)
            $0.leading.equalToSuperview().inset(22.adjusted)
        }
        
        levelStackView.snp.makeConstraints {
            $0.top.equalTo(backStackView.snp.bottom).offset(20.adjusted)
            $0.trailing.equalToSuperview().inset(36.adjusted)
            $0.height.equalTo(18.adjusted)
        }
        
        levelReportTableView.snp.makeConstraints {
            $0.top.equalTo(levelStackView.snp.bottom).offset(20.adjusted)
            $0.leading.trailing.equalToSuperview().inset(25.adjusted)
            $0.bottom.equalToSuperview()
        }
        
        levelPickerView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(180.adjusted)
        }
        
        footerLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    private func setGestureRecognizer() {
        let backStackViewTappedGesture = UITapGestureRecognizer(target: self, action: #selector(backStackViewDidTapped))
        backStackView.addGestureRecognizer(backStackViewTappedGesture)
        
        let levelStackViewTappedGesture = UITapGestureRecognizer(target: self, action: #selector(levelStackViewDidTapped))
        levelStackView.addGestureRecognizer(levelStackViewTappedGesture)
    }
    
    @objc
    private func backStackViewDidTapped() {
        backStackViewHandler?()
    }
    
    @objc
    private func levelStackViewDidTapped() {
        levelStackViewHandler?()
    }
    
    func configureLevelButton(text: String) {
        levelLabel.text = text
    }
}
