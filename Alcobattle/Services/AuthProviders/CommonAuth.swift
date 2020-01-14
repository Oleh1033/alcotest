//
//  CommonAuth.swift
//  Alcobattle
//
//  Created by Oleh on 06/09/2019.
//  Copyright © 2019 Oleh. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import JGProgressHUD
import FacebookLogin
import FacebookCore
import FBSDKCoreKit
import FBSDKLoginKit
import SwiftyJSON
import GoogleSignIn

class CommonAuth {
    
    static let shared = CommonAuth()
    
    func logOut() {
        GIDSignIn.sharedInstance().signOut()
        let manager = LoginManager()
        manager.logOut()
        print("Log out!")
    }
}


