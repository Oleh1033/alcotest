//
//  Authorization.swift
//  Alcobattle
//
//  Created by Oleh on 29/08/2019.
//  Copyright © 2019 Oleh. All rights reserved.
//

import Foundation
import SwiftyJSON

class Authorization {
    
    static var shared = Authorization()
    
    var tokenGoogle = ""
    var token: String?
    
    func isValidToken() -> Bool {
        guard let tokenUnwrapperd = self.token else { return false}
        return JWTService.shared.isValidToken(token: tokenUnwrapperd)
    }
}
