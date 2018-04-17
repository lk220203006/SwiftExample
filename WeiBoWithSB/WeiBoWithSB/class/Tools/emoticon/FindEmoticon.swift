//
//  FindEmoticon.swift
//  WeiBoWithSB
//
//  Created by digitalforest on 2018/4/17.
//  Copyright © 2018年 liukun. All rights reserved.
//

import UIKit

class FindEmoticon: NSObject {
    static let shareInstance : FindEmoticon = FindEmoticon()
    
    private lazy var manager:EmoticonManager = EmoticonManager()
    
    
    func findAttrString(statusText:String?,font:UIFont) -> NSMutableAttributedString? {
        guard let statusText = statusText else {
            return nil
        }
        let attrMStr = NSMutableAttributedString(string: statusText)
        let pattern = "\\[.*?\\]"//匹配表情
        //创建正则表达式对象
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else {
            return attrMStr
        }
        
        //开始匹配
        let results = regex.matches(in:statusText, options: [], range: NSRange(location: 0, length: statusText.count))
        //获取结果
        
        for result in results.reversed() {
            //获取chs
            let chs = (statusText as NSString).substring(with: result.range)
            //根据chs获取图片的路径
            guard let pngPath = findPngPath(chs: chs) else{
                continue
            }
            //创建属性字符串
            let attachment = NSTextAttachment()
            attachment.image = UIImage(contentsOfFile: pngPath)
            attachment.bounds = CGRect(x: 0, y: -4, width: font.lineHeight, height: font.lineHeight)
            let attrImageStr = NSAttributedString(attachment: attachment)
            //将属性字符串替换到
            attrMStr.replaceCharacters(in: result.range, with: attrImageStr)
        }
        return attrMStr
    }
    
    private func findPngPath(chs:String) -> String?{
        let manager = EmoticonManager()
        for package in manager.packages {
            for emoticon in package.emoticons{
                if emoticon.chs == chs{
                    return emoticon.pngPath
                }
            }
        }
        return nil
    }
}
