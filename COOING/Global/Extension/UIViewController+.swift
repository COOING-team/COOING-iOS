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
    
//    @objc func dismissKeyboard() {
//       let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
//                                                                action: #selector(UIViewController.dismissKeyboardTouchOutside))
//       tap.cancelsTouchesInView = false
//       view.addGestureRecognizer(tap)
//    }
//    
//    @objc private func dismissKeyboardTouchOutside() {
//       view.endEditing(true)
//    }
    
    func addKeyboardNotifications(){
        // 키보드가 나타날 때 앱에게 알리는 메서드 추가
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification ,
                                               object: nil)
        // 키보드가 사라질 때 앱에게 알리는 메서드 추가
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillHide(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    func addKeyboardNotifications(view: UIView){
        // 키보드가 나타날 때 앱에게 알리는 메서드 추가
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification ,
                                               object: view)
        // 키보드가 사라질 때 앱에게 알리는 메서드 추가
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillHide(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: view)
    }

    // 노티피케이션을 제거하는 메서드
    func removeKeyboardNotifications(){
        // 키보드가 나타날 때 앱에게 알리는 메서드 제거
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillShowNotification ,
                                                  object: nil)
        // 키보드가 사라질 때 앱에게 알리는 메서드 제거
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillHideNotification,
                                                  object: nil)
    }
    
    func dismissKeyboardWhenTappedAround() {
        print(#function)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                 action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    //MARK: - Action Method
    
    @objc private func keyboardWillShow(_ notification: NSNotification){
        // 키보드의 높이만큼 화면을 올려준다.
        print("키보드 올라감")
        
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRectangle.height
        
        if let view = notification.object as? UIView{
            view.frame.origin.y -= keyboardHeight
        }
        self.view.frame.origin.y -= keyboardHeight
    }

    // 키보드가 사라졌다는 알림을 받으면 실행할 메서드
    @objc private func keyboardWillHide(_ notification: NSNotification){
        // 키보드의 높이만큼 화면을 내려준다.
        print("키보드 내려감")
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRectangle.height
        
        if let view = notification.object as? UIView{
            view.frame.origin.y += keyboardHeight
        }
        self.view.frame.origin.y += keyboardHeight
    }
    
    @objc func dismissKeyboard() {
        print(#function)
        self.view.endEditing(false)
        
    }
    
    func swipeRecognizer() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture(_:)))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
        
    }
    
    @objc func respondToSwipeGesture(_ gesture: UIGestureRecognizer){
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction{
            case UISwipeGestureRecognizer.Direction.right:
                // 스와이프 시, 원하는 기능 구현.
                self.navigationController?.popViewController(animated: true)
            default: break
            }
        }
    }
}
