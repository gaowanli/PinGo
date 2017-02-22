//
//  DiscoverHomeController.swift
//  PinGo
//
//  Created by GaoWanli on 16/1/31.
//  Copyright © 2016年 GWL. All rights reserved.
//

import UIKit

class DiscoverHomeController: UIViewController {

    @IBOutlet fileprivate weak var discoverContainerView: UIView!
    @IBOutlet fileprivate weak var topicContainerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.titleView = topMenu
    }
    
    // MARK: lazy loading
    fileprivate lazy var topMenu: TopMenu = {
        let t = TopMenu.loadFromNib()
        t.showText = ("话题", "广场")
        t.delegate = self
        return t
    }()
}

extension DiscoverHomeController: TopMenuDelegate {
    
    func topMenu(_ topMenu: TopMenu, didClickButton index: Int) {
        self.discoverContainerView.isHidden = (index == 1)
        self.topicContainerView.isHidden = !discoverContainerView.isHidden
    }
}
