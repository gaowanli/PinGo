//
//  Array+Extension.swift
//  PinGo
//
//  Created by GaoWanli on 16/2/2.
//  Copyright © 2016年 GWL. All rights reserved.
//

import Foundation

extension Array {
    
    func split(startIndex sIndex: Int, endIndex eIndex: Int) -> [Element] {
        return 0.stride(to: eIndex, by: eIndex).map { _ in
            return Array(self[sIndex ..< eIndex])
        }[0]
    }
}