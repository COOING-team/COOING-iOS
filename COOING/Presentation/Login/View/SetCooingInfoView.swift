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

    var dateFormat: String = ""
        
    // MARK: - UI Components
    
    var nextButton = UIButton()
    private let logoImageView = UIImageView(image: Image.createBaby)
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
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let viewTapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissDatePicker))
                viewTapGesture.cancelsTouchesInView = false
                self.addGestureRecognizer(viewTapGesture)
    }
    
    override func configureUI() {
        
        nameLabel.do {
            $0.text = "이름"
            $0.font = .body1()
        }
        
        sexLabel.do {
            $0.text = "성별"
            $0.font = .body1()
            $0.textAlignment = .right
        }
        
        birthdayLabel.do {
            $0.text = "생년월일"
            $0.font = .body1()
            $0.textAlignment = .right

        }
        
        nameTextField.do {
            $0.backgroundColor = .cooingGray1
        }
        
        manButton.do {
            $0.setImage(Image.unselectedMan, for: .normal)
        }
        
        womanButton.do {
            $0.setImage(Image.unselectedWoman, for: .normal)
        }
        
        nextButton.do {
            $0.addTitleAttribute(title: "다음",
                                 titleColor: .white,
                                 fontName: .title2())
            $0.setRoundBorder(borderColor: .cooingGray1,
                              borderWidth: 0.5,
                              cornerRadius: 0)
            $0.layer.masksToBounds = false
            $0.backgroundColor = .cooingYellow

        }
    }
    
    override func setLayout() {
        logoImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(200)
            $0.centerX.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(110)
            $0.leading.equalToSuperview().offset(87)
        }
        
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(nameLabel)
            $0.leading.equalTo(nameLabel.snp.trailing).offset(55)

        }
        
        sexLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(29)
            $0.leading.equalToSuperview().offset(87)
        }
        
        manButton.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(29)
            $0.leading.equalTo(sexLabel.snp.trailing).offset(55)
        }
        
        womanButton.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(29)
            $0.leading.equalTo(manButton.snp.trailing).offset(20)
        }
        
        birthdayLabel.snp.makeConstraints {
            $0.top.equalTo(sexLabel.snp.bottom).offset(29)
            $0.leading.equalToSuperview().offset(87)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(birthdayLabel)
            $0.leading.equalTo(birthdayLabel.snp.trailing).offset(40)
        }
        
        datePicker.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(50)
        }
        nextButton.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.height.equalTo(80)
            $0.width.equalToSuperview()
        }
    }
    
    override func hieararchy() {
        addSubViews(logoImageView,
                    nameLabel,
                    sexLabel,
                    manButton,
                    womanButton,
                    birthdayLabel,
                    nameTextField,
                    dateLabel,
                    datePicker,
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
        
    @objc func dismissDatePicker() {
        datePicker.isHidden = true
        
        dateFormat(datePicker)
    }
    
    func dateFormat(_ sender: UIDatePicker) {
       let dateFormatter = DateFormatter()
       dateFormatter.dateFormat = "yyyy-MM-dd" // Adjusted date format
        dateFormat = dateFormatter.string(from: sender.date)
   }

    
}

