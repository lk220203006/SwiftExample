//
//  UserAccount.swift
//  WeiBoWithSB
//
//  Created by digitalforest on 2018/1/31.
//  Copyright © 2018年 liukun. All rights reserved.
//

import UIKit

class UserAccount: NSObject {
    //MARK:- 属性
    var access_token:String?
    var expires_in:TimeInterval = 0
    var uid:String?
    
    //MARK:- 自定义构造函数
    init(dict:[String:AnyObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    override var description: String{
        return dictionaryWithValues(forKeys: ["access_token","expires_in","uid"]).description
    }
}
