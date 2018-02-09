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
    var source:String?{
        didSet{
            guard let source = source, source != "" else {
                return
            }
            let startIndex = (source as NSString).range(of: ">").location
            let length = (source as NSString).range(of: "</a>").location - startIndex
            sourceText = (source as NSString).substring(with: NSRange(location: startIndex, length: length))
        }
    }
    var text:String?
    var mid:Int = 0
    
    //MARK:- 对数据处理的属性
    var sourceText:String?
    
    //MARK:- 自定义构造函数
    init(dict:[String:AnyObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
