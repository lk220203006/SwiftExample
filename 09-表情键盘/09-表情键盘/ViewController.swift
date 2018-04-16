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
    
    private lazy var emoticonVC:EmoticonController = EmoticonController {[weak self] (emoticon) in
        self?.textView.insertEmoticon(emoticon: emoticon)
    }
    
    @IBAction func sendItemClick(_ sender: Any) {
        print(self.textView.getEmoticonString())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        textView.inputView = emoticonVC.view
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        textView.becomeFirstResponder()
    }
}

