//
//  DataWebSend.swift
//  SMART_SB_APP_IOS
//
//  Created by 김남교 on 2021/02/21.
//

import Foundation
import WebKit
class DataWebSend{
    func resultWebSend(resultCd:String,dicParmas:Dictionary<String,Any>,resultFunc : String,webView : WKWebView){
        var result : Dictionary<String,Any> = [String:Any]()
        result["resultCd"]=resultCd
        result["params"]=dicParmas
        let data = resultFunc + "(" + stringToJson(dic: result)! + ")"
        
        Log.print("sendData = "+data)
        DispatchQueue.main.async {
            webView.evaluateJavaScript(data,completionHandler: {
                (result, error) in
                Log.print("데이터 송신 : \(result)")
            })
        }
    }
    func resultWebSend(resultCd:String,params:String,resultFunc : String,webView : WKWebView){
        var result : Dictionary<String,Any> = [String:Any]()
        result["resultCd"]=resultCd
        result["params"]=params
        let data = resultFunc + "(" + stringToJson(dic: result)! + ")"
        
        Log.print("sendData = "+data)
        DispatchQueue.main.async {
            webView.evaluateJavaScript(data,completionHandler: {
                (result, error) in
                Log.print("데이터 송신 ")
            })
        }
    }
    func resultWebSend(resultCd:String,resultFunc : String,webView : WKWebView){
        var result : Dictionary<String,Any> = [String:Any]()
        result["resultCd"]=resultCd
        result["parmas"] = [String:Any]()
        let data = resultFunc + "(" + stringToJson(dic: result)! + ")"
        
        Log.print("sendData = "+data)
        DispatchQueue.main.async {
            webView.evaluateJavaScript(data,completionHandler: {
                (result, error) in
                Log.print("데이터 송신 ")
            })
        }
    }
    
    
    func stringToJson(dic:Dictionary<String,Any>)->String?{
        let jsonData:NSData = try! JSONSerialization.data(withJSONObject: dic, options: JSONSerialization.WritingOptions.prettyPrinted) as NSData
        let jsonString = String(data: jsonData as Data, encoding: String.Encoding.utf8)
        return jsonString
    }
}
