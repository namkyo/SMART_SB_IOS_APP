//
//  WebService.swift
//  JTSB
//
//  Created by 최지수 on 27/04/2020.
//  Copyright © 2020 CJS. All rights reserved.
//

import Foundation

class WebService {
    
    /**
    * App 링크 호출
    */
    static func AppLink(_ parameter: [String:Any]) {
        
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
    * Web 링크 호출
    */
    static func WebLink(_ parameter: [String:Any], successHandler: @escaping() -> Void) {
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
    
    
}
