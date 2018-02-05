//
//  String+VT.swift
//  Vote
//
//  Created by Grant Yuan on 2018/2/5.
//  Copyright © 2018年 林以达. All rights reserved.
//

import UIKit

// MARK: String width
extension String {
    func evaluateWidth(font: UIFont) -> CGFloat{
        let attributes = NSDictionary(object: font, forKey: NSAttributedStringKey.font as NSCopying)
        let sizeOfText = self.size(withAttributes: attributes as? [NSAttributedStringKey : Any])
        
        return sizeOfText.width + 2
    }
}
