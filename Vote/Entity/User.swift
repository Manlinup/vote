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
    var id        :String?
    var token     :String?
    var avatar    :String?
    var phone     :String?
    var thumb: String?
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
    var money:  Double?
    var answerNum: Int?
    var draftNum: Int?
    var articleNum: Int?
    var hobby: [String]?
    
    init?(map: Map) {
        // do nothing
    }
    
    mutating func mapping(map: Map) {
        id         <- map["id"]
        token      <- map["token"]
        avatar     <- map["photo"]
        phone      <- map["phone"]
        thumb      <- map["thumb"]
        nick       <- map["nickname"]
        remark     <- map["signature"]
        gender     <- map["sex"]
        business   <- map["business"]
        company    <- map["company"]
        country    <- map["country"]
        like       <- map["like"]
        name       <- map["uname"]
        bust       <- map["bust"]
        weight     <- map["weight"]
        height     <- map["height"]
        education  <- map["educational"]
        college    <- map["college"]
        specialty  <- map["specialty"]
        money      <- map["money"]
        answerNum  <- map["answerNum"]
        draftNum   <- map["draftNum"]
        articleNum <- map["articleNum"]
        hobby      <- map["hobby"]
    }
}


