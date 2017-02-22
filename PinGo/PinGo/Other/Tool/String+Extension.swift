//
//  String+Extension.swift
//  PinGo
//
//  Created by GaoWanli on 16/1/31.
//  Copyright © 2016年 GWL. All rights reserved.
//

import UIKit

extension String {
    
    static func size(withText text: String, withFont font: UIFont, andMaxSize maxSize: CGSize) -> CGSize {
        return text.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [ NSFontAttributeName: font ], context: nil).size
    }
    
    /**
     根据日期字符串计算年龄
     
     - parameter style: 日期字符串格式
     
     - returns: 年龄
     */
    func age(withStyle style: dateFormatStyle) -> Int {
        if let date = Date.formatterWithStyle(withStyle: style).date(from: self) {
            let interval = date.timeIntervalSinceNow
            return abs(Int(trunc(interval / (60 * 60 * 24)) / 365))
        }
        return 0
    }
    
    /**
     根据时间戳转换显示字符串
     
     - parameter style: 要转换成的格式
     
     - returns: 格式化后的字符串
     */
    func dateString(toStyle style: dateFormatStyle) -> String? {
        if let date = Date.dateWithTimeStamp(self) {
            let components = date.componentsDeltaWithNow()
            if components.day! <= 5 {
                if (components.day! < 1) {
                    return "\(components.hour)小时前"
                }else {
                    return "\(components.day)天前"
                }
            }else {
                return date.string(withStyle: style)
            }
        }
        return nil
    }
}
