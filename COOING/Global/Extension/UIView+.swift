//
//  UIView+.swift
//  COOING
//
//  Created by 박윤빈 on 2023/11/05.
//

import UIKit

extension UIView {
    func addSubViews(_ views: UIView...) {
        views.forEach {
            self.addSubview($0)
        }
    }
}

