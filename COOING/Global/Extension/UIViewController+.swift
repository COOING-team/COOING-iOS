//
//  UIViewController+.swift
//  COOING
//
//  Created by 최지우 on 12/1/23.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, text: String, style: UIAlertAction.Style, action: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)

        let confirmAction = UIAlertAction(title: "확인", style: style) { _ in
            action?()
        }
        alert.addAction(confirmAction)

        present(alert, animated: true)
    }
}
