//
//  VoteEntity.swift
//  Vote
//
//  Created by Grant Yuan on 2018/2/9.
//  Copyright © 2018年 林以达. All rights reserved.
//

import Foundation
import ObjectMapper

struct Vote: Mappable {
    var id: Int?
    var articleId: Int?
    var article: Article?
    var questions: [Question]?
    
    init?(map: Map) {
        // do nothing
    }
    
    mutating func mapping(map: Map) {
        id          <- (map["id"], TransformHelper.intTransform)
        articleId   <- (map["articleId"], TransformHelper.intTransform)
        questions   <- map["content"]
        article     <- map["article"]
    }
}


struct Article: Mappable {
    var id: Int?
    var uid: Int?
    var title: String?
    var questionId: Int?
    var num: Int?
    var priceOne: Double?
    var price: Double?
    var totalFee: Double?
    var length: Int?
    var period: Int?
    var progress: Int?
    var type: Int?
    var status: Int?
    
    init?(map: Map) {
        // do nothing
    }
    
    mutating func mapping(map: Map) {
        id          <- (map["id"], TransformHelper.intTransform)
        uid         <- (map["uid"], TransformHelper.intTransform)
        title       <- map["title"]
        questionId  <- (map["question_id"], TransformHelper.intTransform)
        num         <- (map["num"], TransformHelper.intTransform)
        priceOne    <- (map["price_one"], TransformHelper.doubleTransform)
        price       <- (map["price"], TransformHelper.doubleTransform)
        totalFee    <- (map["total_fee"], TransformHelper.doubleTransform)
        length      <- (map["length"], TransformHelper.intTransform)
        period      <- (map["period"], TransformHelper.intTransform)
        progress    <- (map["progress"], TransformHelper.intTransform)
        type        <- (map["type"], TransformHelper.intTransform)
        status      <- (map["status"], TransformHelper.intTransform)
    }
}


struct Question: Mappable {
    var id: Int?
    var title: String?
    var type: Int?
    var questionId: Int?
    var choices: [Choice]?
    
    init?(map: Map) {
        // do nothing
    }
    
    mutating func mapping(map: Map) {
        id      <- (map["id"], TransformHelper.intTransform)
        title   <- map["title"]
        type    <- (map["type"], TransformHelper.intTransform)
        questionId  <- (map["question_id"], TransformHelper.intTransform)
        choices     <- map["choose"]
    }
}

struct Choice: Mappable {
    var id: Int?
    var c_num: String?
    var c_val: String?
    
    init?(map: Map) {
        // do nothing
    }
    
    mutating func mapping(map: Map) {
        id      <- (map["id"], TransformHelper.intTransform)
        c_num   <- map["c_num"]
        c_val   <- map["c_val"]
    }
}
