//
//  ProfileHomeController.swift
//  PinGo
//
//  Created by GaoWanli on 16/1/31.
//  Copyright © 2016年 GWL. All rights reserved.
//

import UIKit

class ProfileHomeController: UIViewController {
    
    @IBOutlet private weak var headerView: UIView!
    @IBOutlet private weak var headImageView: UIImageView!
    @IBOutlet private weak var userNameLabel: UILabel!
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerView.backgroundColor = kAppearanceColor
        userNameLabel.text = "gaowanli"
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}
