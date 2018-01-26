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
        print(NetworkTools.shareInstance)
        print(NetworkTools.shareInstance)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        NetworkTools.shareInstance.request(urlString: "http://httpbin.org", parameters: ["name":"why","age":18])
    }
}

