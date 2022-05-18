//
//  StringExtension.swift
//  trad
//
//  Created by Imac on 02/09/21.
//

import Foundation
import CommonCrypto

extension String {
    
    var toMD5: String {
        get {
            let messageData = self.data(using:.utf8)!
            var digestData: Data = Data(count: Int(CC_MD5_DIGEST_LENGTH))
            
            _ = digestData.withUnsafeMutableBytes {digestBytes in
                messageData.withUnsafeBytes {messageBytes in
                    CC_MD5(messageBytes, CC_LONG(messageData.count), digestBytes)
                }
            }
            
            return digestData.map { String(format: "%02hhx", $0 as CVarArg) }.joined()
        }
    }
 
}
