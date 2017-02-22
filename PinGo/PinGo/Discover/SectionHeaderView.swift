//
//  SectionHeaderView.swift
//  PinGo
//
//  Created by GaoWanli on 16/1/31.
//  Copyright © 2016年 GWL. All rights reserved.
//

import UIKit

class SectionHeaderView: UICollectionReusableView {
    
    @IBOutlet fileprivate var label: UILabel!
    
    var showText: String? {
        didSet {
            label.text = showText
        }
    }
    
    class func loadFromNib() -> SectionHeaderView {
        return Bundle.main.loadNibNamed("SectionHeader", owner: self, options: nil)!.last as! SectionHeaderView
    }
}
