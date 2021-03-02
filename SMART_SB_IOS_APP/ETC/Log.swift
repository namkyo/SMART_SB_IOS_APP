//
//  Log.swift
//  SMART_SB_APP_IOS
//
//  Created by 김남교 on 2021/01/30.
//

import Foundation
class Log {
    static func print(_ file: String = #file, _ function: String = #function, _ line: Int = #line, message: Any? = "") {
        
        var fileName = (file as NSString).lastPathComponent
        fileName = fileName.components(separatedBy: ".").first ?? ""
        
        var printLog = "\(fileName) - \(function) [\(line)]"
        
        if let msg = message {
            printLog += " : \(msg)"
        }
        
        NSLog("\(printLog)")
    }
}
