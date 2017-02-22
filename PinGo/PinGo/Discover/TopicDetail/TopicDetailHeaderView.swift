//
//  TopicDetailHeaderView.swift
//  PinGo
//
//  Created by GaoWanli on 16/2/4.
//  Copyright © 2016年 GWL. All rights reserved.
//

import UIKit

class TopicDetailHeaderView: UIView {
    
    @IBOutlet fileprivate weak var backgroundImageView: UIImageView!
    @IBOutlet fileprivate weak var titleLabel: UILabel!
    @IBOutlet fileprivate weak var contentLabel: UILabel!
    @IBOutlet fileprivate var userIconButtons: [UIButton]!
    @IBOutlet fileprivate weak var followButton: UIButton!
    
    var showDataList: (SubjectInfo?, [User]?) {
        didSet {
            if let info = showDataList.0 {
                if let bgImgUrlStr = info.imageUrl {
                    if let bgImgUrl = URL(string: bgImgUrlStr) {
                        backgroundImageView.kf.setImage(with: bgImgUrl)
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
                        
                        if let headUrl = URL(string: headUrlStr) {
                            userIconButtons[index].isHidden = false
                            userIconButtons[index].kf.setImage(with: headUrl, for: .normal)
                        }
                        index += 1
                    }
                }
            }
        }
    }
    
    class func loadFromNib() -> TopicDetailHeaderView {
        return Bundle.main.loadNibNamed("TopicDetailHeader", owner: self, options: nil)!.last as! TopicDetailHeaderView
    }
    
    @IBAction func userIconButtonClick(_ sender: AnyObject) {
    }
    
    @IBAction func followButtonClick(_ sender: AnyObject) {
    }
}
