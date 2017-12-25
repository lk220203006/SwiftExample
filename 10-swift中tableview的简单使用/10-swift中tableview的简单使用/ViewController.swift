//
//  ViewController.swift
//  10-swift中tableview的简单使用
//
//  Created by digitalforest on 2017/12/22.
//  Copyright © 2017年 liukun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // MARK:- 懒加载的属性
    /// tableview的属性
    lazy var tableView:UITableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK:- 设置UI界面相关
extension ViewController{
    func setupUI() -> Void {
        /*
         1、创建tableview对象
         将tableview添加到控制器的view中
         2、设置tableview的frame
         3、设置数据源
         4、设置代理
         */
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
    }
}

// MARK:- uitableview的数据源和代理方法
//extension类似OC的category，也是只能扩充方法，不能扩充属性
extension ViewController : UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let CellID = "CellID"
        var cell = tableView.dequeueReusableCell(withIdentifier: CellID)
        if cell == nil {
            //在swift中使用枚举：1、枚举类型.具体的类型 2、.具体的类型
            cell = UITableViewCell(style: .default, reuseIdentifier: CellID)
        }
        cell?.textLabel?.text = "测试数据\(indexPath.row)"
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("点击了\(indexPath.row)")
    }
}
