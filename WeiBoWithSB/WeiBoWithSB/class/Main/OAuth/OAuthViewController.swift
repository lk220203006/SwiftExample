//
//  OAuthViewController.swift
//  WeiBoWithSB
//
//  Created by digitalforest on 2018/1/31.
//  Copyright © 2018年 liukun. All rights reserved.
//

import UIKit
import SVProgressHUD

class OAuthViewController: UIViewController,UIWebViewDelegate {
    
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupNavigationBar()
        loadPage()
    }
}

extension OAuthViewController{
    private func setupNavigationBar(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: .plain, target: self, action: #selector(closeItemClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "填充", style: .plain, target: self, action: #selector(fillItemClick))
        navigationItem.title = "登录页面"
    }
    
    private func loadPage(){
        //获取登录页面的url

        let urlString = "https://api.weibo.com/oauth2/authorize?client_id=\(app_key)&response_type=code&redirect_uri=\(redirect_url)"
        guard let url = URL(string: urlString) else {
            return
        }
        let request = URLRequest(url: url)
        webView.loadRequest(request)
    }
}


extension OAuthViewController{
    @objc private func closeItemClick(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func fillItemClick(){
        //书写js代码
        let jsCode = "document.getElementById('userId').value='15184008326';document.getElementById('passwd').value='1qazxsw2'"
        //执行js代码
        webView.stringByEvaluatingJavaScript(from: jsCode)
    }
}

//MARK:- webview的delegate方法
extension OAuthViewController{
    func webViewDidStartLoad(_ webView: UIWebView){
        SVProgressHUD.show()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        SVProgressHUD.dismiss()
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        guard let url = request.url else {
            return true
        }
        let urlstring = url.absoluteString
        guard urlstring.contains("code=") else {
            return true
        }
        let array = urlstring.components(separatedBy: "code=")
        guard array.count == 2 else{
            return true
        }
        let code = array[1]
        print(code)
        loadAccessToken(code: code)
        return false
    }
}

extension OAuthViewController{
    private func loadAccessToken(code:String){
        NetworkTools.shareInstance.loadAccessToken(code: code) { (result, error) in
            if error != nil{
                print(error!.localizedDescription)
                return
            }
            guard let accountDict = result else{
                return
            }
            print(accountDict)
            let account = UserAccount(dict:accountDict)
            self.loadUserInfo(account: account)
        }
    }
    
    private func loadUserInfo(account:UserAccount){
        guard let accessToken = account.access_token else{
            return
        }
        
        guard let uid = account.uid else {
            return
        }
        //发送网络请求
        NetworkTools.shareInstance.loadUserInfo(access_token: accessToken, uid: uid) { (result, error) in
            if error != nil{
                print(error!.localizedDescription)
                return
            }
            //拿到用户信息的结果
            guard let userInfoDict = result else{
                return
            }
            //保存用户昵称和头像地址
            account.screen_name = userInfoDict["screen_name"] as? String
            account.avatar_large = userInfoDict["avatar_large"] as? String
            
            //将account对象保存
            NSKeyedArchiver.archiveRootObject(account, toFile: UserAccountViewModel.shareInstance.accountPath)
            
            //保存对象
            UserAccountViewModel.shareInstance.account = account;
            //退出当前控制器
            //显示欢迎界面
            self.dismiss(animated: false, completion: {() -> Void in
                UIApplication.shared.keyWindow?.rootViewController = WelcomeViewController(nibName: "WelcomeViewController", bundle: nil)
            })
        }
    }
}
