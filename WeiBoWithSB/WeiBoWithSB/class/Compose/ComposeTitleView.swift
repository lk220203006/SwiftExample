//
//  ComposeTitleView.swift
//  WeiBoWithSB
//
//  Created by digitalforest on 2018/3/28.
//  Copyright © 2018年 liukun. All rights reserved.
//

import UIKit
import SnapKit

class ComposeTitleView: UIView {
    //MARK:- 懒加载属性
    private lazy var titleLabel:UILabel = UILabel()
    private lazy var screenNameLabel:UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK:- 设置UI界面
extension ComposeTitleView{
    private func setupUI(){
        //将子控件添加到view中
        addSubview(titleLabel)
        addSubview(screenNameLabel)
        //设置frame
        titleLabel.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(self)
            make.top.equalTo(self)
        }
        screenNameLabel.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(titleLabel.snp.centerX)
            make.top.equalTo(titleLabel.snp.bottom).offset(3)
        }
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        screenNameLabel.font = UIFont.systemFont(ofSize: 14)
        screenNameLabel.textColor = UIColor.lightGray
        titleLabel.text = "发微博"
        screenNameLabel.text = UserAccountViewModel.shareInstance.account?.screen_name
    }
}
