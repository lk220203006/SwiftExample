//
//  Status.swift
//  WeiBoWithSB
//
//  Created by digitalforest on 2018/2/7.
//  Copyright © 2018年 liukun. All rights reserved.
//

import UIKit

@objcMembers

class Status: NSObject {
    //MARK:- 属性
    var created_at:String?
    var source:String?
    var text:String?
    var mid:Int = 0
    
    var user:User?
    
    //MARK:- 自定义构造函数
    init(dict:[String:AnyObject]) {
        super.init()
        setValuesForKeys(dict)
        
        if let userDict = dict["user"] as? [String:AnyObject] {
            user = User(dict: userDict)
        }
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
