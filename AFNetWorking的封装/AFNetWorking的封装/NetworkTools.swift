//
//  NetworkTools.swift
//  AFNetWorking的封装
//
//  Created by digitalforest on 2018/1/30.
//  Copyright © 2018年 liukun. All rights reserved.
//

import UIKit
import AFNetworking

//定义枚举类型
enum RequestType:String {
    case GET = "GET"
    case POST = "POST"
}

class NetworkTools: AFHTTPSessionManager {
//    static let shareInstance:NetworkTools = NetworkTools()
    static let shareInstance:NetworkTools = {
        let tools = NetworkTools()
        tools.responseSerializer.acceptableContentTypes?.insert("text/html")
        return tools
    }()
}

// MARK:- 封装请求方法
extension NetworkTools{
    func request(methodType:RequestType,urlString:String,parameters:[String:AnyObject],finished:@escaping (_ result:AnyObject?,_ error:Error?) -> ()){
        
        //成功回调
        let success = { (task: URLSessionDataTask, json: Any)->() in
            finished(json as AnyObject,nil)
        }
        
        //失败回调
        let failure = { (task: URLSessionDataTask?, error: Error) -> () in
            print("网络请求错误 \(error.localizedDescription)")
            finished(nil,error)
        }
        
        if methodType == .GET {
            get(urlString, parameters: parameters, progress: nil, success: success, failure:failure)
        }
        else{
            post(urlString, parameters: parameters, progress: nil, success: success, failure: failure)
        }
    }
}

// MARK:- 请求AccessToken
extension NetworkTools{
    func loadAccessToken(code:String,finished:@escaping (_ result:[String:AnyObject]?,_ error:Error?)->()){
        let urlString = "https://api.weibo.com/oauth2/access_token"
        let parameters = ["client_id":app_key,"client_secret":app_secret,"grant_type":"authorization_code","code":code,"redirect_uri":redirect_url]
        request(methodType: .POST, urlString: urlString, parameters: parameters as [String : AnyObject], finished: {(result,error) -> () in
            finished(result as? [String : AnyObject],error)
        })
    }
}
