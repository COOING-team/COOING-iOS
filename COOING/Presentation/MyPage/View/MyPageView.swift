//
//  MyPageView.swift
//  COOING
//
//  Created by 최지우 on 12/9/23.
//

import UIKit

class MyPageView: BaseView {
    
    // MARK: - Properties
    let myPageServiceLabelList = MyPageLocalData.myPageServiceLabelList


        
    // MARK: - UI Components
    
    let backgroundView = UIView()
    let myCooingImageView = UIImageView(image: Image.myCooing)
    var monthLabel = UILabel()
    var nameLabel = UILabel()
    var myPageTableView = UITableView()
    

    
    // MARK: - override Method
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        register()
    }
    
    override func configureUI() {
        
        backgroundView.do {
            $0.backgroundColor = .cooingGray2
            $0.layer.cornerRadius = 35.0
        }
        
        monthLabel.do {
            $0.text = "태어난 지 29개월 째"
            $0.font = .body4()
        }
        
        nameLabel.do {
            $0.text = "박쿠잉"
            $0.font = .title1()
        }
        
        myPageTableView.do {
            $0.backgroundColor = .clear
            $0.separatorStyle = .none
        }

    }
    
    override func setLayout() {
        backgroundView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(30)
            $0.horizontalEdges.equalToSuperview().inset(34)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(90)
        }
        myCooingImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(50)
            $0.horizontalEdges.equalToSuperview().inset(115)
            $0.height.equalTo(90)
        }
        monthLabel.snp.makeConstraints {
            $0.top.equalTo(myCooingImageView.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
        }
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(monthLabel.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
        myPageTableView.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(83)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(150)
        }
    }
    
    override func hieararchy() {
        backgroundView.addSubViews(myCooingImageView,
                                   monthLabel,
                                   nameLabel,
                                   myPageTableView)
        addSubViews(backgroundView)
    }
    
    func register() {
        myPageTableView.register(MyPageServiceCell.self, forCellReuseIdentifier: MyPageServiceCell.identifier)
    }
    
    
    
}

