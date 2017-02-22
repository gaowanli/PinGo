//
//  ProfileHomeController.swift
//  PinGo
//
//  Created by GaoWanli on 16/1/31.
//  Copyright © 2016年 GWL. All rights reserved.
//

import UIKit

class ProfileHomeController: UIViewController {
    
    @IBOutlet fileprivate weak var headerView: UIView!
    @IBOutlet fileprivate weak var headImageView: UIImageView!
    @IBOutlet fileprivate weak var userNameLabel: UILabel!
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerView.backgroundColor = kAppearanceColor
        userNameLabel.text = "gaowanli"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}
