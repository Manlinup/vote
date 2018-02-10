//
//  ArticleService.swift
//  Vote
//
//  Created by Grant Yuan on 2018/2/7.
//  Copyright © 2018年 林以达. All rights reserved.
//

import Foundation
import ObjectMapper

class ArticleService: BaseService {
    func getQuestions(id: Int, failureHandler: FailureHandler?, completion: @escaping (Vote) -> Void) {
        let parse: (JSONDictionary) -> Vote? = { data in
            let vote = Mapper<Vote>().map(JSON: data)
            return vote
        }
        
        let params: Dictionary = ["question_id" : id]
        let resource = authJsonResource(path: ArticlePath.question, method: .GET, requestParameters: params, parse: parse)
        
        apiRequest(modifyRequest: {_ in}, baseURL: Config.baseURL as NSURL, resource: resource, failure: failureHandler, completion: completion)
    }
}
