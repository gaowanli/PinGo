//
//  TopicDetailCell.swift
//  PinGo
//
//  Created by GaoWanli on 16/2/4.
//  Copyright © 2016年 GWL. All rights reserved.
//

import UIKit

class TopicDetailCell: UICollectionViewCell {
    
    @IBOutlet private weak var userIconbutton: UIButton!
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var startNumButton: UIButton!
    @IBOutlet private weak var bgImageView: UIImageView!
    @IBOutlet private weak var descLabel: UILabel!
    @IBOutlet private weak var startButton: UIButton!
    
    var topicInfo: TopicInfo? {
        didSet {
            if let user = topicInfo?.userInfo {
                if let headUrlStr = user.headUrl {
                    if let headUrl = NSURL(string: headUrlStr) {
                        userIconbutton.kf_setBackgroundImageWithURL(headUrl, forState: .Normal)
                    }
                }
                
                userNameLabel.text = user.nickname
            }
            
            startButton.setTitle(topicInfo?.commentCnt, forState: .Normal)
            
            if let resUrlStr = topicInfo?.resUrl {
                if let resUrl = NSURL(string: resUrlStr) {
                    bgImageView.kf_setImageWithURL(resUrl)
                }
            }
            
            descLabel.text = topicInfo?.content
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = 5
        layer.masksToBounds = true
    }
}
