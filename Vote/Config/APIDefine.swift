//
//  APIDefine.swift
//  Vote
//
//  Created by Grant Yuan on 2018/2/4.
//  Copyright © 2018年 林以达. All rights reserved.
//

import Foundation

enum HttpStatusCode: Int, CustomStringConvertible {
    case success        = 200
    case failed         = 500
    case bad_request    = 400
    case auth_failed    = 401
    case access_invalid = 403
    case not_found      = 404
    
    var description: String {
        return "\(self.rawValue)"
    }
}

struct UserPath {
    static let login   = "login/denglu"
}


