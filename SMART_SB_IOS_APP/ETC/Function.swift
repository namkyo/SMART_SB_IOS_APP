//
//  Function.swift
//  SMART_SB_APP_IOS
//
//  Created by 김남교 on 2021/02/21.
//

import Foundation
import UIKit
import AdSupport

extension Data {
    var hexString: String {
        return map { String(format: "%02hhx", $0) }.joined()
    }
}

extension String {
    func base64Encoded() -> String? {
        return data(using: .utf8)?.base64EncodedString()
    }

    func base64Decoded() -> String? {
        guard let data = Data(base64Encoded: self) else { return nil }
        return String(data: data, encoding: .utf8)
    }
}

class Function:NSObject {
    
    let RGBA: (CGFloat, CGFloat, CGFloat, CGFloat) -> UIColor = {
        (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) -> UIColor in
        return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
    }
    
    class func DFT_TRACE(filename: String = #file, line: Int = #line, funcname: String = #function) {
        #if DEBUG
        print("\(filename)[\(funcname)][Line \(line)]")
        #endif
    }
    
    class func DFT_TRACE_PRINT(filename: String = #file, line: Int = #line, funcname: String = #function, output:Any...) {
        
        #if true
        let now = NSDate()
        print("[\(now.description)][\(filename)][\(funcname)][Line \(line)] \(output)")
        #endif
    }
    /**
    * Web 링크 호출
    */
    class func WebLink(_ parameter: [String:Any], successHandler: @escaping() -> Void) {
        guard let urlStr = parameter["url"] as? String else { return }
        
        guard let encoded = urlStr.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) else { return }
        
        if let numberURL = URL(string: encoded) {
            if UIApplication.shared.canOpenURL(numberURL) {
                UIApplication.shared.open(numberURL, options: [:], completionHandler: { success in
                    successHandler()
                })
            } else {
                UIApplication.shared.showAlert(message: "해당 사이트와 연동이 불가합니다.")
            }
        }
    }
    /**
    * App 링크 호출
    */
    class func AppLink(_ parameter: [String:Any]) {
        
        guard let appID = parameter["appId"] as? String else { return }
        
        
        guard let schemeURL = URL(string: appID) else {
            UIApplication.shared.showAlert(message: "해당앱과 연동이 불가합니다.")
            return
        }
        
        if UIApplication.shared.canOpenURL(schemeURL) {
            UIApplication.shared.open(schemeURL, options: [:], completionHandler: {
               (success) in
                Log.print(message: "success")
                })
        }else {
            
            guard let url = parameter["url"] as? String else { return }
            
            //주소에 한글이 있을경우 처리
            let encoded  = url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
            
            if let storeUrl = URL(string: encoded!) {
                UIApplication.shared.open(storeUrl, options: [:], completionHandler: nil)
            }
        }
    }
    /**
    * adid
    */
    class func getADID()->Dictionary<String,Any>{
        var result : Dictionary<String,Any> = [String:Any]()
        let idfa = ASIdentifierManager.shared().advertisingIdentifier.uuidString
        result["adid"]=idfa
        return result
    }
    /**
    * fds
    */
    class func getFds(params:Dictionary<String,Any>)->Dictionary<String,Any>{
        var dicParams : Dictionary<String,Any> = [String:Any]()
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        
        let prcs_dvcd = params["PRCS_DVCD"] as! String
        if (prcs_dvcd == "U") { //U:토큰조회 , D:기기모듈수집
            if let uuid = appDelegate.tc?.getToken()?.uid {
                dicParams["data"] = ""
                dicParams["key"] = ""
                dicParams["uuid"] = uuid
            }else{
                dicParams["data"] = ""
                dicParams["key"] = ""
                dicParams["uuid"] = ""
            }
        }else if (prcs_dvcd == "D"){//U:토큰조회 , D:기기모듈수집
            let key = params["key"] as? String
            /*
             솔루션 셋팅
             */
            let logMaster = ixcSecuLogMaster()
            logMaster.setServerKey(key)
            logMaster.setCheckApp("")
            
            /*. 솔루션 셋팅 끝 */
            if let encryptedData = logMaster.getEveryLog(), //암호화된 수집정보
                let encryptedKey = logMaster.getBuiltKey(), //암호화된 클라이언트 키 전달
                let uuid = appDelegate.tc?.getToken()?.uid{ //기기정보 uuid
                dicParams["data"] = encryptedData
                dicParams["key"] = encryptedKey
                dicParams["uuid"] = uuid
                dicParams["UUID1"] = Util.getUUID("SMARTSAVINGBANKUUID1")
                dicParams["UUID2"] = Util.getUUID("SMARTSAVINGBANKUUID2")
                Log.print("FDS복호화" + String(logMaster.getEveryLogByString()))
                //Function.DFT_TRACE_PRINT(output: "FDS복호화:",dicData)
            }
        }
        return dicParams
    }
    
    class func AES256Decrypt(val:String) -> String {
        
        var decrypted: String!
        
        do {
            
            let key: Data = Constants.AES.SECRET_KEY.data(using: .utf8)!
            
            let iv: Data = Constants.AES.iv.data(using: .utf8)!
            
            let strData: Data = Data(base64Encoded: val)!
            
            let aes = try AES256(key: key, iv: iv)
            let val = try aes.decrypt(strData)
            
            if ( val != nil ) {
                
                let decryptedDataText = String(data: val, encoding: .utf8)
                decrypted = decryptedDataText
            }
            
        } catch {
            Log.print("Failed")
        }
        
        return decrypted
    }
    
    class func AES256Encrypt(val:String) -> String {
        
        var encrypted: String!
        
        do {
                        
            let key: Data = Constants.AES.SECRET_KEY.data(using: .utf8)!
            
            let iv: Data = Constants.AES.iv.data(using: .utf8)!
            
            let strData: Data = val.data(using: .utf8)!
            
           
            let aes = try AES256(key: key, iv: iv)
            let val = try aes.encrypt(strData)
            //encrypted = val.hexString
            if ( val != nil ) {
                let encryptedDataText = val.base64EncodedString(options: NSData.Base64EncodingOptions())
                 encrypted = encryptedDataText
            }
                      
        } catch {
            print("Failed")
        }
        
        return encrypted
    }
    
}