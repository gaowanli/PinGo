//
//  TopicHeaderView.swift
//  PinGo
//
//  Created by GaoWanli on 16/2/2.
//  Copyright © 2016年 GWL. All rights reserved.
//

import UIKit

protocol TopicHeaderViewDelegate: NSObjectProtocol {
    
    /**
     点击了某个按钮
     
     - parameter headerView:   view
     - parameter button: 按钮
     */
    func topicHeaderView(_ headerView: TopicHeaderView, didClickButton button: UIButton)
}

class TopicHeaderView: UIView {
    
    @IBOutlet fileprivate weak var topView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        topView.addSubview(imageCarouselView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageCarouselView.frame = topView.bounds
    }
    
    var bannerList: [Banner]? {
        didSet {
            imageCarouselView.bannerList = bannerList
        }
    }
    
    func scrollImage() {
        imageCarouselView.startTimer()
    }
    
    func stopScrollImage() {
        imageCarouselView.stopTimer()
    }
    
    @IBAction func buttonClick(_ sender: UITapGestureRecognizer) {
        if let view = sender.view {
            print(view.tag)
        }
    }
    
    class func loadFromNib() -> TopicHeaderView {
        return Bundle.main.loadNibNamed("TopicHeader", owner: self, options: nil)!.last as! TopicHeaderView
    }
    
    // MARK: lazy loading
    fileprivate lazy var imageCarouselView: ImageCarouselView = {
        let i = ImageCarouselView.loadFromNib()
        return i
    }()
}
