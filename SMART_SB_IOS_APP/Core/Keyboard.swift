//
//  Keyboard.swift
//  JTSB
//
//  Created by 최지수 on 06/05/2020.
//  Copyright © 2020 CJS. All rights reserved.
//

import Foundation
import UIKit

class Keyboard {
    static var shared = Keyboard()
    
    private var keyboardView: UIView?

    private var keyboardScrollView: UIScrollView?
    private var bottomConstraint: NSLayoutConstraint?
    
    ///This function only moves the content up when the keyboard appears.
    func addScrollingKeyboardObservers(with superView: UIView, scrollView: UIScrollView?) {
        addDismissObserver(with: superView)
        
        if let scroll = scrollView {
            keyboardScrollView = scroll
            
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(scrollingKeyboardWillShow),
                                                   name: UIResponder.keyboardWillShowNotification,
                                                   object: nil)
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(scrollingKeyboardWillHide),
                                                   name: UIResponder.keyboardWillHideNotification,
                                                   object: nil)
        }
    }
    
    ///This function reduces the screen size when the keyboard appears.
    func addChangingHeightKeyboardObservers(with superView: UIView, bottomConstraint: NSLayoutConstraint?) {
        addDismissObserver(with: superView)
        
        if bottomConstraint != nil {
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(changingHeightKeyboardWillShow),
                                                   name: UIResponder.keyboardWillShowNotification,
                                                   object: nil)
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(changingHeightKeyboardWillHide),
                                                   name: UIResponder.keyboardWillHideNotification,
                                                   object: nil)
        }
    }
    
    private func addDismissObserver(with view: UIView) {
        keyboardView = view
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        keyboardView?.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        keyboardView?.endEditing(true)
    }
    
    @objc private func scrollingKeyboardWillShow(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            if let keyboardSize: CGSize =  (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size {
                keyboardScrollView?.contentInset.bottom = keyboardSize.height
            }
        }
    }
    
    @objc private func scrollingKeyboardWillHide(notification: NSNotification) {
        if notification.userInfo != nil {
            keyboardScrollView?.contentInset.bottom = 0
        }
    }
    
    @objc private func changingHeightKeyboardWillShow(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            if let keyboardSize: CGSize =  (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size {
                if let bottomConstraint = bottomConstraint, bottomConstraint.constant == 0 {
                    self.bottomConstraint!.constant += keyboardSize.height
                    
                    UIView.animate(withDuration: 1, animations: {
                        self.keyboardView?.layoutIfNeeded()
                    })
                }
            }
        }
    }
    
    @objc private func changingHeightKeyboardWillHide(notification: NSNotification) {
        if ((notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            if let bottomConstraint = bottomConstraint, bottomConstraint.constant != 0 {
                self.bottomConstraint!.constant = 0
                
                UIView.animate(withDuration: 1, animations: {
                    self.keyboardView?.layoutIfNeeded()
                })
            }
        }
    }
}

