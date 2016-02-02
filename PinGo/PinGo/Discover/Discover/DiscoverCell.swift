//
//  DiscoverCell.swift
//  PinGo
//
//  Created by GaoWanli on 16/2/1.
//  Copyright © 2016年 GWL. All rights reserved.
//

import UIKit

class DiscoverCell: UICollectionViewCell {
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var describeLabel: UILabel!
    @IBOutlet private weak var visitorButton: UIButton!
    @IBOutlet private weak var picButton: UIButton!
    
    var subjectInfo: SubjectInfo? {
        didSet {
            if let urlStr = subjectInfo?.imageUrl {
                if let url = NSURL(string: urlStr) {
                    imageView.kf_setImageWithURL(url)
                }
            }
            describeLabel.text = subjectInfo?.title
            
            if let visitorNum = subjectInfo?.readCnt {
                visitorButton.setTitle(numToString(visitorNum), forState: .Normal)
            }
            
            if let picNum = subjectInfo?.topicCnt {
                picButton.setTitle(numToString(picNum), forState: .Normal)
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = 3
        layer.masksToBounds = true
    }
    
    private func numToString(num: Int) -> String {
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
