//
//  Authorization.swift
//  SMART_SB_APP_IOS
//
//  Created by 김남교 on 2021/02/21.
//

import Foundation
import WebKit
import UIKit

class Authorization {
    //인증처리
    func doAuthorization(params:Dictionary<String, Any>,sf:String,ff:String,webView : WKWebView){
        let prcsDvcd    =   params["PRCS_DVCD"] as! String // T: 토큰등록(변경), R: 인증수단등록, P: 인증수행, M: mOTP등록
        let authType    =   params["AUTH_TYPE"] as! String// O: 최종등록타입, 1: 핀번호, 2: 지문, 3: 패턴, 등록순서 1->2->3
        let authToken   =   params["AUTH_TOKEN"] as! String
        let authMesg    =   params["AUTH_MESG"] as! String
        let randomKey   =   params["RANDOM_KEY"] as! String
        
        Function.DFT_TRACE_PRINT(output: "(prcsDvcd) -> ",prcsDvcd)
        Function.DFT_TRACE_PRINT(output: "(authType) -> ",authType)
        Function.DFT_TRACE_PRINT(output: "(authToken) -> ",authToken)
        Function.DFT_TRACE_PRINT(output: "(authMesg) -> ",authMesg)
        Function.DFT_TRACE_PRINT(output: "(randomKey) -> ",randomKey)
        
        switch prcsDvcd {
            case "T": // 최초토큰등록
                Log.print("최초토큰등록")
                
                    self.doRegisterPin1(params: params,sf:sf,ff:ff,webView:webView)
                
                break
            case "R": //R:토큰등록
                Log.print("토큰등록")
                if authType == "2" { // 생체인증 등록
                    doRegisterBio(params: params,sf:sf,ff:ff,webView:webView)
                } else if authType == "3" { // pattern 등록
                    doRegisterPattern(params: params,sf:sf,ff:ff,webView:webView)
                }
                break
            case "P": // P:인증수행
                doSimpleAuth(params: params,sf:sf,ff:ff,webView:webView)
                Log.print("인증수행")
                break
            case "M":   // M: MOTP 등록
                doRegisterMotp1(params: params,sf:sf,ff:ff,webView:webView)
                Log.print("MOTP 등록")
                break
            case "MP": // MP: MOTP 수행
                doRunMotp(params: params,sf:sf,ff:ff,webView:webView)
                Log.print("MOTP 수행")
                break
            case "MD": // MD: MOTP 제거
                doDeleteMotp(params: params,sf:sf,ff:ff,webView:webView)
                Log.print("MOTP 제거")
                break
            case "A":  // A: 스마트앱 등록
                doRegisterSmartApp1(params: params,sf:sf,ff:ff,webView:webView)
                Log.print("스마트앱 등록")
                break
            case "AP": // AP: 스마트앱 수행
                doRunSmartApp(params: params,sf:sf,ff:ff,webView:webView)
                Log.print("스마트앱 수행")
                break
            case "AD": // AD: 스마트앱 제거
                doDeleteSmartApp(params: params,sf:sf,ff:ff,webView:webView)
                Log.print("AD: 스마트앱 제거")
                break
            default:
                Log.print("누락")
                break
        }
    }
    func doDeleteSmartApp(params:Dictionary<String, Any>,sf:String,ff:String,webView : WKWebView){
        var resultData : Dictionary<String,Any> = [String:Any]()
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        //스마트앱 토큰
        let ac=appDelegate.oc
        if ac!.getTokenList()!.capacity > 0 {
            //스마트앱 기존토큰삭제
            try? ac?.getTokenList().map { try ac?.removeToken($0 as? SafetokenRef)}
            DataWebSend().resultWebSend(resultCd: "0000", dicParmas:resultData, resultFunc : sf ,webView: webView)
        }else{
            DataWebSend().resultWebSend(resultCd: "9990", dicParmas:resultData, resultFunc : sf ,webView: webView)
        }
    }
    func doDeleteMotp(params:Dictionary<String, Any>,sf:String,ff:String,webView : WKWebView){
        var resultData : Dictionary<String,Any> = [String:Any]()
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        //mOTP 토큰
        let oc=appDelegate.oc
        if oc!.getTokenList()!.capacity > 0 {
            //mOTP 기존토큰삭제
            try? oc?.getTokenList().map { try oc?.removeToken($0 as? SafetokenRef)}
            DataWebSend().resultWebSend(resultCd: "0000", dicParmas:resultData, resultFunc : sf ,webView: webView)
        }else{
            DataWebSend().resultWebSend(resultCd: "9990", dicParmas:resultData, resultFunc : sf ,webView: webView)
        }
    }
    
