//
//  PhotoBrowserViewCell.swift
//  WeiBoWithSB
//
//  Created by digitalforest on 2018/4/17.
//  Copyright © 2018年 liukun. All rights reserved.
//

import UIKit
import SDWebImage

protocol PhotoBrowserViewCellDelegate:NSObjectProtocol {
    func imageViewClick()
}

class PhotoBrowserViewCell: UICollectionViewCell {
    var picURL:NSURL?{
        didSet{
            setupContent(picURL: picURL)
        }
    }
    
    var delegate:PhotoBrowserViewCellDelegate?
    
    private lazy var scrollView:UIScrollView = UIScrollView()
    lazy var imageView:UIImageView = UIImageView()
    private lazy var progressView:ProgressView = ProgressView()
    
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
        //添加子控件
        contentView.addSubview(scrollView)
        scrollView.addSubview(imageView)
        contentView.addSubview(progressView)
        
        //设置子控件frame
        scrollView.frame = contentView.bounds
        scrollView.frame.size.width -= 20
        progressView.bounds = CGRect(x: 0, y: 0, width: 80, height: 80)
        progressView.center = CGPoint(x: UIScreen.main.bounds.size.width*0.5, y: UIScreen.main.bounds.size.height*0.5)
        
        progressView.isHidden = true
        progressView.backgroundColor = UIColor.black
        
        //监听imageview的点击
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(imageViewClick))
        imageView.addGestureRecognizer(tapGes)
        imageView.isUserInteractionEnabled = true
    }
}

extension PhotoBrowserViewCell{
    @objc private func imageViewClick(){
        guard let delegate = delegate else {
            return
        }
        delegate.imageViewClick()
    }
}

extension PhotoBrowserViewCell{
    private func setupContent(picURL:NSURL?){
        //nil值校验
        guard let picURL = picURL else {
            return
        }
        //取出image对象
        let image = SDWebImageManager.shared().imageCache?.imageFromDiskCache(forKey: picURL.absoluteString)
        self.setFrame(image: image)
        
        //设置imageview的图片
        self.progressView.isHidden = false
        imageView.sd_setImage(with: getBidURL(smallURL: picURL) as URL, placeholderImage: image, options: [], progress: { (receivedSize, expectedSize, targetURL)->Void in
            self.progressView.progress = CGFloat(receivedSize)/CGFloat(expectedSize)
        }) { (image, error, cacheType, imageURL)->Void in
            self.progressView.isHidden = true
            self.setFrame(image: image)
        }
    }
    
    private func setFrame(image:UIImage?){
        //计算imageview的frame
        let x:CGFloat = 0
        let width = UIScreen.main.bounds.size.width
        let height = image!.size.height * width/image!.size.width
        var y:CGFloat = 0
        if height > UIScreen.main.bounds.size.height {
            y = 0
        }
        else{
            y = (UIScreen.main.bounds.size.height - height) * 0.5
        }
        self.imageView.frame = CGRect(x: x, y: y, width: width, height: height)
        //设置scrollview的contentsize
        self.scrollView.contentSize = CGSize(width: 0, height: height)
    }
    
    private func getBidURL(smallURL:NSURL)->NSURL{
        guard let smallURLStr = smallURL.absoluteString else {
            return NSURL(string: "")!
        }
        let bigURLString = smallURLStr.replacingOccurrences(of: "thumbnail", with: "bmiddle")
        return NSURL(string: bigURLString)!
    }
}
