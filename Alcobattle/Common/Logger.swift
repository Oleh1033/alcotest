//
//  Logger.swift
//  Alcobattle
//
//  Created by Oleh on 14/01/2020.
//  Copyright © 2020 Oleh. All rights reserved.
//

import Foundation

enum LogEvent: String {
    case error
    case info
    case debug
}

class Logger {
    static func log(_ event: LogEvent, _ msg: String? = "", line: Int = #line, fileName: String = #file, funcName: String = #function) {
        #if ENV_DEVELOPMENT
            let fileName = (fileName as NSString).lastPathComponent
            print("\(event): \(Date().timeString())[\(fileName) \(funcName) line: \(line)]", msg)
        #endif
    }
}

func optionalFatalError(_ message: String) {
    #if ENV_DEVELOPMENT
    //swiftlint:disable fatal_error
    Logger.log(.error, message)
    fatalError(message)
    //swiftlint:enable fatal_error
    #else
    return
    #endif
}
