//
//  CocoaMQTTLogger.swift
//  CocoaMQTT
//
//  Created by HJianBo on 2019/5/2.
//  Copyright © 2019 emqx.io. All rights reserved.
//

import Foundation

// Convenience functions
func printDebug(_ message: String) {
    CocoaMQTTLogger.logger.debug(message)
}

func printInfo(_ message: String) {
    CocoaMQTTLogger.logger.info(message)
}

func printWarning(_ message: String) {
    CocoaMQTTLogger.logger.warning(message)
}

func printError(_ message: String) {
    CocoaMQTTLogger.logger.error(message)
}


// Enum log levels
public enum CocoaMQTTLoggerLevel: Int {
    case debug = 0, info, warning, error, off
}

public protocol LoggableFunc {
     func log(level: CocoaMQTTLoggerLevel, minLevel: CocoaMQTTLoggerLevel, message: String)
}

class LoggableFunc: NSObject {
    
   func log(level: CocoaMQTTLoggerLevel, minLevel: CocoaMQTTLoggerLevel, message: String) {
        guard level.rawValue >= minLevel.rawValue else { return }
        print("CocoaMQTT(\(level)): \(message)")
   }
}

open class CocoaMQTTLogger: NSObject {
    
    // Singleton
    public static var logger = CocoaMQTTLogger()
    public override init() { super.init() }
    public var loggableFunc: LoggableFunc = LoggableFunc()
    // min level
    var minLevel: CocoaMQTTLoggerLevel = .warning
    
    // logs
    
    func debug(_ message: String) {
        loggableFunc.log(level: .debug, minLevel: minLevel, message: message)
    }
    
    func info(_ message: String) {
        loggableFunc.log(level: .info, minLevel: minLevel, message: message)
    }
    
    func warning(_ message: String) {
        loggableFunc.log(level: .warning, minLevel: minLevel, message: message)
    }
    
    func error(_ message: String) {
        loggableFunc.log(level: .error, minLevel: minLevel, message: message)
    }
    
}
