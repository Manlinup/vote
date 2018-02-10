//
//  TransformHelper.swift
//  Vote
//
//  Created by Grant Yuan on 2018/2/10.
//  Copyright © 2018年 林以达. All rights reserved.
//

import Foundation
import ObjectMapper

class TransformHelper: NSObject {
    static let urlTransform = TransformOf<NSURL, String>(fromJSON: { (value: String?) -> NSURL? in
        if let value = value {
            return NSURL(string: value)
        } else {
            return nil
        }
    }, toJSON: { (value: NSURL?) -> String? in
        return value?.absoluteString
    })
    
    static let intTransform = TransformOf<Int, AnyObject>(fromJSON: { (value: AnyObject?) -> Int? in
        if value is String {
            return Int(value as! String)
        } else if value is NSNumber {
            return (value as! NSNumber).intValue
        } else {
            return nil
        }
    }, toJSON: { (value: Int?) -> AnyObject? in
        if let value = value {
            return NSNumber(value: value)
        } else {
            return nil
        }
    })
    
    static let doubleTransform = TransformOf<Double, AnyObject>(fromJSON: { (value: AnyObject?) -> Double? in
        if value is String {
            return Double(value as! String)
        } else if value is NSNumber {
            return (value as! NSNumber).doubleValue
        } else {
            return nil
        }
    }, toJSON: { (value: Double?) -> AnyObject? in
        if let value = value {
            return NSNumber(value: value)
        } else {
            return nil
        }
    })
    
    static let stringTransform = TransformOf<String, AnyObject>(fromJSON: { (value: AnyObject?) -> String? in
        if value is String {
            return (value as! String)
        } else if value is NSNumber {
            return (value as! NSNumber).stringValue
        } else {
            return nil
        }
    }, toJSON: { (value: String?) -> AnyObject? in
        if let value = value {
            return value as AnyObject
        } else {
            return nil
        }
    })
}
