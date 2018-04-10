//
//  EmoticonManager.swift
//  09-表情键盘
//
//  Created by digitalforest on 2018/4/10.
//  Copyright © 2018年 liukun. All rights reserved.
//

import UIKit

class EmoticonManager {
    var packages:[EmoticonPackage] = [EmoticonPackage]()
    
    init() {
        //添加最近表情的包
        packages.append(EmoticonPackage(id: ""))
        //添加默认表情的包
        packages.append(EmoticonPackage(id: "com.sina.default"))
        //添加emoji表情的包
        packages.append(EmoticonPackage(id: "com.apple.emoji"))
        //添加浪小花表情的包
        packages.append(EmoticonPackage(id: "com.sina.lxh"))
    }
}
