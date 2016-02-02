//
//  NavigationController.swift
//  PinGo
//
//  Created by GaoWanli on 16/1/16.
//  Copyright © 2016年 GWL. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
    
    override func prefersStatusBarHidden() -> Bool {
        return false
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.translucent = false
        interactivePopGestureRecognizer?.delegate = nil
    }
    
    override func pushViewController(viewController: UIViewController, animated: Bool) {
        if (self.viewControllers.count > 0) {
            viewController.hidesBottomBarWhenPushed = true
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back_red"), style: .Plain, target: self, action: "backButtonClick")
        }
        super.pushViewController(viewController, animated: true)
    }
    
    /// 返回按钮点击事件
    func backButtonClick() {
        popViewControllerAnimated(true)
    }
}
