//
//  ViewController.swift
//  02-异常的练习
//
//  Created by digitalforest on 2017/12/27.
//  Copyright © 2017年 liukun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //正则表达式
        let pattern = "abc"
        guard let regex = try? NSRegularExpression.init(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive) else{
            return
        }
        
    }
}

