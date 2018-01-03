//
//  MainViewController.swift
//  weibo
//
//  Created by digitalforest on 2017/12/26.
//  Copyright © 2017年 liukun. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

//    private lazy var composeBtn:UIButton = UIButton.createButton(imageName: "", bgImageName: "tabbar_mid")
    private lazy var composeBtn:UIButton = UIButton(imageName: "", bgImageName: "tabbar_mid")
    override func viewDidLoad() {
        super.viewDidLoad()
        setupComposeBtn()
    }
}


extension MainViewController{
    private func setupComposeBtn(){
        tabBar.addSubview(composeBtn)
        
        composeBtn.center = CGPoint.init(x: tabBar.center.x, y: tabBar.bounds.size.height*0.5)
    }
}
