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

extension NSDate {
    
    class func formatterWithStyle(withStyle style: dateFormatStyle) -> NSDateFormatter {
        let formatter = kDateFormatter
        formatter.locale = NSLocale.currentLocale()
        formatter.dateFormat = style.rawValue
        return formatter
    }
    
    /**
     根据时间戳返回日期
     
     - parameter stamp: 时间戳字符串
     
     - returns: 日期
     */
    class func dateWithTimeStamp(stamp: String) -> NSDate? {
        if let interval = NSTimeInterval(stamp) {
            return NSDate(timeIntervalSince1970: interval / 1000.0)
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
            let formatter = NSDate.formatterWithStyle(withStyle: style)
            return formatter.stringFromDate(self)
        }
    }
    
    /**
     根据时间判断是否是今年
     
     - returns: ture of false
     */
    func isThisYear() -> Bool {
        let calendar = kCalendar
        let unit = NSCalendarUnit.Year
        
        let nowCmps = calendar.components(unit, fromDate: NSDate())
        let dCmps = calendar.components(unit, fromDate: self)
        return nowCmps.year == dCmps.year
    }
    
    /**
     根据时间判断是否是今天
     
     - returns: true of false
     */
    func isToday() -> Bool {
        let calendar = kCalendar
        let unit: NSCalendarUnit = [.Day, .Month, .Year]
        
        let nowCmps = calendar.components(unit, fromDate: NSDate())
        let dCmps = calendar.components(unit, fromDate: self)
        return nowCmps.day == dCmps.day && nowCmps.month == dCmps.month && nowCmps.year == dCmps.year
    }
    
    /**
     根据时间判断是否是昨天
     
     - returns: true of false
     */
    func isYestoday() -> Bool {
        return kCalendar.components(.Day, fromDate: self.dateFormat(), toDate: NSDate().dateFormat(), options: []).day == 1
    }
    
    func componentsDeltaWithNow() -> NSDateComponents {
        let calendar = kCalendar
        let unit: NSCalendarUnit = [.Day, .Hour, .Minute]
        return calendar.components(unit, fromDate: self, toDate: NSDate(), options: [])
    }
    
    private func dateFormat() -> NSDate {
        let formatter = NSDate.formatterWithStyle(withStyle: .Style1)
        let dateStr = formatter.stringFromDate(self)
        return formatter.dateFromString(dateStr)!
    }
}