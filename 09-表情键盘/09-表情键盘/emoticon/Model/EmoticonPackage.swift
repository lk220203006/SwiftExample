//
//  EmoticonPackage.swift
//  09-表情键盘
//
//  Created by digitalforest on 2018/4/10.
//  Copyright © 2018年 liukun. All rights reserved.
//

import UIKit

class EmoticonPackage: NSObject {
    var emoticons:[Emoticon] = [Emoticon]()
    
    init(id:String) {
        if id == "" {
            //最近分组
            return
        }
        //根据id拼接infoplist的路径
        let plistPath = Bundle.main.path(forResource: "\(id)/info.plist", ofType: nil, inDirectory: "Emoticons.bundle")!
        let array = NSArray(contentsOfFile: plistPath)! as! [[String:String]]
        //遍历数组
        for dict in array {
            emoticons.append(Emoticon(dict: dict))
        }
    }
}
