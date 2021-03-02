//
//  PinVC.swift
//  SMART_SB_APP_IOS
//
//  Created by 김남교 on 2021/01/31.
//

import UIKit
import Then
import Safetoken

class PinVC: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
    var minInputLength: UInt = 6
    var maxInputLength: UInt = 6 // 최대 입력 수
    var titleStr = ""
    var hint = "비밀번호를 입력해 주세요."
    var key = ""
    var isShowDots = true // Dots view hidden 여부
    
    var keypadType = ESKeypadTypeNumber
    
    
    var completeHandler: ((String, String) -> Void)? = nil
    var cancelHandler: (() -> Void)? = nil
    
    var parameter:[String:Any] = [:]
    
    let tc = SafetokenSimpleClient.sharedInstance()
    var error:NSError? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("PinVC viewDidLoad")
        
        setupView()
        setupKeypad()
        setupDotView()
    }
    
    //뷰 생성 끝나고
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        print("PinVC viewDidAppear")
    }
    
    private func setupView() {
        titleLabel.text = titleStr
        hintLabel.text = hint
        //stackView.isHidden = true
        
        for v in stackView.arrangedSubviews {
            v.isHidden=true
        }
        var count = 0
        for v in stackView.arrangedSubviews {
            if count == maxInputLength {
                break
            }
            v.isHidden=false
            count=count+1
        }
    }
    
    // MARK: - pin dot view
    private func setupDotView() {
        stackView.subviews.forEach {
            $0.backgroundColor = .lightGray
            $0.layer.cornerRadius = $0.frame.size.width / 2
        }
    }
    
    private func setupKeypad() {
        /*
         ESKeypadTypeQwerty, // 0
         ESKeypadTypeNumber, // 1
         ESKeypadTypeNumberLine // 2
         */
        
        let spec = ESKeypadSpec()
        
        //커스텀 키패드
        spec?.keypadType = self.keypadType //ESKeypadTypeNumericpad
        //최대 문자열
        spec?.maxInputLength = maxInputLength
        spec?.lastCharDisplayTime = 0.5
        spec?.magnifierViewEnabled = true
        
        if "" == key {
            Log.print("seed 암호화")
            spec?.setEncryptMethod(e_ESKeypadEncryptMethodSeed, withKey: "seed")
        }else{
            Log.print("RSA 암호화")
            spec?.setEncryptMethod(e_ESKeypadEncryptMethodRSA, withKey: key)
        }
        
        // textField
        let passwordTextField = ESSecureTextField(frame: view.bounds, spec: spec)
        passwordTextField?.borderStyle = .roundedRect
        if "" == key {
            passwordTextField?.encryptMethod = "SEED"   // 암호화 방식 설정 e_ESKeypadEncryptMethodRSA
            passwordTextField?.encryptKeyValue = "sad"  // 암호화 키 설정
        }
        else{
            passwordTextField?.encryptMethod = "RSA"   // 암호화 방식 설정 e_ESKeypadEncryptMethodRSA
            passwordTextField?.encryptKeyValue = self.key as NSString // 암호화 키 설정
        }
        passwordTextField?.isHidden = true
        passwordTextField?.placeholder = hint
        passwordTextField?.secureTextFieldDelegate = self
        view.addSubview(passwordTextField!)
        passwordTextField?.becomeFirstResponder()
        
        if !isShowDots {
            passwordTextField?.translatesAutoresizingMaskIntoConstraints = false
            passwordTextField?.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
            passwordTextField?.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
            passwordTextField?.heightAnchor.constraint(equalToConstant: 40).isActive = true
            passwordTextField?.topAnchor.constraint(equalTo: stackView.topAnchor).isActive = true

        }
    }
    
    // MARK: - 토큰 저장
    private func storeSave(pin: String, encData: String) {
        guard let token = parameter["token"] else {
            UIApplication.shared.showAlert(message: "서버로부터 토큰을 받지 못하였습니다.\n다시 시도해 주세요.", confirmHandler: {
                self.dismiss(animated: true, completion: nil)
            })
            return
        }
        
        try? tc?.storeToken(withEncodedMessage: token as! String, pin: pin)
        
        guard error == nil else {
            UIApplication.shared.showAlert(message: "PIN등록에 실패하였습니다.\n다시 시도해 주세요.", confirmHandler: {
                self.dismiss(animated: true, completion: nil)
            })
            return
        }
        
        self.dismiss(animated: true, completion: {
            self.completeHandler?(pin, encData)
        })
    }
    
    // MARK: - 서명
    private func signIn(pin: String, encData: String) {
        guard let rnd = parameter["rnd"] else {
            UIApplication.shared.showAlert(message: "서버로부터 랜덤ID를 받지 못하였습니다.\n다시 시도해 주세요.", confirmHandler: {
                self.dismiss(animated: true, completion: nil)
            })
            return
        }
        
        var auth_msg = ""
        if let msg = parameter["AUTH_MESG"] {
            auth_msg = msg as! String
        }
        
        let tnp = try? tc?.sign(withMessage: auth_msg, rnd: rnd as! String, pin: pin)
        guard let sign_data = tnp?.encodedMessage else {
            UIApplication.shared.showAlert(message: "서명에러\n다시 시도해 주세요.")
            return
        }
        self.dismiss(animated: true, completion: {
            self.completeHandler?(pin, sign_data)
        })
    }
    
    @IBAction func pressCloseBtn(_ sender: Any) {
        dismiss(animated: true, completion: {
                    self.cancelHandler?()
        })
    }
    
    
    deinit {
        print("*** PinVC deinit ***")
    }
}



