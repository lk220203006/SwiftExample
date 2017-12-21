//
//  ViewController.swift
//  07-闭包的使用
//
//  Created by digitalforest on 2017/12/21.
//  Copyright © 2017年 liukun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var tools:HttpTool = HttpTool()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("--------")
        tools.loadData { (jsonData) in
            print("在ViewController拿到数据:\(jsonData)")
            self.view.backgroundColor = UIColor.red
        }
    }

    deinit {
        print("ViewController --- deinit")
    }
}

