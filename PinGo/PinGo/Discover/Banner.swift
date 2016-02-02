//
//  Banner.swift
//  PinGo
//
//  Created by GaoWanli on 16/2/1.
//  Copyright © 2016年 GWL. All rights reserved.
//

import UIKit

enum BannerQueryType {
    case Subject, Square
}

class Banner: NSObject {
    
    var bannerID: String?
    var imageUrl: String?
    var jumpUrl: String?
    
    typealias bannerCompletion = (bannerList: [Banner]?) -> ()
    
    init(dict: [String: AnyObject]?) {
        super.init()
        
        guard dict?.count > 0 else {
            return
        }
        
        setValuesForKeysWithDictionary(dict!)
    }
    
    class func fetchBannerList(type: BannerQueryType, completion: bannerCompletion) {
        let page = (type == .Subject ? "subject" : "square")
        let key = (type == .Subject ? "0F69CE76B34BECEA8AFA1F95BE0DE9F1" : "10556BA206745BB16DD260F05CDBB9C2")
        
        let url = "\(kDISCOVER_BANNER_LIST_URL)?\(kAPI_PEERID)&\(kAPI_OS)&\(kAPI_USERID)&\(kAPI_SESSION_TOKEN)&\(kAPI_CHANNELID)&\(kAPI_PRODUCTID)&\(kAPI_VERSION)&\(kAPI_SYSVERSION)&page=\(page)&\(kAPI_SESSION_ID)&\(kAPI_VERSION_CODE)&key=\(key)"
        
        NetworkTool.requestJSON(.GET, URLString: url) { (response) in
            if response?.rtn == "0" {
                if let data = response?.data {
                    var bannerList = [Banner]()
                    for dict in data["bannerInfoList"] as! [[String: AnyObject]] {
                        bannerList.append(Banner(dict: dict))
                    }
                    completion(bannerList: bannerList)
                }
            }else {
                debugPrint("error:\(response?.codeMsg)")
                completion(bannerList: nil)
            }
        }
    }
}
