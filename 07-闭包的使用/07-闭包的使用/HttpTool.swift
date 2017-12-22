//
//  HttpTool.swift
//  07-闭包的使用
//
//  Created by digitalforest on 2017/12/21.
//  Copyright © 2017年 liukun. All rights reserved.
//

import UIKit

class HttpTool: NSObject {
    
    var callBack:((_ jsonData:String) -> ())?
    
    //闭包的类型:(参数列表) -> (返回值类型)
    func loadData(callBack:@escaping (_ jsonData:String) -> ()) {
        self.callBack = callBack;
        DispatchQueue.global().async { () -> Void in
            print("发送网络请求:\(Thread.current)")
            DispatchQueue.main.async { () -> Void in
                print("获取到数据，并且进行回掉:\(Thread.current)")
                callBack("jsonData数据")
            }
        }
    }
}
