//
//  VisitorRecord.swift
//  PinGo
//
//  Created by GaoWanli on 16/1/31.
//  Copyright © 2016年 GWL. All rights reserved.
//

import UIKit

/// 访客记录
class VisitorRecord: NSObject {

    var user: User?
    var visitTime: String?
    
    typealias visitorRecordCompletion = (_ visitorRecordList: [VisitorRecord]?) -> ()
    
    init(dict: [String: AnyObject]?) {
        super.init()
        
        guard let `dict` = dict, `dict`.keys.count > 0 else {
            return
        }
    
        user = User(dict: `dict`)
        visitTime = `dict`["visitTime"] as? String
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
    
    /**
     获取访客记录列表
     
     - parameter completion: 列表
     */
    class func fetchVisitorRecord(_ completion: @escaping visitorRecordCompletion) {
        let url = "\(kVISITOR_RECORD_URL)?\(kAPI_USERID)&baseSortValue=0&\(kAPI_VERSION)&\(kAPI_SYSVERSION)&requestCnt=50&\(kAPI_PRODUCTID)&\(kAPI_SESSION_TOKEN)&\(kAPI_CHANNELID)&\(kAPI_OS)&order=1&\(kAPI_VERSION_CODE)&\(kAPI_PEERID)&\(kAPI_SESSION_ID)&\(kAPI_KEY)"
        
        NetworkTool.requestJSON(.get, URLString: url) { (response) in
            if response?.rtn == "0" {
                if let data = response?.data {
                    var visitorRecordList = [VisitorRecord]()
                    for dict in data["visitUserInfoList"] as! [[String: AnyObject]] {
                        visitorRecordList.append(VisitorRecord(dict: dict))
                    }
                    completion(visitorRecordList)
                }
            }else {
                debugPrint("error:\(response?.codeMsg)")
                completion(nil)
            }
        }
    }
}
