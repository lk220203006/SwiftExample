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
    private lazy var composeBtn:UIButton = UIButton(imageName: "tabbar_compose_icon_add", bgImageName: "tabbar_compose_button")
    override func viewDidLoad() {
        super.viewDidLoad()
        setupComposeBtn()
    }
}


extension MainViewController{
    private func setupComposeBtn(){
        //将composebtn添加到tabbar中
        tabBar.addSubview(composeBtn)
        //设置位置
        composeBtn.center = CGPoint.init(x: tabBar.center.x, y: tabBar.bounds.size.height*0.5)
        //监听发布按钮的点击
        //selector两种方法：1、Selector("composeBtnClick") 2、直接字符串"composeBtnClick"
        composeBtn.addTarget(self, action: #selector(composeBtnClick), for: .touchUpInside)
    }
}

// MARK:- 事件监听
extension MainViewController{
    //事件监听本质发送消息，但是发送消息是OC的特性
    //将方法包装成SEL->类中查找方法列表->根据@sel找到imp指针（函数指针）->执行函数
    //如果swift中将一个函数声明为private，那么该函数不会被添加到方法列表中
    //如果在private前面加上@obj，那么该方法依然会被添加到方法列表中
    @objc private func composeBtnClick(){
        //创建发布控制器
        let composeVC = ComposeViewController()
        //包装导航控制器
        let composeNav = UINavigationController(rootViewController: composeVC)
        //弹出控制器
        present(composeNav, animated: true, completion: nil)
    }
}
