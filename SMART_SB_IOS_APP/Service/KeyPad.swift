//
//  KeyPad.swift
//  SMART_SB_APP_IOS
//
//  Created by 김남교 on 2021/02/22.
//

import Foundation
import WebKit
class KeyPad {
    func secureKeyPad (params:Dictionary<String, Any>,sf:String,ff:String,webView : WKWebView){
        
        let keyboardType = Int(params["KEYBOARD_TYPE"] as! String)!
        
//        let label=params["LABEL"] as! String
//        let hint=params["HINT"] as! String
//        let min=params["MIN"] as! Int
//        let max=params["MAX"] as! Int
//        let key=params["KEY"] as! String
        
        Log.print(message: "키패드 호출")
        switch keyboardType {
        case 1:
            Log.print("넘버키패드")
            var resultData : Dictionary<String,Any> = [String:Any]()
        
            UIApplication
                .shared
                .NumberView(title: "보안키패드",
                         data: params,
                         completeHandler: {
                            pinStr, SignDataStr in
                            Log.print("completed Data: \(pinStr), \(SignDataStr)")
                            resultData["encData"]=SignDataStr
                            DataWebSend().resultWebSend(resultCd: "0000", dicParmas:resultData, resultFunc : sf ,webView: webView)
                            
                         }, cancelHandler: {
                            Log.print("cancel")
                            DataWebSend().resultWebSend(resultCd: "9998", dicParmas:resultData, resultFunc : sf ,webView: webView)
                         })
            break;
        case 2:
            Log.print("쿼티키패드")
            var resultData : Dictionary<String,Any> = [String:Any]()
            UIApplication
                .shared
                .QwertyView(title: "보안키패드",
                         data: params,
                         isShowDots : false,
                         completeHandler: {
                            pinStr, SignDataStr in
                            Log.print("completed Data: \(pinStr), \(SignDataStr)")
                            resultData["encData"]=SignDataStr
                            DataWebSend().resultWebSend(resultCd: "0000", dicParmas:resultData, resultFunc : sf ,webView: webView)
                            
                         }, cancelHandler: {
                            Log.print("cancel")
                            DataWebSend().resultWebSend(resultCd: "9998", dicParmas:resultData, resultFunc : sf ,webView: webView)
                         })
            
            break;
        default:
            Log.print("키패드 에러")
        }
    }
}
