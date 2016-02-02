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
    override var highlighted: Bool {
        get {
            return super.highlighted
        }
        set {
            super.highlighted = false
        }
    }
}
