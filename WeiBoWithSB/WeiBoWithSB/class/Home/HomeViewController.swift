//
//  HomeViewController.swift
//  weibo
//
//  Created by digitalforest on 2017/12/26.
//  Copyright © 2017年 liukun. All rights reserved.
//

import UIKit
import CoreGraphics
import SDWebImage
import MJRefresh

class HomeViewController: BaseViewController {
    
    private lazy var titleBtn :TitleButton = TitleButton()
    //在闭包中如果使用当前对象的属性或者调用方法，也需要加self
    //两个地方需要使用self：1、如果在一个函数中出现歧义 2、在闭包中使用当前对象的属性和方法也需要加self
    private lazy var popoverAnimator:PopoverAnimator = PopoverAnimator(callBack: {[weak self] (presented)->() in
        self?.titleBtn.isSelected = presented
    })
    
    private lazy var viewModels:[StatusViewModel] = [StatusViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.estimatedRowHeight = 180
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.tableFooterView = UIView()
        visitorView.addRotationAnim()
        if !isLogin {
            return
        }
        setupNavigationBar()
        setupHeaderView()
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
        return viewModels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as! HomeViewCell
        cell.viewModel = viewModels[indexPath.row]
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//
//    }
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
    
    private func setupHeaderView(){
        let header = MJRefreshNormalHeader {
            self.loadNewStatuses()
        }
        header?.setTitle("下拉刷新", for: .idle)
        header?.setTitle("释放刷新", for: .pulling)
        header?.setTitle("加载中", for: .refreshing)
        tableView.mj_header = header
        tableView.mj_header.beginRefreshing()
    }
    
    private func setupFooterView(){
        let footer = MJRefreshAutoFooter {
            self.loadMoreStatuses()
        }
        tableView.mj_footer = footer
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
    //加载最新的数据
    @objc private func loadNewStatuses(){
        loadStatuses(isNewData: true)
    }
    @objc private func loadMoreStatuses(){
        loadStatuses(isNewData: false)
    }
    private func loadStatuses(isNewData:Bool){
        //获取sinceid
        var since_id = 0;
        if isNewData {
            since_id = viewModels.first?.status?.mid ?? 0
        }
        else{
            since_id = viewModels.last?.status?.mid ?? 0
        }
        NetworkTools.shareInstance.loadStatuses(since_id: since_id, finished: { (result, error) -> () in
            if error != nil{
                print(error as Any)
                return
            }
            //获取可选类型中的数据
            guard let resultArray = result else{
                return
            }
            //遍历微博对应的字典
            for statusDict in resultArray{
                let status = Status(dict: statusDict)
                let viewModel = StatusViewModel(status: status)
                self.viewModels.append(viewModel)
            }
            //缓存图片
            self.cacheImages(viewModels: self.viewModels)
            //刷新表格
//            self.tableView.reloadData()
        })
    }
    
    private func cacheImages(viewModels:[StatusViewModel]){
        //创建group
        let group = DispatchGroup()
        
        
        //缓存图片
        for viewmodel in viewModels {
            for picURL in viewmodel.picURLs{
                group.enter()
                SDWebImageManager.shared().loadImage(with: picURL, options: [], progress: nil, completed: { (_, _, _, _, _, _) in
                    group.leave()
                })
            }
        }
        group.notify(queue: DispatchQueue.main) {
            self.tableView.reloadData()
            self.tableView.mj_header.endRefreshing()
        }
    }
}

extension HomeViewController{
    
}
