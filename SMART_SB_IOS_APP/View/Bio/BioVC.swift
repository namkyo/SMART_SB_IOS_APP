//
//  BioVC.swift
//  SMART_SB_APP_IOS
//
//  Created by 최지수 on 2021/02/08.
//

import UIKit
import Safetoken

class BioVC: UIViewController {
    let tokenBioAuth = SafetokenBiometricAuth()
    
    var complete: ((String) -> Void)? = nil
    var failed: ((String,Int32 ,String, Int32) -> Void)? = nil
    var error:NSError? = nil
    
    var register = false
    var data:[String:String] = [:]
    
    let appDelegate  = UIApplication.shared.delegate as! AppDelegate
    var tc : SafetokenSimpleClient?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tc = appDelegate.tc!
        view.backgroundColor = .white
        
    
       // try? tc?.storeToken(withEncodedMessage: "token", pin: UserDefaults.standard.string(forKey: "PIN")!)
       // print("get token: \(tc?.getToken())")
        
        setupView()
    }
    
    //MARK: - Bio Alert
    func setupView() {
        let biometyType = tokenBioAuth.getBiometricType(&error)

        if biometyType == BiometryTypeNone {
            Log.print(message: "생체인증을 지원하지 않는 기기입니다.")
            self.dismiss(animated: true, completion: {
                self.failed!( "9998" , 101 ,"생체인증을 지원하지 않는 기기입니다." , 1)
            })
            return
        }
        
        guard let tokenRef = tc!.getToken() else {
            Log.print(message: "등록된 생체인증이 없습니다.")
            self.dismiss(animated: true, completion: {
                self.failed!("9999",200,"등록된 생체인증이 없습니다.", 1)
            })
            return
        }
        
        if register { // bio 등록
            guard let encryt = UserDefaults.standard.string(forKey: "PIN") else {
                Log.print(message: "PIN번호 error")
                self.dismiss(animated: true, completion: {
                    self.failed!("9999",200,"PIN번호를 확인해 주세요.", 1)
                })
                return
            }
            
            tokenBioAuth.storeCredential(withToken: tokenRef, tokenClient: tc as! SafetokenClientDelegate, credential: encryt, operationMessage: "인증서저장", onComplete: {
                
                    DispatchQueue.main.async {
                self.dismiss(animated: true, completion: {
                    self.complete?("success")
                })
                    }
            }) { (code, errMsg, count) in
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: {
                        self.failed!("9996",Int32(code), errMsg, count)
                    })
                }
            }
        } else { //bio 서명
            guard let rnd = data["RANDOM_KEY"] else {
                failed!("9998",200,"서버와의 통신이 원할하지 않습니다.\n다시 시도해 주세요.", 1)
                return
            }
            
            var auth_msg = ""
            if let msg = data["AUTH_MESG"] {
                auth_msg = msg
            }
            
            //let appDelegate  = UIApplication.shared.delegate as! AppDelegate
            
            tokenBioAuth.generateSign(withToken: tokenRef, tokenClient: tc as! SafetokenClientDelegate, rnd: rnd, msg: auth_msg, operationMessage: "전자서명", onComplete: { (tnp) in
                DispatchQueue.main.async {
                self.dismiss(animated: true, completion: {
                    self.complete?(tnp.encodedMessage!)
                })
                }
            }) { (code, errMsg, count) in
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: {
                        self.failed!("9996",Int32(code), errMsg, Int32(count))
                    })
                }
            }
        }
    }
    
    func fail(code: Int, msg: String, count: Int32) {
        self.dismiss(animated: true, completion: {
            if code == -10003 {
                self.failed!("9998",Int32(code),"생체인증을 실패했습니다.(\(count))/5",count)
            } else if code == -20002 {
                self.failed!("9998",Int32(code),"생체인증 시도횟수가 많아 시스템에 의해 사용이 중지된 상태입니다.",count)
            } else if code == -10002 {
                self.failed!("9998",Int32(code),"저장된 인증정보가 없습니다.",count)
            } else if code == -20005 {
                self.failed!("9998",Int32(code),"생체인증과 연동된 키체인 아이템이 존재하지 않습니다. 다시 등록해 주세요.",count)
            } else if code == -20006 {
                self.failed!("9998",Int32(code),"취소하였습니다.",count)
            } else {
                self.failed!("9998",Int32(code),"다시 시도해 주세요.", Int32(code))
            }
        })
    }
    
    deinit {
        print("*** deinit Bio Controller ***")
    }
}
