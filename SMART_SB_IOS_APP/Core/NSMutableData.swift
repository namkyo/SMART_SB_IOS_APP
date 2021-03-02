//
//  NSMutableData.swift
//  JTSB
//
//  Created by 최지수 on 07/05/2020.
//  Copyright © 2020 CJS. All rights reserved.
//

import Foundation

extension NSMutableData {
  func appendString(_ string: String) {
    if let data = string.data(using: .utf8) {
      self.append(data)
    }
  }
}
