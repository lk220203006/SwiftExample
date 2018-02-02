//
//  UserAccount.swift
//  WeiBoWithSB
//
//  Created by digitalforest on 2018/1/31.
//  Copyright © 2018年 liukun. All rights reserved.
//

import UIKit

@objcMembers

class UserAccount: NSObject {
    //MARK:- 属性
    var access_token:String?
    //过期时间-秒
    var expires_in:TimeInterval = 0{
        didSet{
            expires_date = Date(timeIntervalSinceNow: expires_in)
        }
    }
    //用户id
    var uid:String?
    //过期日期
    var expires_date:Date?
    //昵称
    var screen_name:String?
    //用户的头像地址
    var avatar_large:String?
    
    //MARK:- 自定义构造函数
    init(dict:[String:AnyObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        print("key:%@,value:%@",key,value as Any)
    }
    
    override var description: String{
        return dictionaryWithValues(forKeys: ["access_token","expires_date","uid","screen_name","avatar_large"]).description
    }
}
