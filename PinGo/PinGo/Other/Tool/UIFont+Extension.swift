
//
//  UIFont+Extension.swift
//  PinGo
//
//  Created by GaoWanli on 16/1/16.
//  Copyright © 2016年 GWL. All rights reserved.
//

import UIKit

extension UIFont {
    /**
     返回自定义的字体
     
     - parameter size: 需要的字体大小
     
     - returns: 返回自定义的字体
     */
    class func fontWithSize(size: CGFloat) -> UIFont {
        if let font = UIFont.init(name: "BigYoungMediumGB2.0", size: size) {
            return font
        }
        return UIFont.systemFontOfSize(size)
    }
}