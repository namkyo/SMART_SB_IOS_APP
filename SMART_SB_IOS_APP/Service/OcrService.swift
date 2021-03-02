//
//  OcrService.swift
//  SMART_SB_APP_IOS
//
//  Created by 김남교 on 2021/02/28.
//

import Foundation
import WebKit

class OcrService{
    var webView:WKWebView?
    var sf:String?
    var ff:String?
    var delegate: OCRDelegate?
    
    func ocrGo (params:Dictionary<String, Any>,sf:String,ff:String,webView : WKWebView){
        self.sf=sf
        self.ff=ff
        self.webView=webView
        
        var resultData : Dictionary<String,Any> = [String:Any]()
        UIApplication
            .shared
            .OcrView(data: params,
                     completeHandler: {
                        result  in
                            Log.print("ocr 후")
                            Log.print(("result.rbrNo : "+result["rbrNo"]! as? String)!)
                            DataWebSend().resultWebSend(resultCd: "0000", dicParmas:result, resultFunc : sf ,webView: webView)
                        
                        }, cancelHandler: {
                            errcd,errMsg in
                            Log.print("errcd : " + errcd)
                            Log.print("errMsg : " + errMsg)
                            DataWebSend().resultWebSend(resultCd: errcd, dicParmas:resultData, resultFunc : sf ,webView: webView)
                        })
    }
}
// OCR 성공
extension OcrService: OCRDelegate {
    func completedOCR(result: [String : String]) {
        Log.print("ocr 후2 result: \(result)")
                  
        DataWebSend().resultWebSend(resultCd: "0000", dicParmas:result, resultFunc : self.sf! ,webView: self.webView!)
    }
}
