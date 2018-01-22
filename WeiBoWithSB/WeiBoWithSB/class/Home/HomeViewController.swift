//
//  HomeViewController.swift
//  weibo
//
//  Created by digitalforest on 2017/12/26.
//  Copyright © 2017年 liukun. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    
    private lazy var titleBtn :TitleButton = TitleButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        visitorView.addRotationAnim()
        if !isLogin {
            return
        }
        
        setupNavigationBar()
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
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "user")
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "scan-o")
        
        titleBtn.setTitle("coderwhy", for: .normal)
        titleBtn.addTarget(self, action: #selector(titleBtnClick(_:)), for: .touchUpInside)
        navigationItem.titleView = titleBtn
    }
}

extension HomeViewController{
    @objc private func titleBtnClick(_ sender:TitleButton){
        NSLog("titleBtnClick")
        sender.select(<#T##sender: Any?##Any?#>)
    }
}
