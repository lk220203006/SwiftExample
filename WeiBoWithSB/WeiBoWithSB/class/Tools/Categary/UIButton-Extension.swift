//
//  UIButton-Extension.swift
//  WeiBoWithSB
//
//  Created by liukun on 2018/1/3.
//  Copyright © 2018年 liukun. All rights reserved.
//

import Foundation
import UIKit

extension UIButton{
    //swift中类方法是以class开头的方法 类似于OC中+开头的方法
    class func createButton(imageName:String,bgImageName:String) -> UIButton {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(named: bgImageName), for: .normal)
        btn.setBackgroundImage(UIImage(named: bgImageName), for: .highlighted)
        btn.sizeToFit()
        return btn
    }
    
    //convenice:便利，使用convenience修饰的构造函数叫做便利构造函数
    //便利构造函数通常用在对系统的类进行构造函数的扩充时使用
    //便利构造函数通常都是卸载extension里面
    //便利构造函数init前面需要加载convenience
    //在便利构造函数中需要明确调用self.init（）
    convenience init (imageName:String,bgImageName:String){
        self.init()
        setBackgroundImage(UIImage(named: bgImageName), for: .normal)
        setBackgroundImage(UIImage(named: bgImageName), for: .highlighted)
        
        setImage(UIImage(named: imageName), for: .normal)
        setImage(UIImage(named: imageName), for: .highlighted)
        sizeToFit()
    }
    
    convenience init(bgColor:UIColor,fontSize:CGFloat,title:String){
        self.init()
        setTitle(title, for: .normal)
        backgroundColor = bgColor
        titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
    }
}
