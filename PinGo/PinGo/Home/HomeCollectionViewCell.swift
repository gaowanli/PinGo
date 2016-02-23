//
//  HomeCollectionViewCell.swift
//  PinGo
//
//  Created by GaoWanli on 16/1/16.
//  Copyright © 2016年 GWL. All rights reserved.
//

import UIKit
import Kingfisher

enum HomeCollectionViewCellButtonType: Int {
    case Tag     // tag
    case Chat    // 私聊
    case Comment // 评论
    case Star    // star
}

protocol HomeCollectionViewCellDelegate: NSObjectProtocol {
    
    /**
     点击了某个按钮
     
     - parameter cell:     cell
     - parameter button:   按钮
     - parameter btnType:  按钮类型
     - parameter topiInfo: 数据模型
     */
    func homeCollectionViewCell(cell: HomeCollectionViewCell, didClickButton button: UIButton, withButtonType btnType: HomeCollectionViewCellButtonType, withTopiInfo topiInfo: TopicInfo)
}

class HomeCollectionViewCell: UICollectionViewCell {
    
    /// 背景图片
    @IBOutlet private weak var bgImageView: UIImageView!
    /// 头像按钮
    @IBOutlet private weak var headButton: UIButton!
    /// icon标识
    @IBOutlet private weak var headIcon: UIButton!
    /// tag标签按钮
    @IBOutlet private weak var tagButton: UIButton!
    /// 描述文字Label
    @IBOutlet private weak var describeLabel: UILabel!
    /// 月label
    @IBOutlet private weak var monthLabel: UILabel!
    /// 日label
    @IBOutlet private weak var dayLabel: UILabel!
    /// 年label
    @IBOutlet private weak var yearLabel: UILabel!
    /// 底部工具条
    @IBOutlet private weak var toolbarView: ToolbarView!
    /// 评论按钮
    @IBOutlet private weak var commentButton: UIButton!
    /// star按钮
    @IBOutlet private weak var starButton: UIButton!
    
    weak var delegate: HomeCollectionViewCellDelegate?
    
    var topiInfo: TopicInfo? {
        didSet {
            if let bgImageUrlStr = topiInfo?.resUrl {
                if let bgImageUrl = NSURL(string: bgImageUrlStr) {
                    bgImageView.kf_setImageWithURL(bgImageUrl)
                }
            }
            
            if let headUrlStr = topiInfo?.userInfo?.headUrl {
                let img = UIImage(named: "home_head")
                if let headUrl = NSURL(string: headUrlStr) {
                    headButton.kf_setBackgroundImageWithURL(headUrl, forState: .Normal, placeholderImage: img)
                }else {
                    headButton.setImage(img, forState: .Normal)
                }
            }
            
            if let userHeat = topiInfo?.userInfo?.heat {
                if userHeat == 1 {
                    headIcon.hidden = false
                    headIcon.setImage(UIImage(named: "home_head_star"), forState: .Normal)
                }else {
                    headIcon.hidden = true
                }
            }
            
            if let tagTitle = topiInfo?.subjectTitle {
                if tagTitle != "" {
                    tagButton.hidden = false
                    tagButton.setTitle("  #\(tagTitle)  " , forState: .Normal)
                }else {
                    tagButton.hidden = true
                }
            }
            
            describeLabel.text = topiInfo?.content
            
            if let pubTime = topiInfo?.pubTime {
                let pubDate = NSDate(timeIntervalSince1970: NSTimeInterval(pubTime)! / 1000.0)
                var components = kCalendar.components(.Month, fromDate: pubDate)
                monthLabel.text = "\(components.month)月"
                components = kCalendar.components(.Day, fromDate: pubDate)
                dayLabel.text = "\(components.day)"
                components = kCalendar.components(.Year, fromDate: pubDate)
                yearLabel.text = "\(components.year)"
            }
            
            if let commentNum = topiInfo?.commentCnt {
                if Int(commentNum) > 999 {
                    commentButton.setTitle("999+", forState: .Normal)
                }else if Int(commentNum) == 0 {
                    commentButton.setTitle("评论", forState: .Normal)
                }else {
                    commentButton.setTitle("\(commentNum)", forState: .Normal)
                }
            }
            
            if let starNum = topiInfo?.praiseCnt {
                if Int(starNum) > 999 {
                    starButton.setTitle("999+", forState: .Normal)
                }else {
                    starButton.setTitle("\(starNum)", forState: .Normal)
                }
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = 5
        layer.masksToBounds = true
    }
    
    /// 按钮点击事件
    @IBAction func buttonClick(sender: UIButton) {
        delegate?.homeCollectionViewCell(self, didClickButton: sender, withButtonType: HomeCollectionViewCellButtonType(rawValue: sender.tag)!, withTopiInfo: topiInfo!)
    }
}

class ToolbarView: UIView {
    override func drawRect(rect: CGRect) {
        let path = UIBezierPath(rect: CGRectMake(0, 0, bounds.size.width, 0.2))
        UIColor.lightGrayColor().setFill()
        path.fill()
    }
}
