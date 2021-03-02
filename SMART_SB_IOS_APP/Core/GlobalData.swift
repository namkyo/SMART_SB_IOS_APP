//
//  GlobalData.swift
//  JTSB
//
//  Created by 최지수 on 07/05/2020.
//  Copyright © 2020 CJS. All rights reserved.
//

import Foundation
import UIKit

class GlobalData: NSObject {
    var pushMessage: String?    //푸시메시지
    var pushTitle: String?      //푸시메시지 타이틀
    var pushUrl: String?        //푸시메시지에서 보내는 url
    var pushClick: Bool?      //푸시메시지를 클릭했는지 여부 YES/NO
    
    class var sharedInstance : GlobalData {
        struct Static {
            static let instance : GlobalData = GlobalData()
        }
        return Static.instance
    }

}
