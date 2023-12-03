//
//  BaseView.swift
//  COOING
//
//  Created by 박윤빈 on 2023/11/05.
//

import UIKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        hieararchy()
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        self.backgroundColor = .white
        
    }
    
    func hieararchy() {
        //override Point
    }
    
    func setLayout() {
        // override Point
    }
}


