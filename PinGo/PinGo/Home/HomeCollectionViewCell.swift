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
    case tag     // tag
    case chat    // 私聊
    case comment // 评论
    case star    // star
}

protocol HomeCollectionViewCellDelegate: NSObjectProtocol {
    
    /**
     点击了某个按钮
     
     - parameter cell:     cell
     - parameter button:   按钮
     - parameter btnType:  按钮类型
     - parameter topiInfo: 数据模型
     */
    func homeCollectionViewCell(_ cell: HomeCollectionViewCell, didClickButton button: UIButton, withButtonType btnType: HomeCollectionViewCellButtonType, withTopiInfo topiInfo: TopicInfo)
}

class HomeCollectionViewCell: UICollectionViewCell {
    
    /// 背景图片
    @IBOutlet fileprivate weak var bgImageView: UIImageView!
    /// 头像按钮
    @IBOutlet fileprivate weak var headButton: UIButton!
    /// icon标识
    @IBOutlet fileprivate weak var headIcon: UIButton!
    /// tag标签按钮
    @IBOutlet fileprivate weak var tagButton: UIButton!
    /// 描述文字Label
    @IBOutlet fileprivate weak var describeLabel: UILabel!
    /// 月label
    @IBOutlet fileprivate weak var monthLabel: UILabel!
    /// 日label
    @IBOutlet fileprivate weak var dayLabel: UILabel!
    /// 年label
    @IBOutlet fileprivate weak var yearLabel: UILabel!
    /// 底部工具条
    @IBOutlet fileprivate weak var toolbarView: ToolbarView!
    /// 评论按钮
    @IBOutlet fileprivate weak var commentButton: UIButton!
    /// star按钮
    @IBOutlet fileprivate weak var starButton: UIButton!
    
    weak var delegate: HomeCollectionViewCellDelegate?
    
    var topiInfo: TopicInfo? {
        didSet {
            if let bgImageUrlStr = topiInfo?.resUrl {
                if let bgImageUrl = URL(string: bgImageUrlStr) {
                    bgImageView.kf.setImage(with: bgImageUrl)
                }
            }
            
            if let headUrlStr = topiInfo?.userInfo?.headUrl {
                let img = UIImage(named: "home_head")
                if let headUrl = URL(string: headUrlStr) {
                    headButton.kf.setBackgroundImage(with: headUrl, for: .normal, placeholder: img)
                }else {
                    headButton.setImage(img, for: UIControlState())
                }
            }
            
            if let userHeat = topiInfo?.userInfo?.heat {
                if userHeat == 1 {
                    headIcon.isHidden = false
                    headIcon.setImage(UIImage(named: "home_head_star"), for: UIControlState())
                }else {
                    headIcon.isHidden = true
                }
            }
            
            if let tagTitle = topiInfo?.subjectTitle {
                if tagTitle != "" {
                    tagButton.isHidden = false
                    tagButton.setTitle("  #\(tagTitle)  " , for: UIControlState())
                }else {
                    tagButton.isHidden = true
                }
            }
            
            describeLabel.text = topiInfo?.content
            
            if let pubTime = topiInfo?.pubTime {
                let pubDate = Date(timeIntervalSince1970: TimeInterval(pubTime)! / 1000.0)
                var components = (kCalendar as NSCalendar).components(.month, from: pubDate)
                if let month = components.month {
                    monthLabel.text = "\(month)月"
                }
                
                components = (kCalendar as NSCalendar).components(.day, from: pubDate)
                if let day = components.day {
                    dayLabel.text = "\(day)"
                }
                
                components = (kCalendar as NSCalendar).components(.year, from: pubDate)
                if let year = components.year {
                    yearLabel.text = "\(year)"
                }
            }
            
            if let commentNum = topiInfo?.commentCnt {
                if let `commentNum` = Int(commentNum) {
                    if `commentNum` > 999 {
                        commentButton.setTitle("999+", for: UIControlState())
                    }else if `commentNum` == 0 {
                        commentButton.setTitle("评论", for: UIControlState())
                    }else {
                        commentButton.setTitle("\(commentNum)", for: UIControlState())
                    }
                }
            }
            
            if let starNum = topiInfo?.praiseCnt {
                if starNum > 999 {
                    starButton.setTitle("999+", for: UIControlState())
                }else {
                    starButton.setTitle("\(starNum)", for: UIControlState())
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
    @IBAction func buttonClick(_ sender: UIButton) {
        delegate?.homeCollectionViewCell(self, didClickButton: sender, withButtonType: HomeCollectionViewCellButtonType(rawValue: sender.tag)!, withTopiInfo: topiInfo!)
    }
}

class ToolbarView: UIView {
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: bounds.size.width, height: 0.2))
        UIColor.lightGray.setFill()
        path.fill()
    }
}