    func doRunSmartApp(params:Dictionary<String, Any>,sf:String,ff:String,webView : WKWebView){
        var resultData : Dictionary<String,Any> = [String:Any]()//기등록여부
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        if appDelegate.ac!.getTokenList()!.capacity < 1 {
            DataWebSend().resultWebSend(resultCd: "9990", dicParmas:resultData, resultFunc : sf ,webView: webView)
            return
        }
        UIApplication
            .shared
            .PINView(title: "스마트앱",
                     sub_title: "인증할 스마트앱 비밀번호을 입력해주세요.",
                     hint: "6자리 입력",
                     type: 1,
                     data: params,
                     completeHandler: {
                        pinStr, SignDataStr in
                        Log.print("completed Data: \(pinStr), \(SignDataStr)")
                        
                        //토큰 저장
                        let ac=appDelegate.ac
                        
                        let randomKey = params["RANDOM_KEY"] as! String
                        let authMesg = params["AUTH_MESG"] as! String
                        
                        if let tnp = try? ac?.sign(withToken: (ac?.getTokenList()[0] as! SafetokenRef),rnd: randomKey, pin: SignDataStr){
                            resultData["SIGN"] = tnp.encodedMessage
                            resultData["RANDOM_KEY"] = randomKey
                            resultData["AUTH_MESG"] = authMesg
                            resultData["CUST_NO"] = UserDefaults.standard.string(forKey: "custNo")
                            DataWebSend().resultWebSend(resultCd: "0000", dicParmas:resultData, resultFunc : sf ,webView: webView)
                        }else{
                            DataWebSend().resultWebSend(resultCd: "9990", dicParmas:resultData, resultFunc : sf ,webView: webView)
                        }
                        
                     }, cancelHandler: {
                        Log.print("cancel")
                        DataWebSend().resultWebSend(resultCd: "9998", dicParmas:resultData, resultFunc : sf ,webView: webView)
                     })
    }
    
