//
//  FileManager+VT.swift
//  Vote
//
//  Created by Grant Yuan on 2018/2/4.
//  Copyright © 2018年 林以达. All rights reserved.
//

import Foundation

extension FileManager {
    class func cachesURL() -> NSURL {
        return try! FileManager.default.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as NSURL
    }
    
    // MARK: Logger
    class func loggerPath(logerName: String) -> NSURL {
        return cachesURL().appendingPathComponent(logerName, isDirectory: false)! as NSURL
    }
}
