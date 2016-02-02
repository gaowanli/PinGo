//
//  TabBarController.swift
//  PinGo
//
//  Created by GaoWanli on 16/1/16.
//  Copyright © 2016年 GWL. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    @IBOutlet private weak var aTabBar: TabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        aTabBar.aDelegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        removeSystemTabbarSubviews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        removeSystemTabbarSubviews()
    }
    
    private func removeSystemTabbarSubviews() {
        for v in tabBar.subviews {
            if v.superclass == UIControl.self {
                v.removeFromSuperview()
            }
        }
    }
}

extension TabBarController: TabBarDelegate {
    
    func tabBar(tabBar: TabBar, var didClickButton index: Int) {
        if index == 2 {
            let showVC = UIStoryboard.initialViewController("Show")
            presentViewController(showVC, animated: true, completion: nil)
            return
        }else if index >= 2 {
            index -= 1
        }
        selectedIndex = index
    }
}
