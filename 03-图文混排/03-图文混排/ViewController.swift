//
//  ViewController.swift
//  03-图文混排
//
//  Created by digitalforest on 2018/4/12.
//  Copyright © 2018年 liukun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var demoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let attStr = NSAttributedString(string: "小码哥", attributes: [NSAttributedStringKey.foregroundColor:UIColor.red])
        let attStr2 = NSAttributedString(string: "IT教育", attributes: [NSAttributedStringKey.foregroundColor:UIColor.blue])
        
        let attacment = NSTextAttachment()
        attacment.image = UIImage(named: "d_aini")
        let font = demoLabel.font!
        attacment.bounds = CGRect(x: 0, y: -4, width: font.lineHeight, height: font.lineHeight)
        let attrImageStr = NSAttributedString(attachment: attacment)
        
        let attrMStr = NSMutableAttributedString()
        attrMStr.append(attStr)
        attrMStr.append(attrImageStr)
        attrMStr.append(attStr2)
        demoLabel.attributedText = attrMStr
    }
}

