//
//  ViewController.swift
//  09-表情键盘
//
//  Created by digitalforest on 2018/4/2.
//  Copyright © 2018年 liukun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    private lazy var emoticonVC:EmoticonController = EmoticonController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        textView.inputView = emoticonVC.view
        let manager = EmoticonManager()
        for package in manager.packages {
            for emoticon in package.emoticons{
//                print(emoticon)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        textView.becomeFirstResponder()
    }
}

