//
//  ProgressView.swift
//  WeiBoWithSB
//
//  Created by digitalforest on 2018/4/17.
//  Copyright © 2018年 liukun. All rights reserved.
//

import UIKit

class ProgressView: UIView {
    var progress:CGFloat = 0{
        didSet{
            DispatchQueue.main.async {
                self.setNeedsDisplay()
            }
        }
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        super.draw(rect)
        //获取参数
        let center = CGPoint(x: rect.width*0.5, y: rect.height*0.5)
        let radius = rect.width*0.5 - 5
        let startAngle = CGFloat(-Double.pi/2)
        let endAngle = CGFloat(2*Double.pi)*progress+startAngle
        //创建贝塞尔曲线
        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        //绘制一条中心点的线
        path.addLine(to: center)
        path.close()
        //设置绘制颜色
        UIColor(white: 1.0, alpha: 0.4).setFill()
        //开始绘制
        path.fill()
    }

}
