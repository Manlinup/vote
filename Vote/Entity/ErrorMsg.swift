//
//  ErrorMsg.swift
//  Vote
//
//  Created by Grant Yuan on 2018/2/4.
//  Copyright © 2018年 林以达. All rights reserved.
//

import Foundation

public struct ErrorMsg: CustomStringConvertible {
    let code: Int
    let message: String
    
    init(code: Int = -1, message: String){
        self.code = code
        self.message = message
    }
    
    public var description: String {
        return "code = \(code), message = \(message)"
    }
}
