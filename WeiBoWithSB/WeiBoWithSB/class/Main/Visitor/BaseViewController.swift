//
//  BaseViewController.swift
//  WeiBoWithSB
//
//  Created by digitalforest on 2018/1/8.
//  Copyright © 2018年 liukun. All rights reserved.
//

import UIKit

class BaseViewController: UITableViewController {
    
    lazy var visitorView : VisitorView = VisitorView.visitorView()
    
    // MARK:- 定义变量
    var isLogin:Bool = true
    
    override func loadView() {
        isLogin ? super.loadView():setupVisitorView()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItems()
    }
}

// MARK:- 设置UI界面
extension BaseViewController{
    //设置访客试图
    private func setupVisitorView(){
        view = visitorView
        visitorView.registerBtn.addTarget(self, action: #selector(leftbarClick), for: .touchUpInside)
        visitorView.loginBtn.addTarget(self, action: #selector(rightbarClick), for: .touchUpInside)
    }
    
    //设置导航栏左右的Item
    private func setupNavigationItems(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: .plain, target: self, action: #selector(leftbarClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: .plain, target: self, action: #selector(rightbarClick))
    }
}

// MARK:- 事件监听
extension BaseViewController{
    @objc private func leftbarClick(){
        NSLog("leftbarClick")
    }
    
    @objc private func rightbarClick(){
        NSLog("rightbarClick")
    }
}
