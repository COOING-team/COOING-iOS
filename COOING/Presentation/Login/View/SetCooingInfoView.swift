//
//  SetCooingInfoView.swift
//  COOING
//
//  Created by 최지우 on 12/4/23.
//

import UIKit

import SnapKit
import Then

final class SetCooingInfoView: BaseView {
    
    // MARK: - Properties

        
    // MARK: - UI Components
    
    var nextButton = UIButton()
    private let logoImageView = UIImageView(image: Image.cooingLogo)
    private var nameLabel = UILabel()
    private var sexLabel = UILabel()
    private var birthdayLabel = UILabel()
    var nameTextField = UITextField()
    var manButton = UIButton()
    var womanButton = UIButton()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "2023 / 10 / 02"
        label.textAlignment = .center
        label.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dateLabelTapped))
        label.addGestureRecognizer(tapGesture)
        return label
    }()
    
    lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.preferredDatePickerStyle = .wheels
        picker.datePickerMode = .date
        picker.isHidden = true
        picker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        return picker
    }()


    
    // MARK: - override Method
    
    override func configureUI() {
        
        nameLabel.do {
            $0.text = "이름"
            $0.font = .body1()
        }
        
        sexLabel.do {
            $0.text = "이름"
            $0.font = .body1()
        }
        
        birthdayLabel.do {
            $0.text = "이름"
            $0.font = .body1()
        }
        
        nameTextField.do {
            $0.backgroundColor = .green
        }
        
        nextButton.do {
            $0.addTitleAttribute(title: "다음",
                                 titleColor: .cooingBrown,
                                 fontName: .title2())
            $0.setRoundBorder(borderColor: .cooingGray1,
                              borderWidth: 0.5,
                              cornerRadius: 20)
            $0.layer.masksToBounds = false
            $0.backgroundColor = .cooingYellow

        }
    }
    
    override func setLayout() {
        logoImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(56)
            $0.leading.equalToSuperview().inset(28)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(110)
            $0.leading.equalToSuperview().offset(87)
        }
        
        nameTextField.snp.makeConstraints {
            $0.leading.equalTo(nameLabel.snp.trailing).offset(10)

        }
        
        sexLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(29)
            $0.leading.equalToSuperview().offset(87)
        }
        
        birthdayLabel.snp.makeConstraints {
            $0.top.equalTo(sexLabel.snp.bottom).offset(29)
            $0.leading.equalToSuperview().offset(87)

        }
        
        nextButton.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.height.equalTo(74)
            $0.width.equalToSuperview()
        }
    }
    
    override func hieararchy() {
        addSubViews(logoImageView,
                    nameLabel,
                    sexLabel,
                    birthdayLabel,
                    nameTextField,
                    nextButton
                    )
    }
    
    
    @objc func dateLabelTapped() {
            datePicker.isHidden = false
        }
        
        @objc func dateChanged(_ sender: UIDatePicker) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy / MM / dd"
            dateLabel.text = dateFormatter.string(from: sender.date)
        }
        
        // Optional: Call this method when you want to dismiss the picker, e.g. by tapping a "Done" button
        func dismissDatePicker() {
            datePicker.isHidden = true
        }

}

