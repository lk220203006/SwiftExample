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
        super.init()
        if id == "" {
            //最近分组
            addEmptyEmoticon(isRecently: true)
            return
        }
        //根据id拼接infoplist的路径
        let plistPath = Bundle.main.path(forResource: "\(id)/info.plist", ofType: nil, inDirectory: "Emoticons.bundle")!
        let array = NSArray(contentsOfFile: plistPath)! as! [[String:String]]
        //遍历数组
        var index = 0
        for var dict in array {
            if let png = dict["png"]{
               dict["png"] = id + "/" + png
            }
            
            emoticons.append(Emoticon(dict: dict))
            index += 1
            if index == 20{
                emoticons.append(Emoticon(isRemove: true))
                index = 0
            }
        }
        addEmptyEmoticon(isRecently: false)
    }
    
    private func addEmptyEmoticon(isRecently:Bool){
        let count = emoticons.count % 21
        if count == 0 && !isRecently {
            return
        }
        for _ in count..<20 {
            emoticons.append(Emoticon(isEmpty: true))
        }
        emoticons.append(Emoticon(isRemove: true))
    }
}
