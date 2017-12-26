//
//  MainViewController.swift
//  weibo
//
//  Created by digitalforest on 2017/12/26.
//  Copyright © 2017年 liukun. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //创建子控制器
        addChildViewController(childVC: HomeViewController(), title: "首页", imageName: "tabbar_home", selectedImageName: "tabbar_home_selected")
        addChildViewController(childVC: MessageViewController(), title: "消息", imageName: "tabbar_message", selectedImageName: "tabbar_message_selected")
        addChildViewController(childVC: DiscoverViewController(), title: "发现", imageName: "tabbar_discover", selectedImageName: "tabbar_discover_selected")
        addChildViewController(childVC: ProfileViewController(), title: "我的", imageName: "tabbar_profile", selectedImageName: "tabbar_profile_selected")
    }
    
    //swift支持方法的重载
    //private在当前的文件中可以访问，但是其他文件不能访问
    private func addChildViewController(childVC:UIViewController,title:String,imageName:String,selectedImageName:String) {
        childVC.title = title
        childVC.tabBarItem.image = UIImage(named: imageName)
        childVC.tabBarItem.selectedImage = UIImage(named: selectedImageName)
        let childNav = UINavigationController(rootViewController: childVC)
        addChildViewController(childNav)
    }
}
