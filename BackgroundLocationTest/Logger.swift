//
//  Logger.swift
//  BackgroundLocationTest
//
//  Created by Serge Sukhanov on 2/24/18.
//  Copyright © 2018 Serge Sukhanov. All rights reserved.
//

import Foundation

struct UserDefaultsKeys {
    static let Log = "KeyForLog"
}

class Logger {
    static func log(message: String) {
        let message = "\(Date().description): \(message)"
        print(message)
        var currentLogs = getLogs()
        currentLogs.append(message)
        setLogs(value: currentLogs)
    }
    
    static func showLog() {
        print("===== START LOGS =====")
        getLogs().forEach { print($0) }
        print("===== END LOGS =====\n")
    }
    
    static func clearLog() {
        setLogs(value: [])
        print("===== LOGS CLEARED =====\n")
    }
    
    static func getLogs() -> [String] {
        let value = UserDefaults.standard.object(forKey: UserDefaultsKeys.Log) as? [String]
        return value ?? [String]()
    }
    
    static func setLogs(value: [String]) {
        UserDefaults.standard.set(value, forKey: UserDefaultsKeys.Log)
    }
}
