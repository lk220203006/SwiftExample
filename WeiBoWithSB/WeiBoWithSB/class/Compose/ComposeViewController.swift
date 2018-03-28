//
//  ComposeViewController.swift
//  WeiBoWithSB
//
//  Created by digitalforest on 2018/3/28.
//  Copyright © 2018年 liukun. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {
    
    lazy var titleView:ComposeTitleView = ComposeTitleView()
    @IBOutlet weak var textView: ComposeTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //设置导航栏
        setNavgationBar()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        textView.becomeFirstResponder()
    }
}
// MARK:- 设置UI界面
extension ComposeViewController{
    private func setNavgationBar(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: .plain, target: self, action: #selector(closeItemClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发送", style: .plain, target: self, action: #selector(sendItemClick))
        navigationItem.rightBarButtonItem?.isEnabled = false
        titleView.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        titleView.layoutIfNeeded()
        navigationItem.titleView = titleView
    }
}

// MARK:- 事件监听
extension ComposeViewController{
    @objc private func closeItemClick(){
        dismiss(animated: true, completion: nil)
    }
    @objc private func sendItemClick(){
        
    }
}

extension ComposeViewController:UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
        self.textView.placeHolderLabel.isHidden = textView.hasText
        navigationItem.rightBarButtonItem?.isEnabled = textView.hasText
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.textView.resignFirstResponder()
    }
}
