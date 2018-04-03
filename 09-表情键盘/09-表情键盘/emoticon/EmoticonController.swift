//
//  EmoticonController.swift
//  09-表情键盘
//
//  Created by digitalforest on 2018/4/2.
//  Copyright © 2018年 liukun. All rights reserved.
//

import UIKit

class EmoticonController: UIViewController {
    private lazy var collectionView:UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    private lazy var toolBar:UIToolbar = UIToolbar()

    //MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}


extension EmoticonController{
    private func setupUI(){
        //添加子控件
        view.addSubview(collectionView)
        view.addSubview(toolBar)
        
        //设置子控件的frame
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        
         NSLayoutConstraint.constraints(withVisualFormat: <#T##String#>, options: <#T##NSLayoutFormatOptions#>, metrics: <#T##[String : Any]?#>, views: <#T##[String : Any]#>)
    }
}
