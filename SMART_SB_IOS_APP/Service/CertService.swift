//
//  CertManager.swift
//  SMART_SB_APP_IOS
//
//  Created by 김남교 on 2021/02/24.
//

import Foundation
import WebKit

class CertService{
    
    func certManager (params:Dictionary<String, Any>,sf:String,ff:String,webView : WKWebView){
        let resultData : Dictionary<String,String> = [String:String]()
        UIApplication
            .shared
            .CertView(title:"공동인증서관리",
                        sub_title:"공동인증서관리",
                        hint:"공동인증서관리",
                        mode:1,
                        data: params,
                        complete: {
                            result in
                            Log.print("completed Data: \(result)")
                            DataWebSend().resultWebSend(resultCd: "0000", dicParmas:result, resultFunc : sf ,webView: webView)
                        
                        }, failed: {
                            errcd,errMsg in
                            Log.print("errcd : " + errcd)
                            Log.print("errMsg : " + errMsg)
                            DataWebSend().resultWebSend(resultCd: errcd, dicParmas:resultData, resultFunc : sf ,webView: webView)
                        })
    }
    
    
    func certSign (params:Dictionary<String, Any>,sf:String,ff:String,webView : WKWebView){
        UIApplication
            .shared
            .CertView(title:"공동인증서수행",
                        sub_title:"공동인증서수행",
                        hint:"공동인증서수행",
                        mode:2,
                        data: params,
                        complete: {
                            result in
                            Log.print("공동인증서 서명후 result: \(result)")
                            DataWebSend().resultWebSend(resultCd: "0000", dicParmas:result, resultFunc : sf ,webView: webView)
                        
                        }, failed: {
                            errcd,errMsg in
                            Log.print("errcd : " + errcd)
                            Log.print("errMsg : " + errMsg)
                            //DataWebSend().resultWebSend(resultCd: errcd, dicParmas:resultData, resultFunc : sf ,webView: webView)
                        })
    }
    func certImport (params:Dictionary<String, Any>,sf:String,ff:String,webView : WKWebView){
        let vc = CertImportVC.instantiate(storyboard: "CertImport")
        let topView = UIApplication.topViewController()
        topView?.modalPresentationStyle = .fullScreen
        topView?.present(vc, animated: true, completion: nil)
    }
    
    func scraping (params:Dictionary<String, Any>,sf:String,ff:String,webView : WKWebView){
        UIApplication
            .shared
            .CertView(title:"공동인증서수행 스크랩핑",
                        sub_title:"공동인증서수행 스크랩핑",
                        hint:"공동인증서수행",
                        mode:3,
                        data: params,
                        complete: {
                            result in
                            Log.print("공동인증서 서명후 result: \(result)")
                            DataWebSend().resultWebSend(resultCd: "0000", dicParmas:result, resultFunc : sf ,webView: webView)
                        
                        }, failed: {
                            errcd,errMsg in
                            Log.print("errcd : " + errcd)
                            Log.print("errMsg : " + errMsg)
                            //DataWebSend().resultWebSend(resultCd: errcd, dicParmas:resultData, resultFunc : sf ,webView: webView)
                        })
    }
}
