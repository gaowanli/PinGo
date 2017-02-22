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
    @IBOutlet fileprivate weak var headIcon: UIImageView!
    /// 昵称
    @IBOutlet fileprivate weak var nickNameLabel: UILabel!
    /// 性别&年龄
    @IBOutlet fileprivate weak var sexAgeButton: UIButton!
    /// 星座
    @IBOutlet fileprivate weak var constellationButton: UIButton!
    /// 到访时间
    @IBOutlet fileprivate weak var visitorTimeLabel: UILabel!
    
    var visitorRecord: VisitorRecord? {
        didSet {
            let user = visitorRecord?.user
            
            let img = UIImage(named: "home_head")
            if let headUrlStr = user?.headUrl {
                if let headUrl = URL(string: headUrlStr) {
                    headIcon.kf.setImage(with: headUrl, placeholder: img)
                }else {
                    headIcon.image = img
                }
            }else {
                headIcon.image = img
            }
            
            nickNameLabel.text = user?.nickname
            if let age = user?.age {
                sexAgeButton.setTitle("\(age)", for: UIControlState())
            } 
            
            if user?.sex == 1 {
                sexAgeButton.setImage(UIImage(named: "woman_icon"), for: UIControlState())
            }else {
                sexAgeButton.setImage(UIImage(named: "man_icon"), for: UIControlState())
            }
            
            if let visitTime = visitorRecord?.visitTime {
                visitorTimeLabel.text = visitTime.dateString(toStyle: .Style1)
            }
        }
    }
}
