//
//  LoginVC.swift
//  SMART_SB_IOS_APP
//
//  Created by 김남교 on 2021/03/17.
//

import UIKit
import Foundation
class LoginVC: UIViewController {
    
    var login_complete:((Dictionary<String,String>) -> Void)? = nil
    var login_failed:((String) -> Void)? = nil
    var login_params:[String:Any] = [:]
    
    var mode="0"
    
    let appDelegate  = UIApplication.shared.delegate as! AppDelegate
    
    @IBAction func 닫기_btn(_ sender: Any) {
        self.dismiss(animated: true, completion: {
            self.login_failed!("9998")
        })
    }
    
    @IBOutlet weak var 생채인증_img: UIImageView!
    @IBOutlet weak var 생채인증_txt: UILabel!
    
    @IBOutlet weak var 간편비밀번호_img: UIImageView!
    @IBOutlet weak var 간편비밀번호_txt: UILabel!
    
    @IBOutlet weak var 패턴인증_img: UIImageView!
    @IBOutlet weak var 패턴인증_txt: UILabel!
    
    
    override func loadView() {
        super.loadView()
        Log.print("LoginVC loadView")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       // self.navigationController?.navigationBar.isHidden = true
        Log.print("LoginVC viewDidLoad")
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(mode01))
        생채인증_img.isUserInteractionEnabled = true
        생채인증_img.addGestureRecognizer(tapGestureRecognizer)
        생채인증_txt.isUserInteractionEnabled = true
        생채인증_txt.addGestureRecognizer(tapGestureRecognizer)
        

