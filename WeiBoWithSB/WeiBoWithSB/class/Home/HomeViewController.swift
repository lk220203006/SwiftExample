//
//  HomeViewController.swift
//  weibo
//
//  Created by digitalforest on 2017/12/26.
//  Copyright © 2017年 liukun. All rights reserved.
//

import UIKit
import CoreGraphics

class HomeViewController: BaseViewController {
    
    private lazy var titleBtn :TitleButton = TitleButton()
    //在闭包中如果使用当前对象的属性或者调用方法，也需要加self
    //两个地方需要使用self：1、如果在一个函数中出现歧义 2、在闭包中使用当前对象的属性和方法也需要加self
    private lazy var popoverAnimator:PopoverAnimator = PopoverAnimator(callBack: {[weak self] (presented)->() in
        self?.titleBtn.isSelected = presented
    })
    
    private lazy var statuses:[Status] = [Status]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        visitorView.addRotationAnim()
        if !isLogin {
            return
        }
        
        setupNavigationBar()
        loadStatuses()
        
        let createAtStr = "Fri Apr 08 11:16:29 +0800 2016"
        //创建时间格式化对象
        let fmt = DateFormatter()
        fmt.dateFormat = "EEE MM dd HH:mm:ss Z yyyy"
        fmt.locale = Locale(identifier: "en")
        //将字符串时间转成date类型
        guard let createDate = fmt.date(from: createAtStr) else {
            return
        }
        //创建当前时间
        let nowDate = Date()
        //获取时间差
        let interval = nowDate.timeIntervalSince(createDate)
        //一分钟内
        if interval < 60 {
            print("刚刚")
            return
        }
        //1小时前
        if interval < 60 * 60 * 24{
            print("\(interval/(60*60))小时前")
            return
        }
        //昨天数据
        let calendar = Calendar.current
        if calendar.isDateInYesterday(createDate){
            fmt.dateFormat = "昨天 HH:mm"
            let timestr = fmt.string(from: createDate)
            print(timestr)
            return
        }
        //处理一年之内
        let cmps = calendar.dateComponents(Set<>, from: createDate, to: nowDate)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return statuses.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath)
        let status = statuses[indexPath.row]
        cell.textLabel?.text = status.text
        return cell
    }
}

// MARK:- 设置UI界面
extension HomeViewController{
    private func setupNavigationBar(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "navigationbar_friendsearch")
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "navigationbar_pop")
        
        titleBtn.setTitle("coderwhy", for: .normal)
        titleBtn.addTarget(self, action: #selector(titleBtnClick(_:)), for: .touchUpInside)
        navigationItem.titleView = titleBtn
    }
}
// MARK:- 事件监听
extension HomeViewController{
    @objc private func titleBtnClick(_ sender:TitleButton){
        //创建弹出的控制器
        let vc = PopoverViewController()
        //设置控制器的modal样式
        vc.modalPresentationStyle = .custom
        vc.view.backgroundColor = UIColor.lightGray
        //设置转场的代理
        vc.transitioningDelegate = popoverAnimator
        popoverAnimator.presentedFrame = CGRect(x: UIScreen.main.bounds.width*0.5-90, y: 55, width: 180, height: 250)
        present(vc, animated: true, completion: nil)
    }
}

// MARK:- 请求数据
extension HomeViewController{
    private func loadStatuses(){
        NetworkTools.shareInstance.loadStatuses { (result, error) -> () in
            if error != nil{
                print(error as Any)
                return
            }
            //获取可选类型中的数据
            guard let resultArray = result else{
                return
            }
            for statusDict in resultArray{
                let status = Status(dict: statusDict)
                self.statuses.append(status)
            }
            //刷新表格
            self.tableView.reloadData()
        }
    }
}

extension HomeViewController{
    
}
