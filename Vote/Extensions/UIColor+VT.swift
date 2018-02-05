//
//  UIColor+VT.swift
//  Vote
//
//  Created by Grant Yuan on 2018/2/5.
//  Copyright © 2018年 林以达. All rights reserved.
//

import UIKit

public extension UIColor {
    class func vtTintColor() -> UIColor {
        return UIColor(hexString: "#3d8441")
    }
    
    class func vtTextGrayColor() -> UIColor {
        return UIColor(hexString: "#666666")
    }
    
    class func vtViewBackgroundColor() -> UIColor {
        return UIColor(hexString: "#f5f5f5")
    }
    
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        
        Scanner(string: hex).scanHexInt32(&int)
        
        let a, r, g, b: UInt32
        
        switch hex.count {
        case 3:
            // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
