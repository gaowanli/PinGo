//
//  DHButton.swift
//  PinGo
//
//  Created by GaoWanli on 16/1/31.
//  Copyright © 2016年 GWL. All rights reserved.
//

import UIKit

/// 取消高亮的button
class DHButton: UIButton {
    override var isHighlighted: Bool {
        get {
            return super.isHighlighted
        }
        set {
            super.isHighlighted = false
        }
    }
}
