//
//  Validation.swift
//  SMART_SB_IOS_APP
//
//  Created by 김남교 on 2021/03/07.
//

import Foundation
import SwiftyJSON
import Alamofire
class Validation {
    // 토큰검사
    func tokenValidation(token: String,custNo : String ,completeHandler: ((Bool, String) -> Void)?) {
        let semdUrl: String = "everSafeTokenCheck.act"
        let json2:JSON  = ["custNo":custNo]
        Function.getDataFromServer(filter: token, jsonData: json2, url: semdUrl,completeHandler: {
                resultJson in
                let result=resultJson["result"] as? Int == 1 ? true : false
                //let type=resultJson["type"] as? String
                let msg=resultJson["msg"] as? String
            
                DispatchQueue.main.async {
                    completeHandler! (result, msg ?? "응답없음")
                }
            })
    }
    
    /// 핀번호 유효성 검사 validation
    func checkPinValidation(encData: String, custNo:String,completeHandler: ((Bool, String) -> Void)?) {
        let semdUrl: String = "pinValidation.act"
        let json2:JSON  = ["encData":encData,"custNo":custNo]
        Function.getDataFromServer(filter: "",jsonData: json2, url: semdUrl,completeHandler: {
                resultJson in
                
                let succYn = resultJson["succYn"] as! String == "Y" ? true : false
                let msg = resultJson["errMesg"] as? String
                if succYn {
                    completeHandler! (true, "성공")
                } else {
                    completeHandler! (false, msg!)
                }
            })
    }
}
