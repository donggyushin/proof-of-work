//
//  Hash.swift
//  proof-of-work
//
//  Created by 신동규 on 2022/03/27.
//

import Foundation
import CryptoKit

final class Hash {
    
    static let `default` = Hash()
    
    private init() {}
    
    func sha256(original: String) -> String {
        let data = original.data(using: .utf8)
        let sha256 = SHA256.hash(data: data!)
        return sha256.compactMap{String(format: "%02x", $0)}.joined()
    }
}
