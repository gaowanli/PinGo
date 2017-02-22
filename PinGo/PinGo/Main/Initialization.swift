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
    class func initializationAppearance(_ window: UIWindow?) {
        
        window?.backgroundColor = UIColor.white
        
        let navBar = UINavigationBar.appearance()
        let navBarSize = CGSize(width: UIScreen.main.bounds.width, height: 64)
        let navBarImage = UIImage.imageWithColor(kAppearanceColor, size: navBarSize)
        navBar.setBackgroundImage(navBarImage, for: .default)
        navBar.shadowImage = UIImage()
        navBar.tintColor = UIColor.white
        
        navBar.titleTextAttributes = [
            NSFontAttributeName: kNavigationBarFont,
            NSForegroundColorAttributeName: UIColor.white
        ]
     
        let tabBar = UITabBar.appearance()
        tabBar.isTranslucent = false
    }
}
