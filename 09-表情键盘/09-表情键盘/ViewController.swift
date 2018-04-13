//
//  ViewController.swift
//  09-表情键盘
//
//  Created by digitalforest on 2018/4/2.
//  Copyright © 2018年 liukun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    private lazy var emoticonVC:EmoticonController = EmoticonController {[weak self] (emoticon) in
        self?.insertEmoticonIntoTextView(emoticon: emoticon)
    }
    
    private func insertEmoticonIntoTextView(emoticon:Emoticon){
        //空白表情
        if emoticon.isEmpty {
            return
        }
        //删除按钮
        if emoticon.isRemove {
            textView.deleteBackward()
            return
        }
        //emoji表情
        if emoticon.emojiCode != nil {
            let textRange = textView.selectedTextRange!
            textView.replace(textRange, withText: emoticon.emojiCode!)
            return
        }
        //普通表情 图文混排
        //根据图片路径创建属性字符串
        let attachment = NSTextAttachment()
        attachment.image = UIImage(contentsOfFile: emoticon.pngPath!)
        let font = textView.font!
        attachment.bounds = CGRect(x: 0, y: -4, width: font.lineHeight, height: font.lineHeight)
        let attrImageStr = NSAttributedString(attachment: attachment)
        //创建可变的属性字符串
        let attrMStr = NSMutableAttributedString(attributedString: textView.attributedText)
        let range = textView.selectedRange
        attrMStr.replaceCharacters(in: range, with: attrImageStr)
        textView.attributedText = attrMStr
        //将文字大小重置
        textView.font = font
        //将光标设置回原来位置+1
        textView.selectedRange = NSRange(location: range.location+1, length: 0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        textView.inputView = emoticonVC.view
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        textView.becomeFirstResponder()
    }
}

