//
//  String+Extension.swift
//  PinGo
//
//  Created by GaoWanli on 16/1/31.
//  Copyright © 2016年 GWL. All rights reserved.
//

import UIKit

extension String {
    
    /**
     根据日期字符串计算年龄
     
     - parameter style: 日期字符串格式
     
     - returns: 年龄
     */
    func age(withStyle style: dateFormatStyle) -> Int {
        if let date = NSDate.formatterWithStyle(withStyle: style).dateFromString(self) {
            let interval = date.timeIntervalSinceNow
            return abs(Int(trunc(interval / (60 * 60 * 24)) / 365))
        }
        return 0
    }
    
    /**
     根据日期字符串计算星座
     
     - parameter style: 日期字符串格式
     
     - returns: 星座
     */
    func constellation(withStyle style: dateFormatStyle) -> String? {
        switch style {
        case .Style1:
            if (self as NSString).containsString("-") {
                let dates = self.componentsSeparatedByString("-")
                guard dates.count == 3 else {
                    return nil
                }
                return constellationWithMonth(month: Int(dates[1]), day: Int(dates[2]))
            }
            return nil
        }
    }
    
    /**
     根据时间戳转换显示字符串
     
     - parameter style: 要转换成的格式
     
     - returns: 格式化后的字符串
     */
    func dateString(toStyle style: dateFormatStyle) -> String? {
        if let date = NSDate.dateWithTimeStamp(self) {
            let components = date.componentsDeltaWithNow()
            if components.day <= 5 {
                if (components.day < 1) {
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
    
    private func constellationWithMonth(month month: Int?, day: Int?) -> String? {
        guard month != nil && day != nil else {
            return nil
        }
        let astroStr: NSString = "摩羯座水瓶座双鱼座白羊座金牛座双子座巨蟹座狮子座处女座天秤座天蝎座射手座摩羯座"
        let astroFormat: NSString = "102123444543"
        let range = NSMakeRange(month! * 3 - Int(day < Int(astroFormat.substringWithRange(NSMakeRange(month! - 1, 1)))! - (-19)) * 3, 3)
        return astroStr.substringWithRange(range)
    }
}