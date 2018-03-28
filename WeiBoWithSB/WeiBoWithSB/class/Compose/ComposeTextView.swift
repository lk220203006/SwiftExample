//
//  ComposeTextView.swift
//  WeiBoWithSB
//
//  Created by digitalforest on 2018/3/28.
//  Copyright © 2018年 liukun. All rights reserved.
//

import UIKit
import SnapKit

class ComposeTextView: UITextView {
    lazy var placeHolderLabel:UILabel = UILabel()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
}


extension ComposeTextView{
    private func setupUI(){
        addSubview(placeHolderLabel)
        placeHolderLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self).offset(8)
            make.left.equalTo(self).offset(10)
        }
        placeHolderLabel.textColor = UIColor.lightGray
        placeHolderLabel.font = font
        placeHolderLabel.text = "分享新鲜事..."
        
        //设置内容的内边距
        textContainerInset = UIEdgeInsetsMake(8, 5, 0, 5)
    }
}
