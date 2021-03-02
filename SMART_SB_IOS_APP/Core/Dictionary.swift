//
//  Dictionary.swift
//  JTSB
//
//  Created by 최지수 on 26/04/2020.
//  Copyright © 2020 CJS. All rights reserved.
//

import Foundation

extension Dictionary {
    func jsonToServer(data: [String:String]) -> String {
        let encoder = JSONEncoder()
        if let jsonData = try? encoder.encode(data) {
            if let jsonStr = String(data: jsonData, encoding: .utf8) {
                return jsonStr
            }
        }
        
        return ""
    }
}
