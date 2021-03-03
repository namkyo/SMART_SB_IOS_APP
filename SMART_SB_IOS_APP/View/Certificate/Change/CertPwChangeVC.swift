//
//  CertPwChangeVC.swift
//  SMART_SB_APP_IOS
//
//  Created by 최지수 on 2021/02/15.
//

import UIKit

struct ESSecureTextFieldModel {
    let hint: String
    let superView: UIView
}

class CertPwChangeVC: UIViewController {

    var textFields:[UITextField] = []
    
    @IBOutlet weak var 현재_비밀번호BaseView: UIView!
    @IBOutlet weak var 새_비밀번호BaseView: UIView!
    @IBOutlet weak var 새_비밀번호_확인BaseView: UIView!
    
    var secureTextFields: [ESSecureTextField: ESSecureTextFieldModel] = [:]
    var 현재_비밀번호TextField: ESSecureTextField!
    var 새_비밀번호TextField: ESSecureTextField!
    var 새_비밀번호_확인TextField: ESSecureTextField!
    
    var minInputLength: UInt = 8
    var maxInputLength: UInt = 30
    
    var indexPath: IndexPath!
    var cert: Certificate!
    var certManager: CertManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupTextField()
    }
    
    private func setupUI() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate,
              let index = indexPath else {
            Log.print(message: "서버와의 통신이 원할하지 않습니다. 다시 시도해 주세요.")
            return
        }
        
        certManager = appDelegate.certManager
        cert = certManager.getCert(Int32(index.row))
    }
    
    private func setupTextField() {
        현재_비밀번호TextField = ESSecureTextField(frame: view.bounds, spec: setESKeypadSpec())
        새_비밀번호TextField = ESSecureTextField(frame: view.bounds, spec: setESKeypadSpec())
        새_비밀번호_확인TextField = ESSecureTextField(frame: view.bounds, spec: setESKeypadSpec())
        
        secureTextFields = [현재_비밀번호TextField: ESSecureTextFieldModel(hint: "현재 비밀번호 입력",
                                                                                 superView: 현재_비밀번호BaseView),
                            새_비밀번호TextField: ESSecureTextFieldModel(hint: "새 비밀번호 입력",
                                                                              superView: 새_비밀번호BaseView),
                            새_비밀번호_확인TextField: ESSecureTextFieldModel(hint: "새 비밀번호 입력 확인",
                                                                                     superView: 새_비밀번호_확인BaseView)]
        
        secureTextFields.forEach { textField, model in
            textField.placeholder = model.hint
            textField.borderStyle = .roundedRect
            textField.secureTextFieldDelegate = self
            textField.encryptKeyValue = "public key"
            model.superView.addSubview(textField)

            textField.translatesAutoresizingMaskIntoConstraints = false
            textField.topAnchor.constraint(equalTo: model.superView.topAnchor).isActive = true
            textField.leadingAnchor.constraint(equalTo: model.superView.leadingAnchor).isActive = true
            textField.trailingAnchor.constraint(equalTo: model.superView.trailingAnchor).isActive = true
            textField.bottomAnchor.constraint(equalTo: model.superView.bottomAnchor).isActive = true
        }
        
        현재_비밀번호TextField.becomeFirstResponder()
    }
    
    // ESKeypadSpec 생성
    private func setESKeypadSpec() -> ESKeypadSpec {
        let spec = ESKeypadSpec()
        spec?.keypadType = ESKeypadTypeQwerty
        spec?.maxInputLength = maxInputLength
        spec?.lastCharDisplayTime = 0.5
        return spec!
    }
    
    // validation
    private func passCheck() -> Bool {
        let t = String(cString: 현재_비밀번호TextField.getPlainText())
        guard !(checkPassword(index: Int32(indexPath.row), text: t) < 0) else {
            showAlert("비밀번호를 확인해 주세요.")
            return false
        }
        
//        guard 새_비밀번호TextField.enteredCharacters() > minInputLength else {
//
//            return false
//        }
        
//        guard 새_비밀번호_확인TextField.enteredCharacters() > minInputLength else { return false }
        guard String(cString: 새_비밀번호TextField.getPlainText()) == String(cString: 새_비밀번호_확인TextField.getPlainText()) else {
            UIApplication.shared.showAlert(message: "새 비밀번호가 서로 일치하지 않습니다.")
            return false
        }
        
        return true
    }
    
    private func showAlert(_ message: String) {
        UIApplication.shared.showAlert(message: message)
    }
    
    private func changePassword() {
//        guard let certItem = cert else { return }
        
        let oldPw = String(cString: 현재_비밀번호TextField.getPlainText())
        let newPw = String(cString: 새_비밀번호TextField.getPlainText())
        let newRet = checkPassword(index: Int32(indexPath.row), text: oldPw)
        
        var errStr = ""
        if newRet < 0 {
            switch  newRet {
            case KS_INVALID_PWD_SHORT_LENGTH:
                errStr = "비밀번호는 10자리 이상이어야 합니다."
                break;
            case KS_INVALID_PWD_NO_ALPHABET:
                errStr = "비밀번호에 영문이 포함되어야 합니다."
                break;
            case KS_INVALID_PWD_NO_NUMERIC:
                errStr = "비밀번호에 숫자가 포함되어야 합니다."
                break;
            case KS_INVALID_PWD_UNAVAILABLE_CHAR:
                errStr = "사용할 수 없는 문자가 포함되어 있습니다."
                break;
            case KS_INVALID_PWD_NO_SPECIAL_CHAR:
                errStr = "비밀번호에 특수문자가 포함되어야 합니다."
                break;
                
            // checkPasswordValidityEx 에서 추가됨
            case KS_INVALID_PWD_REPEATED_SAME_CHARS:
                errStr = "같은 글자가 4번 이상 반복되어 있습니다."
                break;
            case KS_INVALID_PWD_REPEATED_TWO_CHARS:
                errStr = "2개 글자가 3번 이상 반복되어 있습니다."
                break;
            case KS_INVALID_PWD_REPEATED_THREE_CHARS:
                errStr = "3개 글자가 2번 이상 반복되어 있습니다."
                break;
            case KS_INVALID_PWD_CONSECUTIVE_LETTERS:
                errStr = "연속되는 글자가 4개 이상 포함되어 있습니다."
            default:
                errStr = "무슨 에러인지..?"
                break;
            }
            
            UIApplication.shared.showAlert(message: errStr)
            return
        }
        
        
        
        
        if certManager.changeCertPassword(Int32(indexPath.row),
                                       oldPassword: oldPw,
                                       newPassword: newPw) {
            UIApplication.shared.showAlert(message: "인증서 암호 변경 성공", confirmHandler: {
                            self.dismiss(animated: true, completion: nil)
                        })
        } else {
            UIApplication.shared.showAlert(message: "인증서 암호 변경 실패(\(certManager.lastErrCode))")
        }
//
//        if certManager.changeCertPassword_S(Int32(indexPath.row), oldPassword: oldPw, newPassword: newPw) {
//            UIApplication.shared.showAlert(message: "인증서 암호 변경 성공", confirmHandler: {
//                self.dismiss(animated: true, completion: nil)
//            })
//        } else {
//            UIApplication.shared.showAlert(message: "인증서 암호 변경 실패(\(certManager.lastErrCode))")
//        }
    }
    
    // 비밀번호 체크
    func checkPassword(index: Int32, text: String) -> Int32 {
        let data = makeCString(from: text)
        let password = SecureData(data: data, length: UInt32(text.count))
        return checkPassword(index: index, password: password!)
    }
    
    // 비밀번호 체크
    private func checkPassword(index: Int32, password: ProtectedData) -> Int32 {
        let result = certManager.checkCertPassword_S(Int32(index), currentPassword: password as! SecureData)
        return result
    }
    
    // Convert UnsafeMutablePointer
    func makeCString(from str: String) -> UnsafeMutablePointer<UInt8> {
        var utf8 = Array(str.utf8)
        utf8.append(0)  // adds null character
        let count = utf8.count
        let result = UnsafeMutableBufferPointer<UInt8>.allocate(capacity: count)
        _ = result.initialize(from: utf8)
        return result.baseAddress!
    }
    
    @IBAction func press취소Button(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func press확인Button(_ sender: Any) {
        
//        print("현재 비밀번호  : \(현재_비밀번호TextField.encryptedString())")
//        print("Data        : \(현재_비밀번호TextField.encryptedData())")
//        print("Plain       : \(String(cString: 현재_비밀번호TextField.getPlainText()))")
//        print("새 비밀번호    : \(새_비밀번호TextField.encryptedString())")
//        print("Data        : \(새_비밀번호TextField.encryptedData())")
//        print("Plain       : \(String(cString: 새_비밀번호TextField.getPlainText()))")
//        print("새 비밀번호 확인: \(새_비밀번호_확인TextField.encryptedString())")
//        print("Data        : \(새_비밀번호_확인TextField.encryptedData())")
//        print("Plain       : \(String(cString: 새_비밀번호_확인TextField.getPlainText()))")
        guard passCheck() else { return }
        changePassword()
    }
}

extension CertPwChangeVC: ESSecureTextFieldDelegate {
    func secureTextFieldDidBeginEditing(_ secureTextField: ESSecureTextField!) {
        guard let suggestedSize = secureTextField.keypadView()?.layoutManager.suggestedSize(forContainerSize: view.bounds.size) else { return }
        secureTextField.keypadView()?.frame = CGRect(x: 0, y: view.bounds.size.height - suggestedSize.height + 120, width: suggestedSize.width, height: suggestedSize.height - 120)
        secureTextField.keypadView()?.tintColor = .blue
        view.addSubview(secureTextField.keypadView())
    }
}
