//
//  Banner.swift
//  PinGo
//
//  Created by GaoWanli on 16/2/1.
//  Copyright © 2016年 GWL. All rights reserved.
//

import UIKit 

enum BannerQueryType {
    case subject, square
}

class Banner: NSObject {
    
    var bannerID: String?
    var imageUrl: String?
    var jumpUrl: String?
    
    typealias bannerCompletion = (_ bannerList: [Banner]?) -> ()
    
    init(dict: [String: AnyObject]?) {
        super.init()
        
        guard let `dict` = dict, `dict`.keys.count > 0 else {
            return
        }
        
        setValuesForKeys(`dict`)
    }
    
    class func fetchBannerList(type: BannerQueryType, completion: @escaping bannerCompletion) {
        let page = (type == .subject ? "subject" : "square")
        let key = (type == .subject ? "71E9EDFA30D38D95664AF805400324E1" : "093A511B21DC549B1F31F700C8A0400C")
        
        let url = "\(kDISCOVER_BANNER_LIST_URL)?\(kAPI_PEERID)&\(kAPI_OS)&\(kAPI_USERID)&\(kAPI_SESSION_TOKEN)&\(kAPI_CHANNELID)&\(kAPI_PRODUCTID)&\(kAPI_VERSION)&\(kAPI_SYSVERSION)&page=\(page)&\(kAPI_SESSION_ID)&\(kAPI_VERSION_CODE)&key=\(key)"
        
        NetworkTool.requestJSON(.get, URLString: url) { (response) in
            if response?.rtn == "0" {
                if let data = response?.data {
                    var bannerList = [Banner]()
                    for dict in data["bannerInfoList"] as! [[String: AnyObject]] {
                        bannerList.append(Banner(dict: dict))
                    }
                    completion(bannerList)
                }
            }else {
                debugPrint("error:\(response?.codeMsg)")
                completion(nil)
            }
        }
    }
}
