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
    var isLogin:Bool = false
    
    override func loadView() {
        isLogin ? super.loadView():setupVisitorView()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
}

extension BaseViewController{
    private func setupVisitorView(){
        view = visitorView
    }
}
