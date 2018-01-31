//
//  ViewController.swift
//  AFNetWorking的封装
//
//  Created by digitalforest on 2018/1/25.
//  Copyright © 2018年 liukun. All rights reserved.
//

import UIKit

/*
 两种单例方式
 1、通过shareInstance拿到的永远是一个实例
 2、永远只要一个实例
 */

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        NetworkTools.shareInstance.request(methodType: .GET,urlString: "http://httpbin.org/get", parameters: ["name":"why" as AnyObject,"age":18 as AnyObject],finished: {(result,error)->() in
            if error != nil{
                print(error?.localizedDescription as Any)
            }
            else{
                print(result!)
            }
        })
        NetworkTools.shareInstance.request(methodType: .POST,urlString: "http://httpbin.org/post", parameters: ["name":"why" as AnyObject,"age":18 as AnyObject],finished:{(result,error)->() in
            if error != nil{
                print(error?.localizedDescription as Any)
            }
            else{
                print(result!)
            }
        })
    }
}

