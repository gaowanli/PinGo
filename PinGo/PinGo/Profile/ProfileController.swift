//
//  ProfileController.swift
//  PinGo
//
//  Created by GaoWanli on 16/1/31.
//  Copyright © 2016年 GWL. All rights reserved.
//

import UIKit

private let kSigninLabelColor = UIColor.colorWithRGBA(255, G: 182, B: 0)

class ProfileController: UITableViewController {
    
    /// 金币
    @IBOutlet fileprivate weak var goldLabel: UILabel!
    /// 等级
    @IBOutlet fileprivate weak var levelLabel: UILabel!
    /// 签到天数
    @IBOutlet fileprivate weak var signinLabel: UILabel!
    /// 签到天数宽度约束
    @IBOutlet fileprivate weak var signinLabelWidthConstraint: NSLayoutConstraint!
    /// 签到天数
    fileprivate let signinDay = arc4random_uniform(2)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        goldLabel.text = "25金币"
        levelLabel.text = "LV5"
        
        var extW: CGFloat = 0.0
        if signinDay > 0 {
            signinLabel.text = "已签到7天"
        }else {
            signinLabel.backgroundColor = kSigninLabelColor
            signinLabel.textColor = UIColor.white
            signinLabel.layer.cornerRadius = 8
            signinLabel.layer.masksToBounds = true
            signinLabel.text = "未签到"
            extW = 10.0
        }
        signinLabel.sizeToFit()
        signinLabelWidthConstraint.constant = signinLabel.bounds.width + extW
    }
}

// MARK: - Table view data source
extension ProfileController {
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 10.0
        }
        return 5.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        setSigninLabelBackgroundColor(indexPath)
    }
    
    override func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        setSigninLabelBackgroundColor(indexPath)
    }
    
    fileprivate func setSigninLabelBackgroundColor(_ indexPath: IndexPath) {
        if 1 == indexPath.section && 0 == indexPath.row && signinDay <= 0 {
            signinLabel.backgroundColor = kSigninLabelColor
        }
    }
}
