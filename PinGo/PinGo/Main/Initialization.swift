//
//  Initialization.swift
//  PinGo
//
//  Created by GaoWanli on 16/1/16.
//  Copyright © 2016年 GWL. All rights reserved.
//

import UIKit

class Initialization: NSObject {
    /// 初始化外观
    class func initializationAppearance(window: UIWindow?) {
        
        window?.backgroundColor = UIColor.whiteColor()
        
        let navBar = UINavigationBar.appearance()
        let navBarSize = CGSizeMake(UIScreen.mainScreen().bounds.width, 64)
        let navBarImage = UIImage.imageWithColor(kAppearanceColor, size: navBarSize)
        navBar.setBackgroundImage(navBarImage, forBarMetrics: .Default)
        navBar.shadowImage = UIImage()
        navBar.tintColor = UIColor.whiteColor()
        
        navBar.titleTextAttributes = [
            NSFontAttributeName: kNavigationBarFont,
            NSForegroundColorAttributeName: UIColor.whiteColor()
        ]
     
        let tabBar = UITabBar.appearance()
        tabBar.translucent = false
    }
}
