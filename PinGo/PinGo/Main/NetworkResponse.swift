//
//  NetworkResponse.swift
//  PinGo
//
//  Created by GaoWanli on 16/1/16.
//  Copyright © 2016年 GWL. All rights reserved.
//

import UIKit

class NetworkResponse: NSObject {
    var codeMsg: String?
    var msg: String?
    var rtn: String?
    var data: [String: AnyObject]?
    
    init(dict: [String: AnyObject]) {
        super.init()
        
        codeMsg = dict["codeMsg"] as? String
        msg = dict["msg"] as? String
        
        if let r = dict["rtn"]  as? String {
            rtn = r
        }else if let r = dict["rtn"] as? Int {
            rtn = "\(r)"
        }
        
        data = dict["data"] as? [String: AnyObject]
    }
}
