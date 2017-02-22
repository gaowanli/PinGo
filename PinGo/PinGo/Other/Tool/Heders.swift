//
//  Heders.swift
//  PinGo
//
//  Created by GaoWanli on 16/1/16.
//  Copyright © 2016年 GWL. All rights reserved.
//

import Foundation
import UIKit

let iOS9Later              = (UIDevice.current.systemVersion as NSString).doubleValue >= 9.0
let iPhone4s               = (UIScreen.main.bounds.size.width == 320)
let kNavBarHeight: CGFloat = 64.0
let kTabBarHeight: CGFloat = 49.0
let kScreenWidth           = UIScreen.main.bounds.width
let kScreenHeight          = UIScreen.main.bounds.height
/// 统一的外观颜色
let kAppearanceColor       = UIColor.colorWithRGBA(250, G: 60, B: 67)
/// 主要的字体
let kMainFont              = UIFont.fontWithSize(15.0)
let kNavigationBarFont     = UIFont.fontWithSize(16)
let kCalendar              = Calendar.current
let kDateFormatter         = DateFormatter()

enum QueryMethod {
    case new     // 获取最新数据
    case old     // 获取旧数据
}
