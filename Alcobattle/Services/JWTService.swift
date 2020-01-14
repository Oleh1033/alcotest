//
//  JWTService.swift
//  Alcobattle
//
//  Created by Oleh on 06/09/2019.
//  Copyright © 2019 Oleh. All rights reserved.
//

import UIKit
import SwiftyJSON

class JWTService {
    
    static let shared = JWTService()
    
    func decode(jwtToken jwt: String) -> [String: Any] {
        let segments = jwt.components(separatedBy: ".")
        return decodeJWTPart(segments[1]) ?? [:]
    }
    
    func base64UrlDecode(_ value: String) -> Data? {
        var base64 = value
            .replacingOccurrences(of: "-", with: "+")
            .replacingOccurrences(of: "_", with: "/")
        
        let length = Double(base64.lengthOfBytes(using: String.Encoding.utf8))
        let requiredLength = 4 * ceil(length / 4.0)
        let paddingLength = requiredLength - length
        if paddingLength > 0 {
            let padding = "".padding(toLength: Int(paddingLength), withPad: "=", startingAt: 0)
            base64 = base64 + padding
        }
        return Data(base64Encoded: base64, options: .ignoreUnknownCharacters)
    }
    
    func decodeJWTPart(_ value: String) -> [String: Any]? {
        guard let bodyData = base64UrlDecode(value),
            let json = try? JSONSerialization.jsonObject(with: bodyData, options: []), let payload = json as? [String: Any] else {
                return nil
        }
        
        return payload
    }
    
    func isValidToken(token: String) -> Bool {
        let data = decode(jwtToken: token)
        var exp = JSON(data)
        let dateExp: String = exp["exp"].string ?? ""
        
        let timestamp = NSDate().timeIntervalSince1970
        
        if Int(timestamp) < Int(dateExp) ?? 0 {
            print("Valid token!")
            return true
        } else {
            print("Token InValid")
            return false
        }
    }
}
