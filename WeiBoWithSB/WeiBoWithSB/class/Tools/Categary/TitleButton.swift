//
//  TitleButton.swift
//  WeiBoWithSB
//
//  Created by digitalforest on 2018/1/22.
//  Copyright © 2018年 liukun. All rights reserved.
//

import UIKit

class TitleButton: UIButton {
    //MARK:- 重写init函数
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setImage(UIImage(named: "drop-o-highlighted"), for: .normal)
        setImage(UIImage(named: "rise-o-highlighted"), for: .selected)
        setTitleColor(UIColor.black, for: .normal)
        sizeToFit()
    }
    //swift中规定：重写控件的init方法必须重写init?(coder aDecoder: NSCoder)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel!.frame.origin.x = 0
        imageView!.frame.origin.x = titleLabel!.frame.size.width + 5
    }
}
