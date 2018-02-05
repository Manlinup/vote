//
//  Error+VT.swift
//  Vote
//
//  Created by Grant Yuan on 2018/2/4.
//  Copyright © 2018年 林以达. All rights reserved.
//

import Foundation

extension Error {
    var code: Int { return (self as NSError).code }
    var domain: String { return (self as NSError).domain }
}
