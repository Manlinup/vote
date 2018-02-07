//
//  UserService.swift
//  Vote
//
//  Created by Grant Yuan on 2018/2/6.
//  Copyright © 2018年 林以达. All rights reserved.
//

import Foundation
import ObjectMapper

class UserService: BaseService {
    func userLogin(mobile: String, code: String, failureHandler: FailureHandler?, completion: @escaping (User) -> Void) {
        let parse: (JSONDictionary) -> User? = { data in
            let user = Mapper<User>().map(JSON: data)
            
            // 保存用户信息
            VUserDefaults.id.value = user?.id
            VUserDefaults.token.value = user?.token
            VUserDefaults.avatar.value = user?.avatar
            VUserDefaults.name.value = user?.name
            VUserDefaults.nick.value = user?.nick
            VUserDefaults.phone.value = user?.phone
            VUserDefaults.gender.value = user?.gender
            VUserDefaults.remark.value = user?.remark
            VUserDefaults.education.value = user?.education
            
            return user
        }
    
        let params: Dictionary = ["phone" : mobile, "code" : code]
        let resource = jsonResource(path: UserPath.login, method: .POST, requestParameters: params, parse: parse)
        
        apiRequest(modifyRequest: {_ in}, baseURL: Config.baseURL as NSURL, resource: resource, failure: failureHandler, completion: completion)
    }
}
