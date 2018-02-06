//
//  User.swift
//  Vote
//
//  Created by Grant Yuan on 2018/2/6.
//  Copyright © 2018年 林以达. All rights reserved.
//

import Foundation
import ObjectMapper

struct User: Mappable {
    var token     :String?
    var avatar    :String?
    var phone     :String?
    var nick      :String?
    var remark    :String?
    var gender    :String?
    var business  :String?
    var company   :String?
    var country   :String?
    var like      :String?
    var name      :String?
    var bust      :String?
    var weight    :String?
    var height    :String?
    var education :String?
    var college   :String?
    var specialty :String?
    
    init?(map: Map) {
        // do nothing
    }
    
    mutating func mapping(map: Map) {
        token      <- map["token"]
        avatar     <- map["avatar"]
        phone      <- map["phone"]
        nick       <- map["nick"]
        remark     <- map["remark"]
        gender     <- map["gender"]
        business   <- map["business"]
        company    <- map["company"]
        country    <- map["country"]
        like       <- map["like"]
        name       <- map["name"]
        bust       <- map["bust"]
        weight     <- map["weight"]
        height     <- map["height"]
        education  <- map["education"]
        college    <- map["college"]
        specialty  <- map["specialty"]
    }
}


