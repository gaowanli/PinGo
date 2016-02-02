//
//  UINib+Extension.swift
//  PinGo
//
//  Created by GaoWanli on 16/1/31.
//  Copyright © 2016年 GWL. All rights reserved.
//

import UIKit

extension UINib {
    
    class func nibWithName(name: String) -> UINib {
        return UINib(nibName: name, bundle: nil)
    }
}

