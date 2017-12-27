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
//        addChildViewController(childVC: HomeViewController(), title: "首页", imageName: "tabbar_home", selectedImageName: "")
//        addChildViewController(childVC: MessageViewController(), title: "消息", imageName: "tabbar_message", selectedImageName: "")
//        addChildViewController(childVC: DiscoverViewController(), title: "发现", imageName: "tabbar_discover", selectedImageName: "")
//        addChildViewController(childVC: ProfileViewController(), title: "我的", imageName: "tabbar_profile", selectedImageName: "")
        //使用字符串初始化类
//        addChildViewController(childVcName: "HomeViewController", title: "首页", imageName: "tabbar_home", selectedImageName: "")
//        addChildViewController(childVcName: "MessageViewController", title: "消息", imageName: "tabbar_message", selectedImageName: "")
//        addChildViewController(childVcName: "DiscoverViewController", title: "发现", imageName: "tabbar_discover", selectedImageName: "")
//        addChildViewController(childVcName: "ProfileViewController", title: "我的", imageName: "tabbar_profile", selectedImageName: "")
        //根据json文件动态添加
        guard let jsonpath = Bundle.main.path(forResource: "MainVCSettings", ofType: "json") else {
            print("没有获取到文件路径")
            return
        }
        guard let jsonData = NSData.init(contentsOfFile: jsonpath) else {
            print("没有获取到文件内容")
            return
        }
        //如果在调用系统某一个方法时，该方法最后有一个throws，说明该方法会抛出异常，如果一个方法会抛出异常，那么需要对该异常进行处理
        /*
         在swift中提供三种处理异常的方式
         方式一：try方式 程序员手动处理异常
         do {
            try JSONSerialization.jsonObject(with: jsonData as Data, options: JSONSerialization.ReadingOptions.mutableContainers)
         } catch  {
            print(error)
         }
         方式二：try？方式，系统帮助我们处理异常，如果该方法出现了异常，则该方法返回nil，如果没有异常，则返回对应的可选对象
         guard let anyObject = try? JSONSerialization.jsonObject(with: jsonData as Data, options: JSONSerialization.ReadingOptions.mutableContainers) else {
            return
         }
         方式三:try!方式,直接告诉系统该方法没有异常，如果该方法出现了异常，程序会闪退
         let anyObject = try! JSONSerialization.jsonObject(with: jsonData as Data, options: JSONSerialization.ReadingOptions.mutableContainers)
         */
        
        guard let anyObject = try? JSONSerialization.jsonObject(with: jsonData as Data, options: JSONSerialization.ReadingOptions.mutableContainers) else {
            return
        }
        guard let dictArray = anyObject as? [[String:AnyObject]] else {
            return
        }
        
        for dict in dictArray {
            guard let vcName = dict["vcName"] as? String else{
                continue
            }
            guard let title = dict["title"] as? String else{
                continue
            }
            guard let imageName = dict["imageName"] as? String else{
                continue
            }
            addChildViewController(childVcName: vcName, title: title, imageName: imageName, selectedImageName: "")
        }
    }
    
    //swift支持方法的重载
    //private在当前的文件中可以访问，但是其他文件不能访问
    private func addChildViewController(childVC:UIViewController,title:String,imageName:String,selectedImageName:String) {
        childVC.title = title
        childVC.tabBarItem.image = UIImage(named: imageName)
        childVC.tabBarItem.selectedImage = UIImage(named: imageName+"_selected")
        let childNav = UINavigationController(rootViewController: childVC)
        addChildViewController(childNav)
    }
    
    private func addChildViewController(childVcName:String,title:String,imageName:String,selectedImageName:String) {
        //获取命名空间
        guard let namespace = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String else {
            print("没有拿到命名空间")
            return
        }
        //根据字符串获取对应的class
        guard let childVcClass = NSClassFromString(namespace + "." + childVcName) else {
            print("没有获取到字符串对应的class")
            return
        }
        //将对应的anyobject转成控制器的类型
        guard let childVcType = childVcClass as? UIViewController.Type else {
            print("没有获取到对应控制器的类型")
            return
        }
        //创建对应的控制器对象
        let childVC = childVcType.init()
        childVC.title = title
        childVC.tabBarItem.image = UIImage(named: imageName)
        childVC.tabBarItem.selectedImage = UIImage(named: imageName+"_selected")
        let childNav = UINavigationController(rootViewController: childVC)
        addChildViewController(childNav)
    }
}