        let tapGestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(mode02))
        간편비밀번호_img.isUserInteractionEnabled = true
        간편비밀번호_img.addGestureRecognizer(tapGestureRecognizer2)
        간편비밀번호_txt.isUserInteractionEnabled = true
        간편비밀번호_txt.addGestureRecognizer(tapGestureRecognizer2)

        let tapGestureRecognizer3 = UITapGestureRecognizer(target: self, action: #selector(mode03))
        패턴인증_img.isUserInteractionEnabled = true
        패턴인증_img.addGestureRecognizer(tapGestureRecognizer3)
        패턴인증_txt.isUserInteractionEnabled = true
        패턴인증_txt.addGestureRecognizer(tapGestureRecognizer3)
        
        
        
        let tc = appDelegate.tc
        if !((tc?.getToken()!.bindPattern)!) {
            패턴인증_txt.textColor = UIColor.gray
        }
        if !((tc?.getToken()!.bindBiometric)!) {
            생채인증_txt.textColor = UIColor.gray
        }
        

    }
    //뷰 생성 끝나고
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        Log.print("LoginVC viewDidAppear")
        
        
        if mode == "1" {
            doRunPin(params: login_params)
        }else if mode == "2" {
            doRunBio(params: login_params)
        }else if mode == "3" {
            doRunPattren(params: login_params)
        }
        
    }
    
    @objc func mode01() {
        Log.print("mode01")
        doRunBio(params: login_params)
    }
    @objc func mode02() {
        Log.print("mode02")
        doRunPin(params: login_params)
    }
    @objc func mode03() {
        Log.print("mode03")
        doRunPattren(params: login_params)
    }
    
    
    func doRunPin(params:Dictionary<String, Any>){
        var resultData : Dictionary<String,String> = [String:String]()
        UIApplication
            .shared
            .PINView(title: "간편비밀번호",
                     sub_title: "보안키패드",
                     hint: "6자리 입력",
                     type: 1,
                     data: params,
                     completeHandler: {
                        pinStr, SignDataStr in
                        Log.print("completed Data: \(pinStr), \(SignDataStr)")
                        //토큰 저장
                        let tc=self.appDelegate.tc
                        let randomKey = params["RANDOM_KEY"] as! String
                        let authMesg = params["AUTH_MESG"] as! String
                        
                        if let tnp = try? tc?.sign(withMessage: authMesg,rnd: randomKey, pin: SignDataStr){
                            let custNo = UserDefaults.standard.string(forKey: "custNo")
                            resultData["CUST_NO"]=custNo
                            resultData["SIGN"] = tnp.encodedMessage
                            resultData["RANDOM_KEY"] = randomKey
                            resultData["AUTH_MESG"] = authMesg
                            
                            //로그인거래시 토큰검증
                            if randomKey==authMesg {
                                Eversafe.sharedInstance()?.getVerificationToken({
                                    result,token in
                                    /**
                                    *검증 토큰이 취득된 상태입니다. 토큰을 사용자 요청과 함께 서버로 전송하면 됩니다. * result: 토큰의 상태값을 나타내는 결과 상태값 입니다.
                                    * verificationToken: NSData형태로 전송되며 서버로 전송시 Base64Encoding을
                                    필요로 할 수 있습니다.
                                    */
                                    guard let base64Token = token?.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0)) else {
                                        Log.print("토큰검증실패")
                                        return
                                    }
                                    print("result : \(String(describing: result))")
                                    print("base64Token : \(base64Token)")
                                    
                                    Validation().tokenValidation(token: base64Token, custNo: custNo!) { (result,msg) in
                                        print("Validation result : \(result)")
                                        print("Validation msg : \(msg)")
                                        //콜백
                                        self.dismiss(animated: true, completion: {
                                            self.login_complete!(resultData)
                                        })
                                    }
                                }, timeout: 10000)
                            }else{
                                //콜백
                                self.dismiss(animated: true, completion: {
                                    self.login_complete!(resultData)
                                })
                            }
                            
                        }else{
//                            DataWebSend().resultWebSend(resultCd: "9990", dicParmas:resultData, resultFunc : sf ,webView: webView)
                            
                            //콜백
                            self.dismiss(animated: true, completion: {
                                self.login_failed!("9990")
                            })
                        }
                        
                     }, cancelHandler: {
                        Log.print("cancel")
//                        DataWebSend().resultWebSend(resultCd: "9998", dicParmas:resultData, resultFunc : sf ,webView: webView)
                        
                        //self.dismiss(animated: true, completion: {
                            self.login_failed!("9998")
                        //})
                     })
    }
    
    func doRunBio(params:Dictionary<String, Any>){
        
        let tc = appDelegate.tc
        if !((tc?.getToken()!.bindBiometric)!) {
            UIApplication.shared.showAlert(message: "생체인증이 등록되어있지 않습니다")
        }else {
        var resultData : Dictionary<String,String> = [String:String]()
        UIApplication
            .shared
            .BioView(title: "생체인증",
                     sub_title: "보안키패드",
                     hint: "지문 입력",
                     register:false,
                     data: params,
                     complete: {
                        pinStr in
                        Log.print("completed Data: \(pinStr)")
                        let custNo = UserDefaults.standard.string(forKey: "custNo")
                        resultData["CUST_NO"]=custNo
                        
                        let randomKey = params["RANDOM_KEY"] as! String
                        let authMesg = params["AUTH_MESG"] as! String
                        resultData["RANDOM_KEY"]=randomKey
                        resultData["AUTH_MESG"]=authMesg
                        resultData["SIGN"]=pinStr
                        //로그인거래시 토큰검증
                        if randomKey==authMesg {
                            Eversafe.sharedInstance()?.getVerificationToken({
                                result,token in
                                /**
                                *검증 토큰이 취득된 상태입니다. 토큰을 사용자 요청과 함께 서버로 전송하면 됩니다. * result: 토큰의 상태값을 나타내는 결과 상태값 입니다.
                                * verificationToken: NSData형태로 전송되며 서버로 전송시 Base64Encoding을
                                필요로 할 수 있습니다.
                                */
                                guard let base64Token = token?.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0)) else {
                                    Log.print("토큰검증실패")
                                    return
                                }
                                print("result : \(String(describing: result))")
                                print("base64Token : \(base64Token)")
                                
                                Validation().tokenValidation(token: base64Token, custNo: custNo!) { (result,msg) in
                                    print("Validation result : \(result)")
                                    print("Validation msg : \(msg)")
                                    //콜백
                                    self.dismiss(animated: true, completion: {
                                        self.login_complete!(resultData)
                                    })
                                }
                            }, timeout: 10000)
                        }else{
                            //콜백
                            self.dismiss(animated: true, completion: {
                                self.login_complete!(resultData)
                            })
                        }
                        
                     }, failed: {
                        errCd, cd,msg,count in
                        Log.print("failed :" + msg)
                        //콜백
                        UIApplication.shared.showAlert(message: msg)
                        //self.login_failed!(errCd)
                     })
        }
    }
    func doRunPattren(params:Dictionary<String, Any>){
        let tc = appDelegate.tc
        if !((tc?.getToken()!.bindPattern)!) {
            UIApplication.shared.showAlert(message: "패턴이 등록되어있지 않습니다")
        }else {
        var resultData : Dictionary<String,String> = [String:String]()
        UIApplication
            .shared
            .PattrunView(title: "간편 로그인",
                     sub_title: "로그인할 패턴을 입력해주세요.",
                     hint: "패턴을 그려주세요",
                     register:false,
                     data: params,
                     complete: {
                        SignDataStr in
                        Log.print("completed Data:  \(SignDataStr)")
                        let custNo = UserDefaults.standard.string(forKey: "custNo")
                        resultData["CUST_NO"]=custNo
                        
                        let randomKey = params["RANDOM_KEY"] as! String
                        let authMesg = params["AUTH_MESG"] as! String
                        resultData["RANDOM_KEY"]=randomKey
                        resultData["AUTH_MESG"]=authMesg
                        resultData["SIGN"]=SignDataStr
                        
                        //로그인거래시 토큰검증
                        if randomKey==authMesg {
                            Eversafe.sharedInstance()?.getVerificationToken({
                                result,token in
                                /**
                                *검증 토큰이 취득된 상태입니다. 토큰을 사용자 요청과 함께 서버로 전송하면 됩니다. * result: 토큰의 상태값을 나타내는 결과 상태값 입니다.
                                * verificationToken: NSData형태로 전송되며 서버로 전송시 Base64Encoding을
                                필요로 할 수 있습니다.
                                */
                                guard let base64Token = token?.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0)) else {
                                    Log.print("토큰검증실패")
                                    return
                                }
                                print("result : \(String(describing: result))")
                                print("base64Token : \(base64Token)")
                                
                                Validation().tokenValidation(token: base64Token, custNo: custNo!) { (result,msg) in
                                    print("Validation result : \(result)")
                                    print("Validation msg : \(msg)")
                                    //콜백
                                    self.dismiss(animated: true, completion: {
                                        self.login_complete!(resultData)
                                    })
                                }
                            }, timeout: 10000)
                        }else{
                            //콜백
                            self.dismiss(animated: true, completion: {
                                self.login_complete!(resultData)
                            })
                        }
                        
                     }, failed: {
                        errCd in
                        resultData["RANDOM_KEY"]=""
                        resultData["AUTH_MESG"]=""
                        resultData["SIGN"]=""
                        //콜백
                        self.login_failed!(errCd)
                     })
        }
    }
}
