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
    
    typealias subjectInfoListCompletion = (_ subjectInfoListArray: [[SubjectInfo]]?) -> ()
    typealias subjectInfoCompletion     = (_ subjectInfo: SubjectInfo?, _ managerUserList: [User]?) -> ()
    
    init(dict: [String: AnyObject]?) {
        super.init()
        
        guard let `dict` = dict, `dict`.keys.count > 0 else {
            return
        }
        
        for (key, value) in `dict` {
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
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    class func fetchSubjectInfoList(_ completion: @escaping subjectInfoListCompletion) {
        let url = "\(kDISCOVER_SUBJECTINFO_LIST_URL)?\(kAPI_PEERID)&\(kAPI_OS)&\(kAPI_USERID)&\(kAPI_SESSION_TOKEN)&\(kAPI_CHANNELID)&\(kAPI_PRODUCTID)&\(kAPI_VERSION)&\(kAPI_SYSVERSION)&\(kAPI_SESSION_ID)&\(kAPI_VERSION_CODE)&key=3E21B8BF085CC3287E84A534EACA9DD7"
        
        NetworkTool.requestJSON(.get, URLString: url) { (response) in
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
                    completion(subjectInfoListArray)
                }
            }else {
                debugPrint("error:\(response?.codeMsg)")
                completion(nil)
            }
        }
    }
    
    class func fetchSubjectInfo(subjectID: Int, completion: @escaping subjectInfoCompletion) {
        let url = "http://api.impingo.me/subject/getSubject?peerID=6EDEE890B4E5&os=ios&userID=1404034&sessionToken=cce76093c4&channelID=App%20Store&productID=com.joyodream.pingo&version=3.7&sysVersion=9.2.1&subjectID=343887&sessionID=e5c8c1b3e8153e78ab&versionCode=15&key=FD86BF9762791F118EE6E5CDB501B756"
        
        NetworkTool.requestJSON(.get, URLString: url) { (response) in
            if response?.rtn == "0" {
                if let data = response?.data {
                    if let dict0 = data["subjectInfo"] as? [String: AnyObject] {
                        var managerUserList = [User]()
                        for dict1 in dict0["managerUserInfoList"] as! [AnyObject] {
                            managerUserList.append(User(dict: dict1 as? [String: AnyObject]))
                        }
                        completion(SubjectInfo(dict: dict0), managerUserList)
                    }else {
                        completion(nil, nil)
                    }
                }
            }else {
                debugPrint("error:\(response?.codeMsg)")
                completion(nil, nil)
            }
        }
    }
}
