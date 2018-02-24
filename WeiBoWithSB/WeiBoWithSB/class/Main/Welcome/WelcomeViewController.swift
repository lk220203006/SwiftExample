//
//  WelcomeViewController.swift
//  WeiBoWithSB
//
//  Created by digitalforest on 2018/2/6.
//  Copyright © 2018年 liukun. All rights reserved.
//

import UIKit
import SDWebImage

class WelcomeViewController: UIViewController {
    
    //MARK:- 拖线的属性
    @IBOutlet weak var iconViewBottomsCons: NSLayoutConstraint!
    @IBOutlet weak var iconView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let profileURL = UserAccountViewModel.shareInstance.account?.avatar_large
        //??: 如果？？前面的可选类型有值，那么将前面的可选类型进行解包并且赋值
        //??: 如果？？前面的可选类型为nil，那么直接使用？？后面的值
        let url = URL(string: profileURL ?? "")
        iconView.sd_setImage(with: url, placeholderImage: UIImage(named: "avatar_default_big"))
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //改变约束
        iconViewBottomsCons.constant = UIScreen.main.bounds.size.height - 200
        //执行动画
        //Damping:阻力系数，阻力系数越大弹动的效果越不明显
        //initialSpringVelocity:初始化速度
        UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 5.0, options:.curveEaseInOut, animations: {() -> Void in
            self.view.layoutIfNeeded()
        }, completion: {(finished:Bool) -> Void in
            UIApplication.shared.keyWindow?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        })
    }
}
