//
//  SubjectInfo.swift
//  PinGo
//
//  Created by GaoWanli on 16/2/1.
//  Copyright © 2016年 GWL. All rights reserved.
//

import UIKit

class SubjectInfo: NSObject {
    
    var subjectID: String?
    var title: String?
    var desc: String?
    var imageUrl: String?
    var posterUrl: String?
    var topicCnt: Int = 0
    var userCnt: Int = 0
    var isFavo: Int = 0
    var incTopicCnt: Int = 0
    var isActivity: Int = 0
    var activityTitle: String?
    var activityUrl: String?
    var activityUrlType: Int = 0
    var isOfficial: Int = 0
    var readCnt: Int = 0
    
    typealias subjectInfoCompletion = (subjectInfoListArray: [[SubjectInfo]]?) -> ()
    
    init(dict: [String: AnyObject]?) {
        super.init()
        
        guard dict?.count > 0 else {
            return
        }
        
        for (key, value) in dict! {
            let keyName = key as String
            if keyName == "imageUrl2" {
                self.setValue(value, forKey: "imageUrl")
                continue
            }
            if keyName == "imageUrl" {
                continue
            }
            self.setValue(value, forKey: keyName)
        }
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
    class func fetchSubjectInfoList(completion: subjectInfoCompletion) {
        let url = "\(kDISCOVER_SUBJECTINFO_LIST_URL)?\(kAPI_PEERID)&\(kAPI_OS)&\(kAPI_USERID)&\(kAPI_SESSION_TOKEN)&\(kAPI_CHANNELID)&\(kAPI_PRODUCTID)&\(kAPI_VERSION)&\(kAPI_SYSVERSION)&\(kAPI_SESSION_ID)&\(kAPI_VERSION_CODE)&key=3E21B8BF085CC3287E84A534EACA9DD7"
        
        NetworkTool.requestJSON(.GET, URLString: url) { (response) in
            if response?.rtn == "0" {
                if let data = response?.data {
                    var subjectInfoListArray = [[SubjectInfo]]()
                    for dict0 in data["subjectCategoryList"] as! [AnyObject] {
                        var subjectInfoList = [SubjectInfo]()
                        for dict in dict0["subjectInfoList"] as! [[String: AnyObject]] {
                            subjectInfoList.append(SubjectInfo(dict: dict))
                        }
                        subjectInfoListArray.append(subjectInfoList)
                    }
                    completion(subjectInfoListArray: subjectInfoListArray)
                }
            }else {
                debugPrint("error:\(response?.codeMsg)")
                completion(subjectInfoListArray: nil)
            }
        }
    }
    
}
