//
//  IntroView.swift
//  COOING
//
//  Created by 박윤빈 on 2023/11/06.
//

import UIKit

import SnapKit
import Then

final class HomeView: BaseView {
    
    // MARK: - Properties

        
    // MARK: - UI Components
    
    var nextButton = UIButton()
    private let logoImageView = UIImageView(image: Image.cooingLogo)
    private var cooingInfoLabel = UILabel()
    private var dateLabel = UILabel()
    private var growingImageView = UIImageView(image: Image.growing)
    private let gradientLayer = CAGradientLayer()
    
    // MARK: - override Method
    
    override func layoutSubviews() {
        super.layoutSubviews()
            gradientLayer.frame = self.bounds
    }
    
    override func configureUI() {
        gradientLayer.do {
            let colors: [CGColor] = [UIColor(hex: "#FFECC7").cgColor,
                                     UIColor.white.cgColor]
            $0.colors = colors
            $0.type = .radial
            $0.startPoint = CGPoint(x: 0.5, y: 0.5)
            $0.endPoint = CGPoint(x: 1, y: 1)
        }
        cooingInfoLabel.do {
            $0.text = "박쿠잉, 태어난지 29개월 째"
            $0.font = .body1()
            $0.textColor = .cooingBrown
        }
        
        dateLabel.do {
            $0.text = "쿠잉이의\n말을 기록한지\n100일째"
            $0.numberOfLines = 3
            $0.textAlignment = .center
            $0.font = .title1()
            $0.textColor = .cooingBrown
        }
        
        nextButton.do {
            $0.addTitleAttribute(title: "오늘의 질문 기록하러 가기",
                                 titleColor: .cooingBrown,
                                 fontName: .title2())
            $0.setRoundBorder(borderColor: .cooingGray1,
                              borderWidth: 0.5,
                              cornerRadius: 20)
            $0.layer.masksToBounds = false
            $0.backgroundColor = .white
            $0.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
            $0.layer.shadowRadius = 1
            $0.layer.shadowOffset = CGSize(width: 1, height: 1)
        }
    }
    
    override func setLayout() {
        logoImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(56)
            $0.leading.equalToSuperview().inset(28)
        }
        
        cooingInfoLabel.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(86)
            $0.centerX.equalToSuperview()
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(cooingInfoLabel.snp.bottom).offset(19)
            $0.centerX.equalToSuperview()
        }
        
        growingImageView.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(23)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(164)
            $0.width.equalTo(158)
        }
        
        nextButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(51)
            $0.top.equalTo(growingImageView.snp.bottom).offset(41)
            $0.height.equalTo(56)
        }
    }
    
    override func hieararchy() {
        self.layer.insertSublayer(gradientLayer, at: 0)
        addSubViews(logoImageView,
                    cooingInfoLabel,
                    dateLabel,
                    growingImageView,
                    nextButton
                    )
    }

}
