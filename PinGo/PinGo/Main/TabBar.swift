//
//  TabBar.swift
//  PinGo
//
//  Created by GaoWanli on 16/1/16.
//  Copyright © 2016年 GWL. All rights reserved.
//

import UIKit

protocol TabBarDelegate: NSObjectProtocol {
    /**
     点击了某个按钮
     
     - parameter tabBar: tabBar
     - parameter index:  按钮index
     */
    func tabBar(tabBar: TabBar, didClickButton index: Int)
}

class TabBar: UITabBar {
    
    weak var aDelegate: TabBarDelegate?
    /// 当前选中的按钮
    private var selButton: DHButton?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        for i in 0..<btnImages.count {
            let imageName = btnImages[i]
            let b = buttonWithImageName(imageName)
            b.tag = i
            if i == 0 {
                buttonClick(b)
            }
            addSubview(b)
            buttons.append(b)
        }
    }
    
    private func buttonWithImageName(imageName: String) -> DHButton {
        let b = DHButton(type: .Custom)
        let sImageName = imageName + "_sel"
        b.setImage(UIImage(named: imageName), forState: .Normal)
        b.setImage(UIImage(named: sImageName), forState: .Selected)
        b.addTarget(self, action: "buttonClick:", forControlEvents: .TouchDown)
        return b
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let count = buttons.count
        let w = CGRectGetWidth(bounds) / CGFloat(count)
        let h = CGRectGetHeight(bounds)
        
        let frame = CGRectMake(0, 0, w, h)
        for b in buttons {
            b.frame = CGRectOffset(frame, CGFloat(b.tag) * w, 0)
        }
    }
    
    func buttonClick(button: DHButton) {
        guard selButton != button else {
            return
        }
        
        if button.tag != 2 {
            selButton?.selected = false
            button.selected = true
            selButton = button
        }
        
        aDelegate?.tabBar(self, didClickButton: button.tag)
    }
    
    // MARK: lazy loading
    private lazy var btnImages: [String] = {
        return ["tabbar_home", "tabbar_discover", "tabbar_show", "tabbar_message", "tabbar_profile"]
    }()
    
    private lazy var buttons: [UIButton] = {
        return [UIButton]()
    }()
}