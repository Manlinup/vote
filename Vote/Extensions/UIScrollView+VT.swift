//
//  UIScrollView+VT.swift
//  Vote
//
//  Created by Grant Yuan on 2018/2/5.
//  Copyright © 2018年 林以达. All rights reserved.
//

import UIKit

extension UIScrollView {
    func setScrollViewContentSize(offsetHeight: CGFloat = 0, height: CGFloat = -1) {
        var contentRect = CGRect.zero;
        
        for view in self.subviews {
            contentRect = contentRect.union(view.frame);
        }
        
        if contentRect.size.height < kSCREEN_HEIGHT {
            contentRect.size = CGSize(width: contentRect.width, height: kSCREEN_HEIGHT)
        }
        
        if height != -1 {
            contentRect.size = CGSize(width: contentRect.width, height: height)
        } else {
            contentRect.size = CGSize(width: kSCREEN_WIDTH, height: contentRect.size.height + offsetHeight)
        }
        
        self.contentSize = contentRect.size;
    }
}
