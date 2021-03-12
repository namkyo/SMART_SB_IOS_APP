//
//  CertSignVC.swift
//  SMART_SB_APP_IOS
//
//  Created by 최지수 on 2021/02/15.
//

import UIKit
import SwiftyJSON
enum CertSignType {
    case 서명
    case 스크래핑
}

protocol CertSignDelegate {
    func completedSign(type: CertSignType, result:[String:String])
}
class CertSignVC: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var hintLabel: UILabel!
    
    @IBOutlet weak var certTagView: UIView!
    @IBOutlet weak var certNameLabel: UILabel!
    @IBOutlet weak var certGubunLabel: UILabel!
    @IBOutlet weak var CertIssuerLabel: UILabel!
    @IBOutlet weak var certExdtLabel: UILabel!
    
    var passwordTextField: ESSecureTextField!
    @IBOutlet weak var keyboardBaseView: UIView!
    
    var indexPath: IndexPath!
    var index: Int32 = 0
    var mode = 1
    
    var certContent: Certificate!
    var certManager: CertManager!
    
    var parameters:[String:Any] = [:]
    
    var complete:((Dictionary<String,String>) -> Void)? = nil
    var failed:((String,String) -> Void)? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    //뷰 생성 끝나고
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        print("CertSignVC viewDidAppear : ")
        setupQwertyKeyboard()
    }
    
    private func setupUI() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate,
              let index = indexPath else {
            Log.print(message: "서버와의 통신이 원할하지 않습니다. 다시 시도해 주세요.")
            return
        }
        
        
        certNameLabel.text = certContent.getSubject()
        certGubunLabel.text = certContent.getPolicy() + "(" + certContent.getIssuerNameKorean() + ")"
        CertIssuerLabel.text = certContent.getIssuerNameKorean()
        certExdtLabel.text = certContent.getValidTo2()
        
        titleLabel.text = "인증서 비밀번호 입력"
        hintLabel.text = "인증서 비밀번호를 입력해 주세요."
        
        certTagView.layer.borderWidth = 1
        certTagView.layer.borderColor = UIColor.lightGray.cgColor
        certTagView.layer.cornerRadius = 7
    }
    
    private func setupQwertyKeyboard() {
        parameters["HINT"]="공동인증서 비밀번호"
        parameters["MAX"]="14"
        parameters["MIN"]="6"
        parameters["KEY"]=""
        var resultData : Dictionary<String,String> = [String:String]()
        UIApplication
            .shared
            .QwertyView(title: "공동인증서 비밀번호",
                     data: parameters,
                     isShowDots : false,
                     completeHandler: { [self]
                        pinStr, text in
                        Log.print("공동인증서 입력후...")
                        Log.print("공동인증서 비밀번호 enc Data: \(text)")
                        Log.print("공동인증서 입력실명 dec Data: \(self.parameters["rbrno"] as? String)!")
                        
                        //전자서명
                        if self.mode == 2 {
                            //주민번호 검증
                            if !checkRrn(index: self.index, text: text,rrn: "TCZrYbFvH9vBQTphRq9Akd==") {
                            //if !checkRrn(index: self.index, text: text,rrn: (self.parameters["rbrno"] as? String)!) {
                                self.dismiss(animated: true, completion: {
                                    self.failed?("9999,","이용자랑 인증서 실명번호가 일치하지 않습니다.")
                                })
                                return
                            }
                            
                            // 비밀번호 체크
                            if !self.checkPassword(index: self.index, text: text) {
                                self.dismiss(animated: true, completion: {
                                    self.failed?("9999,","비밀번호가 일치하지 않습니다.")
                                })
                                return
                            }
                            
                            
                            resultData=self.signCert(password: text)
                            Log.print("공동인증서 서명결과 Data: \(resultData)")
                        }
                        //스크랩핑
                        else if self.mode == 3
                        {
                            
                            // 비밀번호 체크
                            if !self.checkPassword(index: self.index, text: text) {
                                self.dismiss(animated: true, completion: {
                                    self.failed?("9999,","비밀번호가 일치하지 않습니다.")
                                })
                                return
                            }
                            
                            var minwon: JSON = JSON(self.parameters["MinWon_1"] as Any)
                            //주민번호 검증
//                            if !checkRrn(index: self.index, text: text,rrn: minwon["Input"]["주민등록번호"].string!) {
//                                self.dismiss(animated: true, completion: {
//                                    self.failed?("9999,","이용자랑 인증서 실명번호가 일치하지 않습니다.")
//                                })
//                                return
//                            }
                            
                            resultData["password"]=text
                            resultData["name"]=self.certContent?.getSubject()
                            resultData["validTo"]=self.certContent?.getValidTo2().replacingOccurrences(of: "-", with: "").replacingOccurrences(of: ".", with: "")
                        }
                        self.dismiss(animated: true, completion: {
                            self.complete?(resultData)
                        })
                            
                     }, cancelHandler: {
                        Log.print("cancel")
                        self.failed?("9999","인증서 비밀번호 입력을 취소했습니다.")
                     })
        
    }

    private func signCert(password : String) -> Dictionary<String,String>{
        var resultData : Dictionary<String,String> = [String:String]()
        guard let sign_data = parameters["signData"] else {
            resultData["msg"]="전자서명누락"
            return resultData}
        Log.print("전자서명")
        
        let signData = sign(index: index,
                            data: sign_data as! String,
                            password: password)
        Log.print("sign data string: \(signData)")
        
        let randomData = random(index: index,
                                password: password)
        Log.print("random data string: \(randomData)")
        
        Log.print(message: "서명 code")
        resultData["crtsNm"]=certContent.getSubjectName()
        resultData["crtsKeyInf"]=certContent.getPublicKeyString()
        resultData["crtsDn"]=certContent.getIssuerName()
        resultData["userCertDn"]=certContent.getSubject()
        resultData["esgnCtns"]=signData
        resultData["esgnMsgOrgnlCtns"]=parameters["signData"] as! String
        resultData["vidRandom"]=randomData
        return resultData
    }
    
    
    // 비밀번호 체크
    private func checkPassword(index: Int32, text: String) -> Bool {
        Log.print("checkPassword : "+Function.AES256Decrypt(val: text))
        let data = makeCString(from: Function.AES256Decrypt(val: text))
        let password = SecureData(data: data, length: UInt32(Function.AES256Decrypt(val: text).count))
        let result = certManager.checkCertPassword(Int32(index), currentPassword: Function.AES256Decrypt(val: text))
        return !(result < 0)
    }
    
    // 주민번호 체크 체크
    private func checkRrn(index: Int32, text: String,rrn : String) -> Bool {
        Log.print("주민번호 체크 : "+Function.AES256Decrypt(val: rrn))
        let data = makeCString(from: Function.AES256Decrypt(val: text))
        let password = SecureData(data: data, length: UInt32(Function.AES256Decrypt(val: text).count))
        let verify = certManager.selfUserVerify_S(Int32(index), idv: Function.AES256Decrypt(val: rrn), password: password!)
        if verify == 1 {
            return true
        } else{
            return false
        }
    }
    
    
    // Koscom Sign
    func sign(index: Int32, data: String, password: String) -> String? {
        // SignData
        let signUtil = KeySharpProviderUtil()
        return signUtil.koscomSign(index,
                                           password: Function.AES256Decrypt(val: password),
                                           sourceData: data,
                                           manager: certManager)
    }
    
    // Random Data
    func random(index: Int32, password: String) -> String? {
        // R 데이터 뽑기
        let signUtil = KeySharpProviderUtil()
        return signUtil.getRandom(index,
                                            password: Function.AES256Decrypt(val: password),
                                            manager: certManager)
    }
    
    // Convert UnsafeMutablePointer
    private func makeCString(from str: String) -> UnsafeMutablePointer<UInt8> {
        var utf8 = Array(str.utf8)
        utf8.append(0)  // adds null character
        let count = utf8.count
        let result = UnsafeMutableBufferPointer<UInt8>.allocate(capacity: count)
        _ = result.initialize(from: utf8)
        return result.baseAddress!
    }
    
    // 스크래핑
    private func scrapping() {
        
    }
    
    @IBAction func press취소Button(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func press확인Button(_ sender: Any) {
        //signCert()
        setupQwertyKeyboard()
    }
    
    @IBAction func pressClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension CertSignVC: ESSecureTextFieldDelegate {
    func secureTextFieldDidBeginEditing(_ secureTextField: ESSecureTextField!) {
        guard let suggestedSize = secureTextField.keypadView()?.layoutManager.suggestedSize(forContainerSize: view.bounds.size) else { return }
        secureTextField.keypadView()?.frame = CGRect(x: 0, y: view.bounds.size.height - suggestedSize.height + 120, width: suggestedSize.width, height: suggestedSize.height - 120)
        secureTextField.keypadView()?.tintColor = .blue
        view.addSubview(secureTextField.keypadView())
    }
}
