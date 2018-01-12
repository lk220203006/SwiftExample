//
//  VisitorView.swift
//  WeiBoWithSB
//
//  Created by digitalforest on 2018/1/8.
//  Copyright © 2018年 liukun. All rights reserved.
//

import UIKit

class VisitorView: UIView {

    // MARK:- 提供快速通过xib创建的类方法
    class func visitorView() -> VisitorView{
        return Bundle.main.loadNibNamed("VisitorView", owner: nil, options: nil)?.first as! VisitorView
    }
}
