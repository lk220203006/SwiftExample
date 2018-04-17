//
//  PhotoBrowserViewCell.swift
//  WeiBoWithSB
//
//  Created by digitalforest on 2018/4/17.
//  Copyright © 2018年 liukun. All rights reserved.
//

import UIKit
import SDWebImage

class PhotoBrowserViewCell: UICollectionViewCell {
    var picURL:NSURL?{
        didSet{
            //nil值校验
            guard let picURL = picURL else {
                return
            }
            //取出image对象
            let image = SDWebImageManager.shared().imageCache?.imageFromDiskCache(forKey: picURL.absoluteString)
            //计算imageview的frame
            let x:CGFloat = 0
            let width = UIScreen.main.bounds.size.width
            let height = width/image!.size.width*image!.size.height
            var y:CGFloat = 0
            if height > UIScreen.main.bounds.size.height {
                y = 0
            }
            else{
                y = (UIScreen.main.bounds.size.height - height) * 0.5
            }
            imageView.frame = CGRect(x: x, y: y, width: width, height: height)
            //设置imageview的图片
            imageView.image = image
        }
    }
    
    private lazy var scrollView:UIScrollView = UIScrollView()
    private lazy var imageView:UIImageView = UIImageView()
    
    //MARK:- 构造函数
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PhotoBrowserViewCell{
    private func setupUI(){
        contentView.addSubview(scrollView)
        scrollView.addSubview(imageView)
        
        scrollView.frame = contentView.bounds
        
    }
}
