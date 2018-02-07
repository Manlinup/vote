//
//  UIImageView+VT.swift
//  Vote
//
//  Created by Grant Yuan on 2018/2/7.
//  Copyright © 2018年 林以达. All rights reserved.
//

import UIKit
import Kingfisher

public extension UIImage {
    convenience init(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.init(cgImage: (image?.cgImage)!)
    }
}

extension UIImageView {
    func setImage(stringURL: String?, placeholder: String?, size: CGSize = CGSize.zero) {
        guard let urlString = stringURL else {
            if let placeholder = placeholder {
                if size != CGSize.zero {
                    // 裁剪和缓存图片
                    self.image = UIImage(named: placeholder)?.crop(to: size)
                } else {
                    self.image = UIImage(named: placeholder)
                }
            }
            
            return
        }
        
        var image: UIImage?
        
        if let placeholder = placeholder {
            if size != CGSize.zero {
                // 裁剪和缓存图片
                image = UIImage(named: placeholder)?.crop(to: size)
            } else {
                image = UIImage(named: placeholder)
            }
        }
        
        self.kf.setImage(with: URL(string: urlString), placeholder: image, options: nil, progressBlock: { (receivedSize, expectedSize) in
            // do nothing
        }, completionHandler: { (image, error, cacheType, url) in
            if let image = image {
                if size.width == 0 || size.height == 0 {
                    self.image = image
                } else {
                    self.image = image.crop(to: size)
                }
            }
        })
    }
}


extension UIImage {
    func crop(to:CGSize) -> UIImage {
        guard to.height != 0 && to.width != 0 else {
            return self
        }
        
        guard let cgimage = self.cgImage else { return self }
        
        let contextImage: UIImage = UIImage(cgImage: cgimage)
        
        let contextSize: CGSize = contextImage.size
        
        //Set to square
        var posX: CGFloat = 0.0
        var posY: CGFloat = 0.0
        let cropAspect: CGFloat = to.width / to.height
        
        var cropWidth: CGFloat = to.width
        var cropHeight: CGFloat = to.height
        
        if to.width > to.height { //Landscape
            cropWidth = contextSize.width
            cropHeight = contextSize.width / cropAspect
            posY = (contextSize.height - cropHeight) / 2
        } else if to.width < to.height { //Portrait
            cropHeight = contextSize.height
            cropWidth = contextSize.height * cropAspect
            posX = (contextSize.width - cropWidth) / 2
        } else { //Square
            if contextSize.width >= contextSize.height { //Square on landscape (or square)
                cropHeight = contextSize.height
                cropWidth = contextSize.height * cropAspect
                posX = (contextSize.width - cropWidth) / 2
            }else{ //Square on portrait
                cropWidth = contextSize.width
                cropHeight = contextSize.width / cropAspect
                posY = (contextSize.height - cropHeight) / 2
            }
        }
        
        let rect: CGRect = CGRect(x: posX, y: posY, width: cropWidth, height: cropHeight)
        
        // Create bitmap image from context using the rect
        let imageRef: CGImage = contextImage.cgImage!.cropping(to: rect)!
        
        // Create a new image based on the imageRef and rotate back to the original orientation
        let cropped: UIImage = UIImage(cgImage: imageRef, scale: self.scale, orientation: self.imageOrientation)
        
        UIGraphicsBeginImageContextWithOptions(to, true, self.scale)
        cropped.draw(in: CGRect(x: 0, y: 0, width: to.width, height: to.height))
        let resized = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return resized!
    }
}
