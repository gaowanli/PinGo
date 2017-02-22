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
    func tabBar(_ tabBar: TabBar, didClickButton index: Int)
}

class TabBar: UITabBar {
    
    weak var aDelegate: TabBarDelegate?
    /// 当前选中的按钮
    fileprivate var selButton: DHButton?
    
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
    
    fileprivate func buttonWithImageName(_ imageName: String) -> DHButton {
        let b = DHButton(type: .custom)
        let sImageName = imageName + "_sel"
        b.setImage(UIImage(named: imageName), for: UIControlState())
        b.setImage(UIImage(named: sImageName), for: .selected)
        b.addTarget(self, action: #selector(TabBar.buttonClick(_:)), for: .touchDown)
        return b
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let count = buttons.count
        let w = bounds.width / CGFloat(count)
        let h = bounds.height
        
        let frame = CGRect(x: 0, y: 0, width: w, height: h)
        for b in buttons {
            b.frame = frame.offsetBy(dx: CGFloat(b.tag) * w, dy: 0)
        }
    }
    
    func buttonClick(_ button: DHButton) {
        guard selButton != button else {
            return
        }
        
        if button.tag != 2 {
            selButton?.isSelected = false
            button.isSelected = true
            selButton = button
        }
        
        aDelegate?.tabBar(self, didClickButton: button.tag)
    }
    
    // MARK: lazy loading
    fileprivate lazy var btnImages: [String] = {
        return ["tabbar_home", "tabbar_discover", "tabbar_show", "tabbar_message", "tabbar_profile"]
    }()
    
    fileprivate lazy var buttons: [UIButton] = {
        return [UIButton]()
    }()
}