    func doRunMotp(params:Dictionary<String, Any>,sf:String,ff:String,webView : WKWebView){var resultData : Dictionary<String,Any> = [String:Any]()
        //기등록여부
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        if appDelegate.oc!.getTokenList()!.capacity < 1 {
            DataWebSend().resultWebSend(resultCd: "9990", dicParmas:resultData, resultFunc : sf ,webView: webView)
            return
        }
        UIApplication
            .shared
            .PINView(title: "mOTP",
                     sub_title: "인증할 mOTP 비밀번호을 입력해주세요.",
                     hint: "6자리 입력",
                     type: 1,
                     data: params,
                     completeHandler: {
                        pinStr, SignDataStr in
                        Log.print("completed Data: \(pinStr), \(SignDataStr)")
                        
                        //토큰 저장
                        let oc=appDelegate.oc
                        
                        let randomKey = params["RANDOM_KEY"] as! String
                        let authMesg = params["AUTH_MESG"] as! String
                        
                        if let tnp = try? oc?.sign(withToken: (oc?.getTokenList()[0] as! SafetokenRef),rnd: randomKey, pin: SignDataStr){
                            resultData["SIGN"] = tnp.encodedMessage
                            resultData["RANDOM_KEY"] = randomKey
                            resultData["AUTH_MESG"] = authMesg
                            resultData["CUST_NO"] = UserDefaults.standard.string(forKey: "custNo")
                            DataWebSend().resultWebSend(resultCd: "0000", dicParmas:resultData, resultFunc : sf ,webView: webView)
                        }else{
                            DataWebSend().resultWebSend(resultCd: "9990", dicParmas:resultData, resultFunc : sf ,webView: webView)
                        }
                        
                     }, cancelHandler: {
                        Log.print("cancel")
                        DataWebSend().resultWebSend(resultCd: "9998", dicParmas:resultData, resultFunc : sf ,webView: webView)
                     })
    }
    
    
    func doRunPin(params:Dictionary<String, Any>,sf:String,ff:String,webView : WKWebView){
        var resultData : Dictionary<String,Any> = [String:Any]()
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
                        
                        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
                        //토큰 저장
                        let tc=appDelegate.tc
                        
                        let randomKey = params["RANDOM_KEY"] as! String
                        let authMesg = params["AUTH_MESG"] as! String
                        
                        if let tnp = try? tc?.sign(withMessage: authMesg,rnd: randomKey, pin: SignDataStr){
                            resultData["SIGN"] = tnp.encodedMessage
                            resultData["RANDOM_KEY"] = randomKey
                            resultData["AUTH_MESG"] = authMesg
                            let custNo = UserDefaults.standard.string(forKey: "custNo")
                            resultData["CUST_NO"]=custNo
                            
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
                                
                                guard ((appDelegate.tc?.getToken()?.uid) != nil) else {
                                    DataWebSend().resultWebSend(resultCd: "9990", dicParmas:resultData, resultFunc : sf ,webView: webView)
                                    return
                                }
                                
                                
                                print("result : \(String(describing: result))")
                                print("base64Token : \(base64Token)")
                                
                                Validation().tokenValidation(token: base64Token, custNo: custNo!) { (result,msg) in
                                    if result {
                                        DataWebSend().resultWebSend(resultCd: "0000", dicParmas:resultData, resultFunc : sf ,webView: webView)
                                    }
                                }
                            }, timeout: 10000)
                            
                            
                            
                        }else{
                            DataWebSend().resultWebSend(resultCd: "9990", dicParmas:resultData, resultFunc : sf ,webView: webView)
                        }
                        
                     }, cancelHandler: {
                        Log.print("cancel")
                        DataWebSend().resultWebSend(resultCd: "9998", dicParmas:resultData, resultFunc : sf ,webView: webView)
                     })
    }
    func doRunBio(params:Dictionary<String, Any>,sf:String,ff:String,webView : WKWebView){
        var resultData : Dictionary<String,Any> = [String:Any]()
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
                        
                        let randomKey = params["RANDOM_KEY"] as! String
                        let authMesg = params["AUTH_MESG"] as! String
                        resultData["RANDOM_KEY"]=randomKey
                        resultData["AUTH_MESG"]=authMesg
                        resultData["SIGN"]=pinStr
                        DataWebSend().resultWebSend(resultCd: "0000", dicParmas:resultData, resultFunc : sf ,webView: webView)
                        
                     }, failed: {
                        errCd, cd,msg,count in
                        Log.print("failed :" + msg)
                        DataWebSend().resultWebSend(resultCd: errCd, dicParmas:resultData, resultFunc : sf ,webView: webView)
                     })
    }
    func doRunPattren(params:Dictionary<String, Any>,sf:String,ff:String,webView : WKWebView){
        var resultData : Dictionary<String,Any> = [String:Any]()
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
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
                        
                        
                        let randomKey = params["RANDOM_KEY"] as! String
                        let authMesg = params["AUTH_MESG"] as! String
                        resultData["RANDOM_KEY"]=randomKey
                        resultData["AUTH_MESG"]=authMesg
                        resultData["SIGN"]=SignDataStr
                        
                        DataWebSend().resultWebSend(resultCd: "0000", dicParmas:resultData, resultFunc : sf ,webView: webView)
                     }, failed: {
                        errCd in
                        resultData["SIGN"]="asdasdasdasdas"
                        DataWebSend().resultWebSend(resultCd: errCd, dicParmas:resultData, resultFunc : sf ,webView: webView)
                     })
    }
    
    func doRegisterMotp1(params:Dictionary<String, Any>,sf:String,ff:String,webView : WKWebView){
        var resultData : Dictionary<String,Any> = [String:Any]()
        //기등록여부
//        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
//        if appDelegate.oc!.getTokenList()!.capacity > 0 {
//            DataWebSend().resultWebSend(resultCd: "9997", dicParmas:resultData, resultFunc : sf ,webView: webView)
//            return
//        }
        //키패드 생성
        UIApplication
            .shared
            .PINView(title: "mOTP",
                     sub_title: "등록할 mOTP 비밀번호을 입력해주세요.",
                     hint: "6자리 입력",
                     type: 1,
                     data: params,
                     completeHandler: {
                        pinStr, SignDataStr in
                        Log.print("completed Data: \(pinStr), \(SignDataStr)")
                        
                        
                        let cust_no = UserDefaults.standard.string(forKey: Configuration.CUST_NO)
                        Validation().checkPinValidation(encData: SignDataStr, custNo: cust_no!) {
                         (result, msg) in
                         Log.print("유효성검사 통과")
                             if result {
                                 DispatchQueue.main.async {
                                    self.doRegisterMotp2(params: params,sf:sf,ff:ff,webView:webView,pin:SignDataStr)
                                 }
                             }else{
                                 resultData["msg"]=msg
                                 DataWebSend().resultWebSend(resultCd: "9995", dicParmas:resultData, resultFunc : sf ,webView: webView)
                             }
                         }
                        
                     }, cancelHandler: {
                        Log.print("cancel")
                        DataWebSend().resultWebSend(resultCd: "9998", dicParmas:resultData, resultFunc : sf ,webView: webView)
                     })
    }
    func doRegisterMotp2(params:Dictionary<String, Any>,sf:String,ff:String,webView : WKWebView,pin:String){
        var resultData : Dictionary<String,Any> = [String:Any]()
        UIApplication
            .shared
            .PINView(title: "mOTP",
                     sub_title: "등록할 mOTP 비밀번호을 다시 입력해주세요.",
                     hint: "6자리 입력",
                     type: 1,
                     data: params,
                     completeHandler: {
                        pinStr, SignDataStr in
                        Log.print("completed Data: \(pinStr), \(SignDataStr)")
                        let pin2=SignDataStr
                        Log.print("pin : "+pin)
                        Log.print("pin2 : "+pin2)
                        if pin==pin2 {
                            let appDelegate  = UIApplication.shared.delegate as! AppDelegate
                            
                            let authToken = params["AUTH_TOKEN"] as! String
                            
                            //mOTP 토큰
                            let oc=appDelegate.oc
                            //mOTP 기존토큰삭제
                            try? oc?.getTokenList().map { try oc?.removeToken($0 as? SafetokenRef)}
                            //토큰 저장
                            try? oc?.storeToken(withEncodedMessage: authToken as! String, pin: pin)
                            
                            resultData["AUTH_TOKEN"]=authToken
                            DataWebSend().resultWebSend(resultCd: "0000", dicParmas:resultData, resultFunc : sf ,webView: webView)
                        }else{
                            //비밀번호 틀림
                            DataWebSend().resultWebSend(resultCd: "9996", dicParmas:resultData, resultFunc : sf ,webView: webView)
                        }
                     }, cancelHandler: {
                        Log.print("cancel")
                        DataWebSend().resultWebSend(resultCd: "9998", dicParmas:resultData, resultFunc : sf ,webView: webView)
                     })
    }
    func doRegisterSmartApp1(params:Dictionary<String, Any>,sf:String,ff:String,webView : WKWebView){
        var resultData : Dictionary<String,Any> = [String:Any]()
        //기등록여부
//        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
//        if appDelegate.ac!.getTokenList()!.capacity > 0 {
//            DataWebSend().resultWebSend(resultCd: "9997", dicParmas:resultData, resultFunc : sf ,webView: webView)
//            return
//        }
        //키패드 생성
        UIApplication
            .shared
            .PINView(title: "스마트앱",
                     sub_title: "등록할 스마트앱 비밀번호을 입력해주세요.",
                     hint: "6자리 입력",
                     type: 1,
                     data: params,
                     completeHandler: {
                        pinStr, SignDataStr in
                        Log.print("completed Data: \(pinStr), \(SignDataStr)")
                        
                        let cust_no = UserDefaults.standard.string(forKey: Configuration.CUST_NO)
                        Validation().checkPinValidation(encData: SignDataStr, custNo: cust_no!) {
                         (result, msg) in
                         Log.print("유효성검사 통과")
                             if result {
                                 DispatchQueue.main.async {
                                    self.doRegisterSmartApp2(params: params,sf:sf,ff:ff,webView:webView,pin:SignDataStr)
                                 }
                             }else{
                                 resultData["msg"]=msg
                                 DataWebSend().resultWebSend(resultCd: "9995", dicParmas:resultData, resultFunc : sf ,webView: webView)
                             }
                         }
                        
                        return
                     }, cancelHandler: {
                        Log.print("cancel")
                        DataWebSend().resultWebSend(resultCd: "9998", dicParmas:resultData, resultFunc : sf ,webView: webView)
                        return
                     })
    }
    func doRegisterSmartApp2(params:Dictionary<String, Any>,sf:String,ff:String,webView : WKWebView,pin:String){
        var resultData : Dictionary<String,Any> = [String:Any]()
        UIApplication
            .shared
            .PINView(title: "스마트앱",
                     sub_title: "등록할 스마트앱 비밀번호을 다시 입력해주세요.",
                     hint: "6자리 입력",
                     type: 1,
                     data: params,
                     completeHandler: {
                        pinStr, SignDataStr in
                        Log.print("completed Data: \(pinStr), \(SignDataStr)")
                        let pin2=SignDataStr
                        Log.print("pin : "+pin)
                        Log.print("pin2 : "+pin2)
                        if pin==pin2 {
                            let appDelegate  = UIApplication.shared.delegate as! AppDelegate
                            let authToken = params["AUTH_TOKEN"] as! String
                            //토큰
                            let ac=appDelegate.ac
                            //스마트앱 기존토큰삭제
                            try? ac?.getTokenList().map { try ac?.removeToken($0 as? SafetokenRef)}
                            //스마트앱 토큰저장
                            try? ac?.storeToken(withEncodedMessage: authToken as! String, pin: pin)
                            resultData["AUTH_TOKEN"]=authToken
                            DataWebSend().resultWebSend(resultCd: "0000", dicParmas:resultData, resultFunc : sf ,webView: webView)
                            return
                        }else{
                            //비밀번호 틀림
                            DataWebSend().resultWebSend(resultCd: "9996", dicParmas:resultData, resultFunc : sf ,webView: webView)
                            return
                        }
                     }, cancelHandler: {
                        Log.print("cancel")
                        DataWebSend().resultWebSend(resultCd: "9998", dicParmas:resultData, resultFunc : sf ,webView: webView)
                        return
                     })
    }
    
    func doSimpleAuth(params:Dictionary<String, Any>,sf:String,ff:String,webView : WKWebView){
        var resultData : Dictionary<String,Any> = [String:Any]()//기등록여부
        
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let tc=appDelegate.tc
        
        guard ((tc?.getToken()?.uid) != nil) else {
            DataWebSend().resultWebSend(resultCd: "9990", dicParmas:resultData, resultFunc : sf ,webView: webView)
            return
        }
        
        let authType = params["AUTH_TYPE"] as! String
        switch authType {
            case "0":
//                if ((tc?.getToken()?.bindPattern) != nil) {
//                    doRunPattren(params: params,sf:sf,ff:ff,webView:webView)
//                    return
//                }
//                if ((tc?.getToken()?.bindBiometric) != nil) {
//                    doRunBio(params: params,sf:sf,ff:ff,webView:webView)
//                    return
//                }
                //doRunPin(params: params,sf:sf,ff:ff,webView:webView)
                doLoginView(mode:"0",sf:sf,ff:ff,params: params,webView:webView)
                break
            case "1":
               // doRunPin(params: params,sf:sf,ff:ff,webView:webView)
                doLoginView(mode:"1",sf:sf,ff:ff,params: params,webView:webView)
                break
            case "2":
                //doRunBio(params: params,sf:sf,ff:ff,webView:webView)
                doLoginView(mode:"2",sf:sf,ff:ff,params: params,webView:webView)
                break
            case "3":
                //doRunPattren(params: params,sf:sf,ff:ff,webView:webView)
                doLoginView(mode:"3",sf:sf,ff:ff,params: params,webView:webView)
                break
            default:
                Log.print("잘못된 요청")
            }
        
    }
    
    func doLoginView(mode:String,sf:String,ff:String,params:Dictionary<String, Any>,webView : WKWebView){
        let resultData : Dictionary<String,String> = [String:String]()
        UIApplication
            .shared
            .LoginView(mode: mode,
                       params: params,
                        complete: {
                        result in
                            Log.print("succeces")
                            DataWebSend().resultWebSend(resultCd: "0000", dicParmas:result, resultFunc : sf ,webView: webView)
                        },
                        failed:  {
                        errCode in
                            Log.print("cancel")
                            DataWebSend().resultWebSend(resultCd: errCode, dicParmas:resultData, resultFunc : sf ,webView: webView)
                        })
    }
    
    func doRegisterPin1(params:Dictionary<String, Any>,sf:String,ff:String,webView : WKWebView){
        var resultData : Dictionary<String,Any> = [String:Any]()
        UIApplication
            .shared
            .PINView(title: "간편비밀번호",
                     sub_title: "등록할 간편비밀번호을 입력해주세요.",
                     hint: "6자리 입력",
                     type: 1,
                     data: params,
                     completeHandler: {
                        pinStr, SignDataStr in
                        Log.print("completed Data: \(pinStr), \(SignDataStr)")
                        
                        
                        if Constants.CHECK_VALIDATION {
                            // 유효성 검사 반환값
                            let cust_no = UserDefaults.standard.string(forKey: Configuration.CUST_NO)
                            
                            
                           Validation().checkPinValidation(encData: SignDataStr, custNo: cust_no!) {
                            (result, msg) in
                            Log.print("유효성검사 통과")
                                if result {
                                    DispatchQueue.main.async {
                                        self.doRegisterPin2(params: params,sf:sf,ff:ff,webView:webView,pin:SignDataStr)
                                    }
                                }else{
                                    resultData["msg"]=msg
                                    DataWebSend().resultWebSend(resultCd: "9995", dicParmas:resultData, resultFunc : sf ,webView: webView)
                                }
                            }
                        }else{
                            self.doRegisterPin2(params: params,sf:sf,ff:ff,webView:webView,pin:SignDataStr)
                        }
                        
                        //DataWebSend().resultWebSend(resultCd: "0000", dicParmas:resultData, resultFunc : sf ,webView: webView)
                        
                     }, cancelHandler: {
                        Log.print("cancel")
                        DataWebSend().resultWebSend(resultCd: "9998", dicParmas:resultData, resultFunc : sf ,webView: webView)
                     })
    }
    func doRegisterPin2(params:Dictionary<String, Any>,sf:String,ff:String,webView : WKWebView,pin:String){
        var resultData : Dictionary<String,Any> = [String:Any]()
        UIApplication
            .shared
            .PINView(title: "간편비밀번호",
                     sub_title: "등록할 간편비밀번호을 다시 입력해주세요.",
                     hint: "6자리 입력",
                     type: 1,
                     data: params,
                     completeHandler: {
                        pinStr, SignDataStr in
                        Log.print("completed Data: \(pinStr), \(SignDataStr)")
                        let pin2=SignDataStr
                        Log.print("pin : "+pin)
                        Log.print("pin2 : "+pin2)
                        if pin==pin2 {
                            let appDelegate  = UIApplication.shared.delegate as! AppDelegate
                            
                            let authToken = params["AUTH_TOKEN"] as! String
                            
                            //토큰 저장
                            let tc=appDelegate.tc
                            try? tc?.storeToken(withEncodedMessage: authToken as! String, pin: pin)
                            
                            UserDefaults.standard.set(pin2,forKey: "PIN")
                            
                            resultData["AUTH_TOKEN"]=authToken
                            DataWebSend().resultWebSend(resultCd: "0000", dicParmas:resultData, resultFunc : sf ,webView: webView)
                        }else{
                            //비밀번호 틀림
                            DataWebSend().resultWebSend(resultCd: "9996", dicParmas:resultData, resultFunc : sf ,webView: webView)
                        }
                        //DataWebSend().resultWebSend(resultCd: "0000", dicParmas:resultData, resultFunc : sf ,webView: webView)
                        
                     }, cancelHandler: {
                        // 취소
                        Log.print("cancel")
                        DataWebSend().resultWebSend(resultCd: "9998", dicParmas:resultData, resultFunc : sf ,webView: webView)
                     })
    }
    
    
    func doRegisterBio(params:Dictionary<String, Any>,sf:String,ff:String,webView : WKWebView){
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        var resultData : Dictionary<String,Any> = [String:Any]()
        UIApplication
            .shared
            .BioView(title: "생체인증",
                     sub_title: "보안키패드",
                     hint: "지문 입력",
                     register:true,
                     data: params,
                     complete: {
                        pinStr in
                        Log.print("completed Data: \(pinStr)")
                        let authToken = params["AUTH_TOKEN"] as! String
                        resultData["AUTH_TOKEN"]=authToken
                        DataWebSend().resultWebSend(resultCd: "0000", dicParmas:resultData, resultFunc : sf ,webView: webView)
                        
                     }, failed: {
                        errCd,code, errMsg, count in
                        Log.print("failed : code=\(code) ,errMsg=\(errMsg), count=\(count)")
                        resultData["code"]=code
                        resultData["errMsg"]=errMsg
                        resultData["count"]=count
                        let authToken = params["AUTH_TOKEN"] as! String
                        resultData["AUTH_TOKEN"]=authToken
                        DataWebSend().resultWebSend(resultCd: errCd, dicParmas:resultData, resultFunc : sf ,webView: webView)
                     })
    }
    func doRegisterPattern(params:Dictionary<String, Any>,sf:String,ff:String,webView : WKWebView){
        var resultData : Dictionary<String,Any> = [String:Any]()
        UIApplication
            .shared
            .PattrunView(title: "간편 로그인",
                     sub_title: "등록할 패턴을 입력해주세요.",
                     hint: "패턴을 그려주세요",
                     register:true,
                     data: params,
                     complete: {
                        SignDataStr in
                        Log.print("completed Data:  \(SignDataStr)")
                        let authToken = params["AUTH_TOKEN"] as! String
                        resultData["AUTH_TOKEN"]=authToken
                        DataWebSend().resultWebSend(resultCd: "0000", dicParmas:resultData, resultFunc : sf ,webView: webView)
                     }, failed: {
                        errcd in
                        Log.print("failed Data: \(errcd)")
                        DataWebSend().resultWebSend(resultCd: errcd, dicParmas:resultData, resultFunc : sf ,webView: webView)
                     })
        
    }
    
    private func createViewController(_ sbName: String) -> UIViewController {
        let sb = UIStoryboard(name: sbName, bundle: nil)
        return sb.instantiateViewController(withIdentifier: sbName + "VC")
    }
    
    // navigation push viewcontroller
    private func pushViewController(to view: UIViewController, animated: Bool = true) {
        view.navigationController?.pushViewController(view, animated: animated)
    }
    
}
