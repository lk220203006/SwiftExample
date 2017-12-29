//
//  MainViewController.swift
//  weibo
//
//  Created by digitalforest on 2017/12/26.
//  Copyright © 2017年 liukun. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    private lazy var composeBtn:UIButton = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupComposeBtn()
    }
}


extension MainViewController{
    private func setupComposeBtn(){
        tabBar.addSubview(composeBtn)
        composeBtn.setBackgroundImage(UIImage(named: "tabbar_mid"), for: .normal)
        composeBtn.setBackgroundImage(UIImage(named: "tabbar_mid"), for: .highlighted)
        composeBtn.sizeToFit()
        composeBtn.center = CGPoint.init(x: tabBar.center.x, y: tabBar.bounds.size.height*0.5)
    }
}
