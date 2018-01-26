//
//  UIBarButtonItem-Extension.swift
//  WeiBoWithSB
//
//  Created by digitalforest on 2018/1/22.
//  Copyright © 2018年 liukun. All rights reserved.
//

import Foundation
import UIKit

extension UIBarButtonItem{
//    convenience init(imageName:String) {
//        self.init()
//        let btn = UIButton()
//        btn.setImage(UIImage(named: imageName), for: .normal)
//        btn.setImage(UIImage(named: imageName+"-highlighted"), for: .highlighted)
//        btn.sizeToFit()
//
//        self.customView = btn;
//    }
    
    convenience init(imageName:String) {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.setImage(UIImage(named: imageName+"_highlighted"), for: .highlighted)
        btn.sizeToFit()
        self.init(customView: btn)
    }
}
