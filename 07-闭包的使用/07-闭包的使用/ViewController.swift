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
        //解决循环引用
        //方式一 weak
        weak var weakSelf = self
        tools.loadData { (jsonData) in
            print("在ViewController拿到数据:\(jsonData)")
            weakSelf?.view.backgroundColor = UIColor.red
        }
        
        //方式二 unowned
        tools.loadData {[unowned self] (jsonData) in
            print("在ViewController拿到数据:\(jsonData)")
            self.view.backgroundColor = UIColor.red
        }
        
        //方式三
        tools.loadData(callBack:  {[weak self] (jsonData) in
            print("在ViewController拿到数据:\(jsonData)")
            self?.view.backgroundColor = UIColor.red
        })
        
        //尾随闭包 当闭包是最后一个参数时，可以省略()
        tools.loadData {[weak self] (jsonData) in
            print("在ViewController拿到数据:\(jsonData)")
            self?.view.backgroundColor = UIColor.red
        }
    }

    deinit {
        print("ViewController --- deinit")
    }
}

