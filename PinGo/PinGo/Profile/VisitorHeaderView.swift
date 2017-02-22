//
//  VisitorHeaderView.swift
//  PinGo
//
//  Created by GaoWanli on 16/1/31.
//  Copyright © 2016年 GWL. All rights reserved.
//

import UIKit

class VisitorHeaderView: UIView {
    
    @IBOutlet fileprivate weak var visitorCountLabel: UILabel!
    @IBOutlet fileprivate weak var vistorTodayLabel: UILabel!
    
    var num: (Int, Int)? {
        didSet {
            visitorCountLabel.text = "\(num!.0)"
            vistorTodayLabel.text = "\(num!.1)"
        }
    }
    
    class func loadFromNib() -> VisitorHeaderView {
        return Bundle.main.loadNibNamed("VisitorHeader", owner: self, options: nil)!.last as! VisitorHeaderView
    }
}
