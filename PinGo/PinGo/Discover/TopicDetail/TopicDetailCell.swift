//
//  TopicDetailCell.swift
//  PinGo
//
//  Created by GaoWanli on 16/2/4.
//  Copyright © 2016年 GWL. All rights reserved.
//

import UIKit

class TopicDetailCell: UICollectionViewCell {
    
    @IBOutlet fileprivate weak var userIconbutton: UIButton!
    @IBOutlet fileprivate weak var userNameLabel: UILabel!
    @IBOutlet fileprivate weak var startNumButton: UIButton!
    @IBOutlet fileprivate weak var bgImageView: UIImageView!
    @IBOutlet fileprivate weak var descLabel: UILabel!
    @IBOutlet fileprivate weak var startButton: UIButton!
    
    var topicInfo: TopicInfo? {
        didSet {
            if let user = topicInfo?.userInfo {
                if let headUrlStr = user.headUrl {
                    if let headUrl = URL(string: headUrlStr) {
                        userIconbutton.kf.setBackgroundImage(with: headUrl, for: .normal)
                    }
                }
                
                userNameLabel.text = user.nickname
            }
            
            startButton.setTitle(topicInfo?.commentCnt, for: UIControlState())
            
            if let resUrlStr = topicInfo?.resUrl {
                if let resUrl = URL(string: resUrlStr) {
                    bgImageView.kf.setImage(with: resUrl)
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
