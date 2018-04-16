//
//  UITextView-Extension.swift
//  09-表情键盘
//
//  Created by digitalforest on 2018/4/16.
//  Copyright © 2018年 liukun. All rights reserved.
//

import UIKit

extension UITextView{
    //给textview插入表情
    func insertEmoticon(emoticon:Emoticon) {
        //空白表情
        if emoticon.isEmpty {
            return
        }
        //删除按钮
        if emoticon.isRemove {
            deleteBackward()
            return
        }
        //emoji表情
        if emoticon.emojiCode != nil {
            let textRange = selectedTextRange!
            replace(textRange, withText: emoticon.emojiCode!)
            return
        }
        //普通表情 图文混排
        //根据图片路径创建属性字符串
        let attachment = EmoticonAttachment()
        attachment.image = UIImage(contentsOfFile: emoticon.pngPath!)
        attachment.chs = emoticon.chs
        let font = self.font!
        attachment.bounds = CGRect(x: 0, y: -4, width: font.lineHeight, height: font.lineHeight)
        let attrImageStr = NSAttributedString(attachment: attachment)
        //创建可变的属性字符串
        let attrMStr = NSMutableAttributedString(attributedString: attributedText)
        let range = selectedRange
        attrMStr.replaceCharacters(in: range, with: attrImageStr)
        attributedText = attrMStr
        //将文字大小重置
        self.font = font
        //将光标设置回原来位置+1
        selectedRange = NSRange(location: range.location+1, length: 0)
    }
    //获取textview属性字符串对应的表情字符串
    func getEmoticonString() -> String {
        //获取属性字符串
        let attrMStr = NSMutableAttributedString(attributedString: attributedText)
        //遍历属性字符串
        let range = NSRange(location: 0, length: attrMStr.length)
        attrMStr.enumerateAttributes(in: range, options: []) { (dict, range, _) -> Void in
            if let attachment = dict[NSAttributedStringKey.attachment] as? EmoticonAttachment{
                attrMStr.replaceCharacters(in: range, with: attachment.chs!)
            }
        }
        return attrMStr.string
    }
}
