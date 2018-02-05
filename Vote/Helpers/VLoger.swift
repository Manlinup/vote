//
//  VLoger.swift
//  Vote
//
//  Created by Grant Yuan on 2018/2/4.
//  Copyright © 2018年 林以达. All rights reserved.
//

import Foundation
import XCGLogger

let log: XCGLogger = {
    
    let log = XCGLogger()
    
    if Config.isEnableDebugLog {
        log.setup(level: .verbose, showThreadName: true, showLevel: true, showFileNames: true, showLineNumbers: true, writeToFile: FileManager.loggerPath(logerName: Config.Logger.pathName), fileLevel: .verbose)
    } else {
        log.setup(level: .error, showThreadName: true, showLevel: true, showFileNames: true, showLineNumbers: true, writeToFile: FileManager.loggerPath(logerName: Config.Logger.pathName), fileLevel: .warning)
    }
    
    return log
}()

