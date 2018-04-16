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
        tools.responseSerializer.acceptableContentTypes?.insert("text/plain")
        tools.responseSerializer.acceptableContentTypes?.insert("text/JavaScript")
        return tools
    }()
}

// MARK:- 封装请求方法
extension NetworkTools{
    func request(methodType:RequestType,urlString:String,parameters:[String:AnyObject],finished:@escaping (_ result:AnyObject?,_ error:Error?) -> ()){
        
        //成功回调
        let success = { (task: URLSessionDataTask, json: Any)->() in
//            print(json)
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

extension NetworkTools{
    func loadUserInfo(access_token:String,uid:String,finished:@escaping (_ result:[String:AnyObject]?,_ error:Error?) -> ()){
        let urlString = "https://api.weibo.com/2/users/show.json"
        let parameters = ["access_token":access_token,"uid":uid]
        request(methodType: .GET, urlString: urlString, parameters: parameters as [String : AnyObject], finished: {(result,error) -> () in
            finished(result as? [String : AnyObject],error)
        })
    }
}

extension NetworkTools{
    func loadStatuses(since_id:Int,max_id:Int,finished:@escaping (_ result:[[String:AnyObject]]?,_ error:Error?) -> ()) {
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
        let parameters = ["access_token":(UserAccountViewModel.shareInstance.account?.access_token)!,
                          "since_id":since_id,
                          "max_id":max_id] as [String : Any]
        request(methodType: .GET, urlString: urlString, parameters: parameters as [String : AnyObject], finished: {(result,error) -> () in
            guard let resultDict = result as? [String:AnyObject] else{
                finished(nil,error)
                return
            }
            finished(resultDict["statuses"] as? [[String : AnyObject]],error)
        })
    }
}
//MARK:- 发送微博
extension NetworkTools{
    func sendStatus(statusText:String,isSuccess:@escaping (_ isSuccess:Bool)->()){
//        let urlString = "http://api.t.sina.com.cn/statuses/update.json"
        let urlString = "https://api.weibo.com/2/statuses/update.json"
        let parameters = ["access_token":(UserAccountViewModel.shareInstance.account?.access_token)!,
                          "status":statusText
            ] as [String : Any]
        request(methodType: .POST, urlString: urlString, parameters: parameters as [String:AnyObject], finished: {(result,error) -> () in
            if result != nil{
                isSuccess(true)
            }
            else{
                isSuccess(false)
            }
        })
    }
}

extension NetworkTools{
    func sendStatus(statusText:String,image:UIImage,isSuccess:@escaping (_ isSuccess:Bool)->()){
//        let urlString = "http://api.t.sina.com.cn/statuses/upload.json"
        let urlString = "https://api.weibo.com/2/statuses/upload.json"
        let parameters = ["access_token":(UserAccountViewModel.shareInstance.account?.access_token)!,
                          "status":statusText
            ] as [String : Any]
        post(urlString, parameters: parameters, constructingBodyWith: { (formData)->Void in
            if let imageData = UIImageJPEGRepresentation(image, 0.5){
                formData.appendPart(withFileData: imageData, name: "pic", fileName: "123.png", mimeType: "image/png")
            }
            
        }, progress: nil, success: { (_, _) in
            isSuccess(true)
        }) { (_, error)->Void in
            isSuccess(false)
            print(error)
        }
    }
}
