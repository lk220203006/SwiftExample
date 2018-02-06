//
//  UserAccountTool.swift
//  WeiBoWithSB
//
//  Created by digitalforest on 2018/2/6.
//  Copyright © 2018年 liukun. All rights reserved.
//

import UIKit

class UserAccountViewModel {
    //MARK:- 将类设计成单例
    static let shareInstance:UserAccountViewModel = UserAccountViewModel()
    //MARK:- 定义属性
    var account:UserAccount?
    //MARK:- 计算属性
    var isLogin:Bool{
        if account == nil {
            return false
        }
        guard let expiresDate = account?.expires_date else{
            return false
        }
        return expiresDate.compare(Date()) == .orderedDescending
    }
    
    //MARK:- 计算属性
    var accountPath:String{
        let accountPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        return (accountPath as NSString).appendingPathComponent("accout.plist")
    }
    //MARK:- 重写init方法
    init() {
        account = NSKeyedUnarchiver.unarchiveObject(withFile: accountPath) as? UserAccount
    }
}
