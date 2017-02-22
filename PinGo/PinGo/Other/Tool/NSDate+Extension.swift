//
//  NSDate+Extension.swift
//  PinGo
//
//  Created by GaoWanli on 16/1/31.
//  Copyright © 2016年 GWL. All rights reserved.
//

import Foundation

enum dateFormatStyle: String {
    case Style1 = "yyyy-MM-dd"
}

extension Date {
    
    static func formatterWithStyle(withStyle style: dateFormatStyle) -> DateFormatter {
        let formatter = kDateFormatter
        formatter.locale = Locale.current
        formatter.dateFormat = style.rawValue
        return formatter
    }
    
    /**
     根据时间戳返回日期
     
     - parameter stamp: 时间戳字符串
     
     - returns: 日期
     */
    static func dateWithTimeStamp(_ stamp: String) -> Date? {
        if let interval = TimeInterval(stamp) {
            return Date(timeIntervalSince1970: interval / 1000.0)
        }
        return nil
    }
    
    /**
     根据日期返回字符串格式
     
     - returns: 日期字符串
     */
    func string(withStyle style: dateFormatStyle) -> String? {
        switch style {
        case .Style1:
            let formatter = Date.formatterWithStyle(withStyle: style)
            return formatter.string(from: self)
        }
    }
    
    /**
     根据时间判断是否是今年
     
     - returns: ture of false
     */
    func isThisYear() -> Bool {
        let calendar = kCalendar
        let unit = NSCalendar.Unit.year
        
        let nowCmps = (calendar as NSCalendar).components(unit, from: Date())
        let dCmps = (calendar as NSCalendar).components(unit, from: self)
        return nowCmps.year == dCmps.year
    }
    
    /**
     根据时间判断是否是今天
     
     - returns: true of false
     */
    func isToday() -> Bool {
        let calendar = kCalendar
        let unit: NSCalendar.Unit = [.day, .month, .year]
        
        let nowCmps = (calendar as NSCalendar).components(unit, from: Date())
        let dCmps = (calendar as NSCalendar).components(unit, from: self)
        return nowCmps.day == dCmps.day && nowCmps.month == dCmps.month && nowCmps.year == dCmps.year
    }
    
    /**
     根据时间判断是否是昨天
     
     - returns: true of false
     */
    func isYestoday() -> Bool {
        return (kCalendar as NSCalendar).components(.day, from: self.dateFormat(), to: Date().dateFormat(), options: []).day == 1
    }
    
    func componentsDeltaWithNow() -> DateComponents {
        let calendar = kCalendar
        let unit: NSCalendar.Unit = [.day, .hour, .minute]
        return (calendar as NSCalendar).components(unit, from: self, to: Date(), options: [])
    }
    
    fileprivate func dateFormat() -> Date {
        let formatter = Date.formatterWithStyle(withStyle: .Style1)
        let dateStr = formatter.string(from: self)
        return formatter.date(from: dateStr)!
    }
}
