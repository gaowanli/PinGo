//
//  VisitorCell.swift
//  PinGo
//
//  Created by GaoWanli on 16/1/31.
//  Copyright © 2016年 GWL. All rights reserved.
//

import UIKit

class VisitorCell: UITableViewCell {
    
    /// 用户头像
    @IBOutlet private weak var headIcon: UIImageView!
    /// 昵称
    @IBOutlet private weak var nickNameLabel: UILabel!
    /// 性别&年龄
    @IBOutlet private weak var sexAgeButton: UIButton!
    /// 星座
    @IBOutlet private weak var constellationButton: UIButton!
    /// 到访时间
    @IBOutlet private weak var visitorTimeLabel: UILabel!
    
    var visitorRecord: VisitorRecord? {
        didSet {
            let user = visitorRecord?.user
            
            let img = UIImage(named: "home_head")
            if let headUrlStr = user?.headUrl {
                if let headUrl = NSURL(string: headUrlStr) {
                    headIcon.kf_setImageWithURL(headUrl, placeholderImage: img)
                }else {
                    headIcon.image = img
                }
            }else {
                headIcon.image = img
            }
            
            nickNameLabel.text = user?.nickname
            if let age = user?.age {
                sexAgeButton.setTitle("\(age)", forState: .Normal)
            }
            
            if let constellation = user?.constellation {
                constellationButton.setTitle(constellation, forState: .Normal)
            }
            
            if user?.sex == 1 {
                sexAgeButton.setImage(UIImage(named: "woman_icon"), forState: .Normal)
            }else {
                sexAgeButton.setImage(UIImage(named: "man_icon"), forState: .Normal)
            }
            
            if let visitTime = visitorRecord?.visitTime {
                visitorTimeLabel.text = visitTime.dateString(toStyle: .Style1)
            }
        }
    }
}
