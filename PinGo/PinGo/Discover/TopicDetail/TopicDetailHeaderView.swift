//
//  TopicDetailHeaderView.swift
//  PinGo
//
//  Created by GaoWanli on 16/2/4.
//  Copyright © 2016年 GWL. All rights reserved.
//

import UIKit

class TopicDetailHeaderView: UIView {
    
    @IBOutlet private weak var backgroundImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var contentLabel: UILabel!
    @IBOutlet private var userIconButtons: [UIButton]!
    @IBOutlet private weak var followButton: UIButton!
    
    var showDataList: (SubjectInfo?, [User]?) {
        didSet {
            if let info = showDataList.0 {
                if let bgImgUrlStr = info.imageUrl {
                    if let bgImgUrl = NSURL(string: bgImgUrlStr) {
                        backgroundImageView.kf_setImageWithURL(bgImgUrl)
                    }
                }
                titleLabel.text = info.title
                contentLabel.text = info.desc
            }
            
            if let mUser = showDataList.1 {
                var index = 0
                for user in mUser {
                    if let headUrlStr = user.headUrl {
                        guard index < userIconButtons.count else {
                            return
                        }
                        
                        if let headUrl = NSURL(string: headUrlStr) {
                            userIconButtons[index].hidden = false
                            userIconButtons[index].kf_setBackgroundImageWithURL(headUrl, forState: .Normal)
                        }
                        index++
                    }
                }
            }
        }
    }
    
    class func loadFromNib() -> TopicDetailHeaderView {
        return NSBundle.mainBundle().loadNibNamed("TopicDetailHeader", owner: self, options: nil).last as! TopicDetailHeaderView
    }
    
    @IBAction func userIconButtonClick(sender: AnyObject) {
    }
    
    @IBAction func followButtonClick(sender: AnyObject) {
    }
}
