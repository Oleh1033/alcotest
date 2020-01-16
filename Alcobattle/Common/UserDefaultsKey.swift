//
//  UserDefaultsKey.swift
//  Alcobattle
//
//  Created by Oleh on 15/01/2020.
//  Copyright © 2020 Oleh. All rights reserved.
//

import Foundation

enum UserDefaultsKeys : String {
    case isLoggedIn
    case userID
}

extension UserDefaults{

    //MARK: Check Login
    func setLoggedIn(value: Bool) {
        set(value, forKey: UserDefaultsKeys.isLoggedIn.rawValue)
        //synchronize()
    }

    func isLoggedIn()-> Bool {
        return bool(forKey: UserDefaultsKeys.isLoggedIn.rawValue)
    }

    //MARK: Save User Data
    func setUserID(value: Int){
        set(value, forKey: UserDefaultsKeys.userID.rawValue)
        //synchronize()
    }

    //MARK: Retrieve User Data
    func getUserID() -> Int{
        return integer(forKey: UserDefaultsKeys.userID.rawValue)
    }
}


//Save in UserDefaults where you want
//
//UserDefaults.standard.setLoggedIn(value: true)          // String
//UserDefaults.standard.setUserID(value: result.User.id!) // String
//Retrieve data anywhere in app
//
//print("ID : \(UserDefaults.standard.getUserID())")
//UserDefaults.standard.getUserID()
//Remove Values
//
//UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.userID)
