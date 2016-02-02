//
//  Urls.swift
//  PinGo
//
//  Created by GaoWanli on 16/1/16.
//  Copyright © 2016年 GWL. All rights reserved.
//

import Foundation

let kAPI_URL                       = "http://api.impingo.me"
let kAPI_USERID                    = "userID=1404034"
let kAPI_SESSION_ID                = "sessionID=e5c8c1161c25aa8997"
let kAPI_SESSION_TOKEN             = "sessionToken=7cbe2e506d"
let kAPI_KEY                       = "key=244582636F636CE11D19D7B69B68F2BB"
let kAPI_PEERID                    = "peerID=CEDA7431254F"
let kAPI_PRODUCTID                 = "productID=com.joyodream.pingo"
let kAPI_VERSION                   = "version=3.6"
let kAPI_VERSION_CODE              = "versionCode=15"
let kAPI_SYSVERSION                = "sysVersion=8.3"
let kAPI_CHANNELID                 = "channelID=App%20Store"
let kAPI_OS                        = "os=ios"
/// 首页精选列表的地址
let kHOME_TOPIC_LIST_URL           = kAPI_URL + "/topic/listSelectionBottleTopic"
/// 首页关注列表的地址
let kHOME_FOLLOW_TOPIC_LIST_URL    = kAPI_URL + "/topic/listOnlineBottleTopic"
/// 话题首页banner列表的地址
let kDISCOVER_BANNER_LIST_URL      = kAPI_URL + "/banner/listBanner"
/// 话题首页推荐列表的地址
let kDISCOVER_SUBJECTINFO_LIST_URL = kAPI_URL + "/subject/listSubjectCategory" 
/// 访客记录的地址
let kVISITOR_RECORD_URL            = kAPI_URL + "/user/listVisitUser"