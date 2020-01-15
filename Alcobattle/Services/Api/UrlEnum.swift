//
//  UrlEnum.swift
//  Alcobattle
//
//  Created by Oleh on 29/08/2019.
//  Copyright © 2019 Oleh. All rights reserved.
//

import Foundation

enum UrlEnum : String {
    case login                 = "/api/login"
    case createUser            = "/api/createUser"
    case resetPassword         = "/api/resetPassword"
    case loginWithGoogleToken  = "/api/loginWithGoogleToken"
    
    case userLogin             = "/api/sendData"
    case getNearlestUsers      = "/api/getNearlestUsers"
}