// MARK: - Password TextField Delegate
extension PinVC: ESSecureTextFieldDelegate {
    func secureTextFieldDidBeginEditing(_ secureTextField: ESSecureTextField!) {
        guard let suggestedSize = secureTextField.keypadView()?.layoutManager.suggestedSize(forContainerSize: view.bounds.size) else { return }
        secureTextField.keypadView()?.frame = CGRect(x: 0, y: view.bounds.size.height - suggestedSize.height, width: suggestedSize.width, height: suggestedSize.height)
        view.addSubview(secureTextField.keypadView())
    }
    
    func secureTextFieldDidReturn(_ secureTextField: ESSecureTextField!) {
        
        guard secureTextField.enteredCharacters() >= minInputLength else {
            UIApplication.shared.showAlert(message: "\(minInputLength)자 이상 입력바랍니다.")
            return
        }
        //쿼티일때
        if self.keypadType == ESKeypadTypeQwerty {
            let pin = Function.AES256Encrypt(val: String(utf8String: secureTextField.getPlainText())!)
            Log.print("pinnum = "+pin)
            self.dismiss(animated: true, completion: {
                self.completeHandler?(" ", pin)
            })
        }
        
    }
    
    //취소 버튼입력시
    func secureTextFieldDidCancel(_ secureTextField: ESSecureTextField!) {
        dismiss(animated: true, completion: {
                    self.cancelHandler?()
        })
    }
    
    //  텍스트 변화시
    func secureTextFieldDidChangeText(_ secureTextField: ESSecureTextField!) {
        Log.print("*** secureTextField ***")
        Log.print("암호화 Data: \(secureTextField.encryptedData())")
        Log.print("암호화 String: \(secureTextField.encryptedString())")
        
        //도트 변경
        stackView.subviews.forEach { $0.backgroundColor = .lightGray }
        for i in 0..<secureTextField.enteredCharacters() {
            let index = Int(i)
            stackView.subviews[index].backgroundColor = .cyan
        }
        
        // pin max값 입력 시 완료
        if secureTextField.enteredCharacters() == maxInputLength {
            Log.print("*** secureTextField (최종값) ***")
            Log.print("암호화 Data: \(secureTextField.encryptedData())")
            Log.print("암호화 String: \(secureTextField.encryptedString())")
            //핀번호만 글자 입력 다되면 닫기
            if self.keypadType == ESKeypadTypeNumericpad {
                self.dismiss(animated: true, completion: {
                        if self.key == "" {
                            let pin = Function.AES256Encrypt(val: String(utf8String: secureTextField.getPlainText())!)
                            Log.print("pinnum = "+pin)
                            self.completeHandler?(" ", pin)
                        }else{
                            self.completeHandler?(" ", secureTextField.encryptedString())
                        }
                })
            }
        }
    }
}
