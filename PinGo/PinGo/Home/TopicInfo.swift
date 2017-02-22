//
//  TopicInfo.swift
//  PinGo
//
//  Created by GaoWanli on 16/1/16.
//  Copyright © 2016年 GWL. All rights reserved.
//

import UIKit

class TopicInfo: NSObject {
    
    var topicID: String?
    var type = 0
    var content: String?
    var resUrl: String?
    var replyTopicID: String?
    var replyUserID: String?
    var stickerID: String?
    var paperID: String?
    var subjectID: String?
    var subjectTitle: String?
    var location: String?
    var userInfo: User?
    var heat = 0
    var praiseCnt = 0
    var duration = 0
    var pubTime: String?
    var recvTime: String?
    var isDiscard = 0
    var simpleSubjectInfoList: SimpleSubjectInfo?
    var commentCnt: String?
    var beauty: String?
    var isTop = 0
    
    // isEnd: 是否有更多数据 sortValue:下次获取更多需要的字段
    typealias topicInfoCompletion = (_ isEnd: Bool, _ sortValue: String, _ topicInfoList: [TopicInfo]?) -> ()
    typealias squareTopicInfoCompletion = (_ topicInfoList: [TopicInfo]?) -> ()
    
    init(dict: [String: AnyObject]?) {
        super.init()
        
        guard let `dict` = dict, `dict`.keys.count > 0 else {
            return
        }
        
        for (key, value) in `dict` {
            let keyName = key as String
            
            if keyName == "userInfo" {
                userInfo = User(dict: value as? [String : AnyObject])
                continue
            }else if keyName == "simpleSubjectInfoList" {
                simpleSubjectInfoList = SimpleSubjectInfo(dict: value as? [String : AnyObject])
                continue
            }
            self.setValue(value, forKey: keyName)
        }
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
    
    /**
     获取首页数据列表
     
     - parameter isFollow:      精选 or 关注
     - parameter order:         1 or 0  1:获取最新 0:获取更多
     - parameter sortValue:     获取更多需要的字段
     */
    class func fetchTopicInfoList(isFollow: Bool = false, order: Int = 1, sortValue: String = "0", completion: @escaping topicInfoCompletion) {
        let baseUrl = isFollow ? kHOME_FOLLOW_TOPIC_LIST_URL : kHOME_TOPIC_LIST_URL
        let url = "\(baseUrl)?\(kAPI_USERID)&baseSortValue=\(sortValue)&\(kAPI_VERSION)&\(kAPI_SYSVERSION)&requestCnt=50&\(kAPI_PRODUCTID)&\(kAPI_SESSION_TOKEN)&\(kAPI_CHANNELID)&\(kAPI_OS)&order=\(order)&\(kAPI_VERSION_CODE)&\(kAPI_PEERID)&\(kAPI_SESSION_ID)&\(kAPI_KEY)"
        
        NetworkTool.requestJSON(.get, URLString: url) { (response) in
            if response?.rtn == "0" {
                if let data = response?.data {
                    var topicInfoList = [TopicInfo]()
                    for dict in data["topicInfoList"] as! [[String: AnyObject]] {
                        topicInfoList.append(TopicInfo(dict: dict))
                    }
                    completion((data["isEnd"] as! Int) == 1, data["sortValue"] as? String ?? "0", topicInfoList)
                }
            }else {
                debugPrint("error:\(response?.codeMsg)")
                completion(true, "0", nil)
            }
        }
    }
    
    class func fetchSubjectTopicList(subjectID: Int, completion: @escaping topicInfoCompletion) {
        let url = "http://api.impingo.me/subject/listSubjectTopic?userID=1404034&baseSortValue=0&version=3.7&sysVersion=9.2.1&requestCnt=20&productID=com.joyodream.pingo&sessionToken=cce76093c4&listType=1&channelID=App%20Store&os=ios&subjectID=343887&versionCode=15&peerID=6EDEE890B4E5&sessionID=e5c8c1b3e8153e78ab&key=B5CADA9605B2C4AADF5069F01CDB7D1C"
        
        NetworkTool.requestJSON(.get, URLString: url) { (response) in
            if response?.rtn == "0" {
                if let data = response?.data {
                    var topicInfoList = [TopicInfo]()
                    for dict in data["topicInfoList"] as! [[String: AnyObject]] {
                        topicInfoList.append(TopicInfo(dict: dict))
                    }
                    completion((data["isEnd"] as! Int) == 1, data["sortValue"] as? String ?? "0", topicInfoList)
                }
            }else {
                debugPrint("error:\(response?.codeMsg)")
                completion(true, "0", nil)
            }
        }
    }
}
