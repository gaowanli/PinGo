//
//  SimpleSubjectInfo.swift
//  PinGo
//
//  Created by GaoWanli on 16/1/16.
//  Copyright © 2016年 GWL. All rights reserved.
//

import UIKit

class SimpleSubjectInfo: NSObject {
    
    var subjectID: String? 
    var title: String?
    var isOfficial: String?
    
    init(dict: [String: AnyObject]?) {
        super.init()
        
        guard dict?.count > 0 else {
            return
        }
        
        setValuesForKeysWithDictionary(dict!)
    }
}
