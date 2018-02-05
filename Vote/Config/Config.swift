//
//  Config.swift
//  Vote
//
//  Created by Grant Yuan on 2018/2/4.
//  Copyright © 2018年 林以达. All rights reserved.
//

import UIKit

class Config: NSObject {
    static let shared: Config = Config()
    
    private override init() {
        // do nothing
    }
    
    static var isRelease: Bool = false
    static var isEnableDebugLog: Bool = !isRelease
    
    static let baseURL = NSURL(string: isRelease ? "https://www.bingowo.com/api/index.php/" : "https://www.bingowo.com/api/index.php/")!
    static let serverDomain = "https://www.bingowo.com"
    
    static let networkTimeout: Double = 18
    
    /**
     * 日志
     */
    struct Logger {
        static let pathName: String = "vote-debug.log"
    }
}

// MARK: Constant Define
let kSCREEN_WIDTH   = UIScreen.main.bounds.width
let kSCREEN_HEIGHT  = UIScreen.main.bounds.height
