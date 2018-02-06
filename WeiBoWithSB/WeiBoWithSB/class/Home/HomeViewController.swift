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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        visitorView.addRotationAnim()
        if !isLogin {
            return
        }
        
        setupNavigationBar()
        loadStatuses()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

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
                print(statusDict)
            }
        }
    }
}
