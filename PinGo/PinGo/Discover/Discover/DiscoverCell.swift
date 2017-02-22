//
//  DiscoverCell.swift
//  PinGo
//
//  Created by GaoWanli on 16/2/1.
//  Copyright © 2016年 GWL. All rights reserved.
//

import UIKit

class DiscoverCell: UICollectionViewCell {
    
    @IBOutlet fileprivate weak var imageView: UIImageView!
    @IBOutlet fileprivate weak var describeLabel: UILabel!
    @IBOutlet fileprivate weak var visitorButton: UIButton!
    @IBOutlet fileprivate weak var picButton: UIButton!
    
    var subjectInfo: SubjectInfo? {
        didSet {
            if let urlStr = subjectInfo?.imageUrl {
                if let url = URL(string: urlStr) {
                    imageView.kf.setImage(with: url)
                }
            }
            describeLabel.text = subjectInfo?.title
            
            if let visitorNum = subjectInfo?.readCnt {
                visitorButton.setTitle(numToString(visitorNum), for: UIControlState())
            }
            
            if let picNum = subjectInfo?.topicCnt {
                picButton.setTitle(numToString(picNum), for: UIControlState())
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = 3
        layer.masksToBounds = true
    }
    
    fileprivate func numToString(_ num: Int) -> String {
        if num > 999 {
            let kNum = Double(num) / 1000.0
            if kNum > 999 {
                return "999k+"
            }
            return String(format: "%.1f", kNum) + "k"
        }else {
            return String(num)
        }
    }
}
