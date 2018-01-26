//
//  NetworkTools.swift
//  AFNetWorking的封装
//
//  Created by digitalforest on 2018/1/25.
//  Copyright © 2018年 liukun. All rights reserved.
//

import UIKit
import AFNetworking

class NetworkTools: AFHTTPSessionManager {
    //let是线程安全的
    static let shareInstance:NetworkTools = NetworkTools()
}

// MARK:- 封装请求方法
extension NetworkTools{
    func request(urlString:String,parameters:[String:AnyObject]){
        get(urlString, parameters: parameters, progress: { (progress:Progress) in
            
        }, success: { (task:URLSessionDataTask, result:AnyObject?) in
            print(result)
        }) { (task:URLSessionDataTask, error:NSError) in
            print(error)
        }
    }
}
