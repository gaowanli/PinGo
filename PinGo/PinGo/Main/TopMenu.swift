//
//  TopMenu.swift
//  PinGo
//
//  Created by GaoWanli on 16/1/31.
//  Copyright © 2016年 GWL. All rights reserved.
//

import UIKit

protocol TopMenuDelegate: NSObjectProtocol {
    /**
     点击了某个按钮
     
     - parameter topMenu: topMenu
     - parameter index:   按钮index
     */
    func topMenu(_ topMenu: TopMenu, didClickButton index: Int)
}

class TopMenu: UIView {
    
    @IBOutlet var buttons: [DHButton]!
    @IBOutlet fileprivate weak var indicatorLabel: UILabel!
    weak var delegate: TopMenuDelegate?
    
    var showText: (String, String)? {
        didSet {
            buttons[0].setTitle("\(showText!.0)", for: UIControlState())
            buttons[1].setTitle("\(showText!.1)", for: UIControlState())
        }
    }
    
    var toIndex: Int = 0 {
        didSet {
            guard toIndex <= buttons.count && toIndex >= -1 else {
                return
            }
            var center = indicatorLabel.center
            center.x = buttons[toIndex].center.x
            UIView.animate(withDuration: 0.25, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 5.0, options: [], animations: {
                self.indicatorLabel.center = center
                }, completion: nil)
        }
    }
    
    @IBAction func buttonClick(_ sender: DHButton) {
        let index = sender.tag
        guard index != toIndex else {
            return
        }
        toIndex = index
        delegate?.topMenu(self, didClickButton: index)
    }
    
    class func loadFromNib() -> TopMenu {
        return Bundle.main.loadNibNamed("TopMenu", owner: self, options: nil)!.last as! TopMenu
    }
}
