//
//  ViewController.swift
//  08-正则表达式
//
//  Created by digitalforest on 2018/4/16.
//  Copyright © 2018年 liukun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let str = "fdabcsgfgasdfdsabcgg"
        //创建正则表达式规则
        let pattern = "abc"
        //创建正则表达式对象
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else {
            return
        }
        //匹配字符串中内容
        let results = regex.matches(in: str, options: [], range: NSRange(location: 0, length: str.count))
        for result in results {
            print((str as NSString).substring(with: result.range))
            print(result.range)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

