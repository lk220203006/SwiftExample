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
    var code:String?{
        didSet{
            guard let code = code else {
                return
            }
            //创建扫描器
            let scanner = Scanner(string: code)
            //调用方法 扫描出code中的值
            var value:UInt32 = 0
            scanner.scanHexInt32(&value)
            //将value转成字符串
            let c = Character(UnicodeScalar(value)!)
            emojiCode = String(c)
        }
    }
    var png:String?{
        didSet{
            guard let png = png else {
                return
            }
            pngPath = Bundle.main.bundlePath + "/Emoticons.bundle/" + png
        }
    }
    var chs:String?
    
    //MARK:- 数据处理
    var pngPath:String?
    var emojiCode:String?
    var isRemove:Bool = false
    var isEmpty:Bool = false
    
    //MARK:- 自定义函数
    init(dict:[String:String]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    init(isRemove:Bool){
        self.isRemove = isRemove
    }
    
    init(isEmpty:Bool){
        self.isEmpty = isEmpty
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
    
    override var description: String{
        return dictionaryWithValues(forKeys: ["emojiCode","pngPath","chs"]).description
    }
}

