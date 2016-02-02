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
    @IBOutlet private weak var goldLabel: UILabel!
    /// 等级
    @IBOutlet private weak var levelLabel: UILabel!
    /// 签到天数
    @IBOutlet private weak var signinLabel: UILabel!
    /// 签到天数宽度约束
    @IBOutlet private weak var signinLabelWidthConstraint: NSLayoutConstraint!
    /// 签到天数
    private let signinDay = arc4random_uniform(2)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        goldLabel.text = "25金币"
        levelLabel.text = "LV5"
        
        var extW: CGFloat = 0.0
        if signinDay > 0 {
            signinLabel.text = "已签到7天"
        }else {
            signinLabel.backgroundColor = kSigninLabelColor
            signinLabel.textColor = UIColor.whiteColor()
            signinLabel.layer.cornerRadius = 8
            signinLabel.layer.masksToBounds = true
            signinLabel.text = "未签到"
            extW = 10.0
        }
        signinLabel.sizeToFit()
        signinLabelWidthConstraint.constant = CGRectGetWidth(signinLabel.bounds) + extW
    }
}

// MARK: - Table view data source
extension ProfileController {
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 10.0
        }
        return 5.0
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        setSigninLabelBackgroundColor(indexPath)
    }
    
    override func tableView(tableView: UITableView, didHighlightRowAtIndexPath indexPath: NSIndexPath) {
        setSigninLabelBackgroundColor(indexPath)
    }
    
    private func setSigninLabelBackgroundColor(indexPath: NSIndexPath) {
        if 1 == indexPath.section && 0 == indexPath.row && signinDay <= 0 {
            signinLabel.backgroundColor = kSigninLabelColor
        }
    }
}
