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
            self.cacheUserInfo(user: user)
            return user
        }
    
        let params: Dictionary = ["phone" : mobile, "code" : code]
        let resource = jsonResource(path: UserPath.login, method: .POST, requestParameters: params, parse: parse)
        
        apiRequest(modifyRequest: {_ in}, baseURL: Config.baseURL as NSURL, resource: resource, failure: failureHandler, completion: completion)
    }
    
    func userEdit(name: String, value: String, failureHandler: FailureHandler?, completion: @escaping (User) -> Void) {
        let parse: (JSONDictionary) -> User? = { data in
            let user = Mapper<User>().map(JSON: data)
            self.cacheUserInfo(user: user)
            // 保存用户信息
            return user
        }
        
        let params: Dictionary = [name : value]
        let resource = authJsonResource(path: UserPath.edit, method: .POST, requestParameters: params, parse: parse)
        
        apiRequest(modifyRequest: {_ in}, baseURL: Config.baseURL as NSURL, resource: resource, failure: failureHandler, completion: completion)
    }
    
    // MARK: Private
    private func cacheUserInfo(user: User?) {
        // 保存用户信息
        if let token = user?.token {
            VUserDefaults.token.value = token
        }
        
        VUserDefaults.id.value = user?.id
        VUserDefaults.avatar.value = user?.avatar
        VUserDefaults.name.value = user?.name
        VUserDefaults.nick.value = user?.nick
        VUserDefaults.phone.value = user?.phone
        VUserDefaults.gender.value = user?.gender
        VUserDefaults.remark.value = user?.remark
        VUserDefaults.education.value = user?.education
        VUserDefaults.gender.value = user?.gender
        VUserDefaults.company.value = user?.company
        VUserDefaults.business.value = user?.business
        VUserDefaults.country.value = user?.country
        VUserDefaults.age.value = user?.age
        VUserDefaults.bust.value = user?.bust
        VUserDefaults.weight.value = user?.weight
        VUserDefaults.height.value = user?.height
        VUserDefaults.college.value = user?.college
        VUserDefaults.education.value = user?.education
        VUserDefaults.specialty.value = user?.specialty
        if let hobby = user?.hobby {
            VUserDefaults.hobby.value  = hobby.joined(separator: ",")
        } else {
            VUserDefaults.hobby.value  = nil
        }
    }
}
