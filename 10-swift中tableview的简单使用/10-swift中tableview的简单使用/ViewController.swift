//
//  ViewController.swift
//  10-swift中tableview的简单使用
//
//  Created by digitalforest on 2017/12/22.
//  Copyright © 2017年 liukun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var tableView:UITableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        /*
         1、创建tableview对象
         将tableview添加到控制器的view中
         2、设置tableview的frame
         3、设置数据源
         4、设置代理
         */
        view.addSubview(tableView)
        tableView.frame = view.bounds
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

