//
//  NetworkTool.swift
//  PinGo
//
//  Created by GaoWanli on 16/1/16.
//  Copyright © 2016年 GWL. All rights reserved.
//

import UIKit
import Alamofire

class NetworkTool: NSObject {
    /**
     *  请求 JSON
     *
     *  @param method        HTTP 请求方法
     *  @param URLString     URL字符串
     *  @param parameters    参数字典
     *  @param completion    完成回调，返回NetworkResponse
     */
    class func requestJSON(_ method: HTTPMethod, URLString: String, parameters: [String: AnyObject]? = nil, completion:@escaping (_ response: NetworkResponse?) -> ()) {
        Alamofire.request(URLString, method: method, parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON { (JSON) in
            switch JSON.result {
            case .success:
                if let value = JSON.result.value {
                    let nResponse = NetworkResponse(dict: value as! [String : AnyObject])
                    completion(nResponse)
                }
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
}
