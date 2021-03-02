//
//  CertImportVC.swift
//  SMART_SB_APP_IOS
//
//  Created by 최지수 on 2021/02/22.
//

import UIKit

class CertImportVC: UIViewController {

    
    @IBOutlet weak var generatedNumberView: UIView!
    
    @IBOutlet weak var generateNumberLabel: UILabel!
    
    var icrp: ICRProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        IndicatorView().loading(flag: "ON")
        
        setupUI()
        
    }
    
    private func setupUI() {
        generatedNumberView.layer.borderWidth = 2
        generatedNumberView.layer.borderColor = #colorLiteral(red: 0.9490196078, green: 0.5568627451, blue: 0.2039215686, alpha: 1)
    }
    
    //뷰 생성 끝나고
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        print("CertImportVC viewDidAppear : ")
        //대기시간
        sleep(1)
        setGeneratedNumber()
    }
    
    private func setGeneratedNumber() {
        icrp = ICRProtocol(ip: Constants.Cert.ICRS_IP, port: Constants.Cert.ICRS_PORT)
        
        guard let ret = icrp?.import1() else {
            showAlert()
            return
        }
        
        IndicatorView().loading(flag: "OFF")
        
        if ret < 0 {
            showAlert("error code: \(icrp?.lastErrorCode)\nerror messgae: \(icrp?.lastErrorMessage)")
        } else {
            guard let fullGeneratedNumber = icrp?.generatedNumber else {
                showAlert()
                return
            }
            
            let range1 = NSMakeRange(0, 4)
            let range2 = NSMakeRange(4, 4)
            let range3 = NSMakeRange(8, 4)
            
            let num1: String = (NSString(string: fullGeneratedNumber)).substring(with: range1)
            let num2: String = (NSString(string: fullGeneratedNumber)).substring(with: range2)
            let num3: String = (NSString(string: fullGeneratedNumber)).substring(with: range3)
            
            generateNumberLabel.text = num1 + " - " + num2 + " - " + num3
        }
    }
    
    private func saveCert() {
        guard let r2Ret = icrp?.import2(),
              let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            showAlert()
            return
        }
        
        let manager = appDelegate.certManager
        var cert:Certificate? = nil

        if r2Ret == 1 {
            Log.print(message: "인증서 받아오기 성공")
            guard let importedCert = icrp?.certData,
                  let importedKey = icrp?.keyData else {
                showAlert("인증서 받아오기 실패\nerror code: \(icrp?.lastErrorCode)\nerror messgae: \(icrp?.lastErrorMessage)")
                return
            }
            
            let bRet = manager.saveCert(toKeyChain: importedCert, key: importedKey)
            
            if !bRet {
                showAlert("인증서 저장 실패")
                return
            }
            
            if icrp?.kmCertData != nil && icrp?.kmKeyData != nil {
                if !manager.saveCert(toKeyChain: icrp?.kmCertData, key: icrp?.kmKeyData) {
                    showAlert("인증서 저장 실패")
                    return
                }
            }
            
            cert = Certificate(cert: importedCert)
            
            let msg = "인증서 DN: \(cert?.getSubject())\n" + "정책: \(cert?.getPolicy())\n"
            showAlert("인증서 저장 완료\n" + msg)
        } else {
            showAlert("인증서 받아오기 실패\nerror code: \(icrp?.lastErrorCode)\nerror messgae: \(icrp?.lastErrorMessage)")
        }
    }
    
    private func showAlert(_ message: String? = nil) {
        var msg = "서버와의 통신이 원할하지 않습니다. 다시 시도해 주세요."
        if let err = message {
            msg = err
        }
        UIApplication.shared.showAlert(message: msg)
    }
    
    @IBAction func press가져오기(_ sender: UIButton) {
        IndicatorView().loading(flag: "ON")
        saveCert()
        IndicatorView().loading(flag: "OFF")
    }
    
    @IBAction func pressClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
