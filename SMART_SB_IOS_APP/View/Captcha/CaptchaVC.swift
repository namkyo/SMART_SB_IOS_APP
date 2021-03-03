//
//  CaptchaVC.swift
//  JTSB
//
//  Created by 최지수 on 06/05/2020.
//  Copyright © 2020 CJS. All rights reserved.
//

import UIKit

class CaptchaVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var captchaImage: UIImageView!
    @IBOutlet weak var inputString: UITextField!
    
    var image: String?
    var completeHandler:(([String:String]) -> Void)? = nil
    var refreshHandler:(() -> Void)? = nil
    var cancelHander:(() -> Void)? = nil
    
    var serverData:[String:Any] = [:]
    var data:[String:String] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Keyboard.shared.addScrollingKeyboardObservers(with: view, scrollView: scrollView)
        setupView()
    }
    
    func setupView() {
        let color = #colorLiteral(red: 0.7058823529, green: 0.03921568627, blue: 0.03921568627, alpha: 1)
        inputString.attributedPlaceholder = NSAttributedString(string: "보안문자를 입력해주세요.", attributes: [NSAttributedString.Key.foregroundColor: color])
        inputString.textAlignment = .center
        inputString.layer.borderWidth = 1.0
        inputString.layer.borderColor = #colorLiteral(red: 0.02745098039, green: 0.1803921569, blue: 0.368627451, alpha: 1)
        
        // TextField 툴바
        let toolbarKeyboard = UIToolbar()
        toolbarKeyboard.sizeToFit()
        let btnDoneBar = UIBarButtonItem(title: "확인", style: .done, target: self, action: #selector(endEdit))
        
        toolbarKeyboard.tintColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbarKeyboard.items = [flexible, btnDoneBar]
//        toolbarKeyboard.setItems([flexible, btnDoneBar], animated: false)
        inputString.inputAccessoryView = toolbarKeyboard
        
        if let image64 = image {
            if let dataDecoded = Data(base64Encoded: image64, options: Data.Base64DecodingOptions(rawValue: 0)) {
                let decodedimage = UIImage(data: dataDecoded)
                captchaImage.image = decodedimage
            }
        }
    }
    
    @objc func endEdit() {
        self.view.endEditing(true)
    }
    
    @IBAction func pressRefreshButton(_ sender: Any) {
        self.dismiss(animated: true, completion: {
            self.refreshHandler?()
        })
    }
    
    @IBAction func pressClose(_ sender: Any) {
        self.dismiss(animated: true, completion: {
            self.cancelHander!()
        })
    }
    
    @IBAction func pressConfirm(_ sender: Any) {
        guard inputString.text!.count == 6 else {
            UIApplication.shared.showAlert(message: "보안문자 6자리를 입력해주세요.")
            return
        }
        
        self.dismiss(animated: true, completion: {
            let result = ["보안문자": self.inputString.text!]
            IndicatorView().loading(flag: "ON")
            self.completeHandler?(result)
        })
    }
}

extension CaptchaVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}
