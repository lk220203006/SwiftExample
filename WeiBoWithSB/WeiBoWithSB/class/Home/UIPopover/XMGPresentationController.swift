//
//  XMGPresentationController.swift
//  WeiBoWithSB
//
//  Created by digitalforest on 2018/1/24.
//  Copyright © 2018年 liukun. All rights reserved.
//

import UIKit

class XMGPresentationController: UIPresentationController {
    // MARK:- 对外提供属性
    var presentedFrame:CGRect = CGRect.zero
    private lazy var coverView:UIView = UIView()
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        
        //设置弹出view的尺寸
        presentedView?.frame = presentedFrame
        //添加蒙版
        setupCoverView()
    }
}


extension XMGPresentationController{
    private func setupCoverView(){
        //添加蒙版
        containerView?.insertSubview(coverView, at: 0)
        //设置蒙版的属性
        coverView.backgroundColor = UIColor(white: 0.8, alpha: 0.4)
        coverView.frame = containerView!.bounds
        //添加手势
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(coverViewClick))
        coverView.addGestureRecognizer(tapGes)
    }
}

extension XMGPresentationController{
    @objc private func coverViewClick(){
        print("coverViewClick")
        presentedViewController.dismiss(animated: true, completion: nil)
    }
}
