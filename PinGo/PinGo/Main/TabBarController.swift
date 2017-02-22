//
//  TabBarController.swift
//  PinGo
//
//  Created by GaoWanli on 16/1/16.
//  Copyright © 2016年 GWL. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    @IBOutlet fileprivate weak var aTabBar: TabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        aTabBar.aDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        removeSystemTabbarSubviews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        removeSystemTabbarSubviews()
    }
    
    fileprivate func removeSystemTabbarSubviews() {
        for v in tabBar.subviews {
            if v.superclass == UIControl.self {
                v.removeFromSuperview()
            }
        }
    }
}

extension TabBarController: TabBarDelegate {
    
    func tabBar(_ tabBar: TabBar, didClickButton index: Int) {
        var index = index
        if index == 2 {
            let showVC = UIStoryboard.initialViewController("Show")
            present(showVC, animated: true, completion: nil)
            return
        }else if index >= 2 {
            index -= 1
        }
        selectedIndex = index
    }
}
