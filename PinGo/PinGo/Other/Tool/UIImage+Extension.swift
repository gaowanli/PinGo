//
//  UIImage+Extension.swift
//  PinGo
//
//  Created by GaoWanli on 16/1/16.
//  Copyright © 2016年 GWL. All rights reserved.
//

import UIKit

extension UIImage {
    /**
    根据颜色和尺寸生成一张图片
    
    - parameter color: 颜色
    - parameter size:  尺寸
    
    - returns: 图片
    */
    class func imageWithColor(_ color: UIColor, size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: size.width, height: size.height), true, UIScreen.main.scale)
        color.set()
        UIRectFill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
