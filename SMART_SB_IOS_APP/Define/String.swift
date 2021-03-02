//
//  String.swift
//  SmartSavingsBank
//
//  Created by 김남교 on 2020/12/19.
//

import Foundation
import CommonCrypto
import UIKit

extension String {
    
    // HASH
    func sha1() -> String {
        let data = Data(self.utf8)
        var digest = [UInt8](repeating: 0, count:Int(CC_SHA1_DIGEST_LENGTH))
        data.withUnsafeBytes {
            _ = CC_SHA1($0.baseAddress, CC_LONG(data.count), &digest)
        }
        let hexBytes = digest.map { String(format: "%02hhx", $0) }
        return hexBytes.joined()
    }
    
    func toReplace(_ of: String, _ with: String) -> String {
        return self.replacingOccurrences(of: of, with: with)
    }
}
