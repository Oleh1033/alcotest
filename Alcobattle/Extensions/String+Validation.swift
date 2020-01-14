//
//  Учеутішщт.swift
//  Alcobattle
//
//  Created by Oleh on 28/08/2019.
//  Copyright © 2019 Oleh. All rights reserved.
//

import Foundation

extension String {
    
    func isValid(_ validityType: ValidityType) -> Bool {
        let format = "SELF MATCHES %@"
        var regex = ""
        
        switch validityType {
        case .age:
            regex = Regex.age.rawValue
        case .email:
            regex = Regex.email.rawValue
        case .name:
            regex = Regex.name.rawValue
        case .password:
            regex = Regex.password.rawValue
        default:
            print("default")
        }
        
        return NSPredicate(format: format, regex).evaluate(with: self)
    }
}
