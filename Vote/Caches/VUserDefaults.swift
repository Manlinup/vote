//
//  VUserDefaults.swift
//  Vote
//
//  Created by Grant Yuan on 2018/2/4.
//  Copyright © 2018年 林以达. All rights reserved.
//

import Foundation

private let tokenKey    = "token"
private let avatarKey   = "avatar"
private let phoneKey    = "phone"
private let nickKey     = "nick"
private let remarkKey   = "remark"
private let genderKey   = "gender"
private let businessKey = "business"
private let companyKey  = "company"
private let countryKey  = "country"
private let likeKey     = "like"
private let nameKey     = "name"
private let bustKey     = "bust"
private let weightKey   = "weight"
private let heightKey   = "height"
private let educationKey = "education"
private let collegeKey   = "college"
private let specialtyKey = "specialty"

class VUserDefaults {
    static let defaults = UserDefaults()
    
    // MARK: Clean All Data
    class func cleanAllData() {
        token.removeAllListeners()
        phone.removeAllListeners()
        avatar.removeAllListeners()
        
        token.value = nil
        
        // reset suite
        let dict = defaults.dictionaryRepresentation()
        
        dict.keys.forEach({
            defaults.removeObject(forKey: $0)
        })
        
        defaults.synchronize()
    }
    
    // MARK: - props
    
    static var avatar: Listenable<String?> = {
        let avatar = defaults.string(forKey: avatarKey)
        
        return Listenable<String?>(avatar) { avatar in
            defaults.set(avatar, forKey: avatarKey)
        }
    }()
    
    static var token: Listenable<String?> = {
        var token = defaults.string(forKey: tokenKey)
        
        return Listenable<String?>(token) { token in
            defaults.set(token, forKey: tokenKey)
        }
    }()
    
    static var phone: Listenable<String?> = {
        var phone = defaults.string(forKey: phoneKey)
        
        return Listenable<String?>(phone) { phone in
            defaults.set(phone, forKey: phoneKey)
        }
    }()
    
    static var nick: Listenable<String?> = {
        var nick = defaults.string(forKey: nickKey)
        
        return Listenable<String?>(nick) { nick in
            defaults.set(nick, forKey: nickKey)
        }
    }()
    
    static var remark: Listenable<String?> = {
        var remark = defaults.string(forKey: remarkKey)
        
        return Listenable<String?>(remark) { remark in
            defaults.set(remark, forKey: remarkKey)
        }
    }()
    
    static var gender: Listenable<String?> = {
        var gender = defaults.string(forKey: genderKey)
        
        return Listenable<String?>(gender) { gender in
            defaults.set(gender, forKey: genderKey)
        }
    }()
    
    static var business: Listenable<String?> = {
        var business = defaults.string(forKey: businessKey)
        
        return Listenable<String?>(business) { business in
            defaults.set(business, forKey: businessKey)
        }
    }()
    
    static var company: Listenable<String?> = {
        var company = defaults.string(forKey: companyKey)
        
        return Listenable<String?>(company) { company in
            defaults.set(company, forKey: companyKey)
        }
    }()
    
    static var country: Listenable<String?> = {
        var country = defaults.string(forKey: countryKey)
        
        return Listenable<String?>(country) { country in
            defaults.set(country, forKey: countryKey)
        }
    }()
    
    static var like: Listenable<String?> = {
        var like = defaults.string(forKey: likeKey)
        
        return Listenable<String?>(like) { like in
            defaults.set(like, forKey: likeKey)
        }
    }()
    
    static var name: Listenable<String?> = {
        var name = defaults.string(forKey: nameKey)
        
        return Listenable<String?>(name) { name in
            defaults.set(name, forKey: nameKey)
        }
    }()
    
    static var bust: Listenable<String?> = {
        var bust = defaults.string(forKey: bustKey)
        
        return Listenable<String?>(bust) { bust in
            defaults.set(bust, forKey: bustKey)
        }
    }()
    
    static var weight: Listenable<String?> = {
        var weight = defaults.string(forKey: weightKey)
        
        return Listenable<String?>(weight) { weight in
            defaults.set(weight, forKey: weightKey)
        }
    }()
    
    static var height: Listenable<String?> = {
        var height = defaults.string(forKey: heightKey)
        
        return Listenable<String?>(height) { height in
            defaults.set(height, forKey: heightKey)
        }
    }()
    
    static var education: Listenable<String?> = {
        var education = defaults.string(forKey: educationKey)
        
        return Listenable<String?>(education) { education in
            defaults.set(education, forKey: educationKey)
        }
    }()
    
    static var college: Listenable<String?> = {
        var college = defaults.string(forKey: collegeKey)
        
        return Listenable<String?>(college) { college in
            defaults.set(college, forKey: collegeKey)
        }
    }()
    
    static var specialty: Listenable<String?> = {
        var specialty = defaults.string(forKey: specialtyKey)
        
        return Listenable<String?>(specialty) { specialty in
            defaults.set(specialty, forKey: specialtyKey)
        }
    }()
}

struct Listener<T>: Hashable {
    let name: String
    
    typealias Action = (T) -> Void
    let action: Action
    
    var hashValue: Int {
        return name.hashValue
    }
}

func ==<T>(lhs: Listener<T>, rhs: Listener<T>) -> Bool {
    return lhs.name == rhs.name
}

class Listenable<T> {
    var value: T {
        didSet {
            setterAction(value)
            
            for listener in listenerSet {
                listener.action(value)
            }
        }
    }
    
    typealias SetterAction = (T) -> Void
    var setterAction: SetterAction
    
    var listenerSet = Set<Listener<T>>()
    
    func bindListener(_ name: String, action: @escaping Listener<T>.Action) {
        let listener = Listener(name: name, action: action)
        
        listenerSet.insert(listener)
    }
    
    func bindAndFireListener(_ name: String, action: @escaping Listener<T>.Action) {
        bindListener(name, action: action)
        
        action(value)
    }
    
    func removeListenerWithName(_ name: String) {
        for listener in listenerSet {
            if listener.name == name {
                listenerSet.remove(listener)
                break
            }
        }
    }
    
    func removeAllListeners() {
        listenerSet.removeAll(keepingCapacity: false)
    }
    
    init(_ v: T, setterAction action: @escaping SetterAction) {
        value = v
        setterAction = action
    }
}

// MARK: Public
func isLogin() -> Bool {
    if VUserDefaults.token.value != nil {
        return true
    }
    
    return false
}
