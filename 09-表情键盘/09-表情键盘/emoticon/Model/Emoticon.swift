//
//  Emoticon.swift
//  09-表情键盘
//
//  Created by digitalforest on 2018/4/10.
//  Copyright © 2018年 liukun. All rights reserved.
//

import UIKit
@objcMembers
class Emoticon: NSObject {
    //MARK:- 定义属性
    var code:String?
    var png:String?
    var chs:String?
    
    //MARK:- 自定义函数
    init(dict:[String:String]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        print("key:%@,value:%@",key,value as Any)
    }
    
    override var description: String{
        return dictionaryWithValues(forKeys: ["code","png","chs"]).description
    }
}

