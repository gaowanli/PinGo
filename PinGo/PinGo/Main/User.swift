//
//  User.swift
//  PinGo
//
//  Created by GaoWanli on 16/1/16.
//  Copyright © 2016年 GWL. All rights reserved.
//

import UIKit

class User: NSObject {
    
    var userID: String?
    var nickname: String?
    var headUrl: String?
    var sex = 0
    var heat = 0
    var praiseCnt = 0
    var birthday: String?
    /// 年龄
    var age: Int {
        return (birthday?.age(withStyle: .Style1))!
    }
    var signature: String?
    var isFamous = 0
    var onlineTime: String?
    var level = 0
    var isOfficial = 0
    var famousTypeInfo: FamousType?
    
    init(dict: [String: AnyObject]?) {
        super.init()
        
        guard let `dict` = dict, `dict`.keys.count > 0 else {
            return
        }
        
        for (key, value) in `dict` {
            let keyName = key as String
            if keyName == "famousTypeInfo" {
                famousTypeInfo = FamousType(dict: value as? [String : AnyObject])
                continue
            }
            self.setValue(value, forKey: keyName)
        }
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
}
