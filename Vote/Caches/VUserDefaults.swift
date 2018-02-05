//
//  VUserDefaults.swift
//  Vote
//
//  Created by Grant Yuan on 2018/2/4.
//  Copyright © 2018年 林以达. All rights reserved.
//

import Foundation

private let tokenKey    = "token"
private let idKey       = "ID"
private let telKey      = "tel"

class VUserDefaults {
    static let defaults = UserDefaults()
    
    // MARK: Clean All Data
    class func cleanAllData() {
        token.removeAllListeners()
        tel.removeAllListeners()
        id.removeAllListeners()
        
        token.value = nil
        tel.value = nil
        id.value = nil
        
        // reset suite
        let dict = defaults.dictionaryRepresentation()
        
        dict.keys.forEach({
            defaults.removeObject(forKey: $0)
        })
        
        defaults.synchronize()
    }
    
    // MARK: - props
    
    static var id: Listenable<String?> = {
        let id = defaults.string(forKey: idKey)
        
        return Listenable<String?>(id) { id in
            defaults.set(id, forKey: idKey)
        }
    }()
    
    static var token: Listenable<String?> = {
        var token = defaults.string(forKey: tokenKey)
        
        return Listenable<String?>(token) { token in
            defaults.set(token, forKey: tokenKey)
        }
    }()
    
    static var tel: Listenable<String?> = {
        var tel = defaults.string(forKey: telKey)
        
        return Listenable<String?>(tel) { tel in
            defaults.set(tel, forKey: telKey)
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
