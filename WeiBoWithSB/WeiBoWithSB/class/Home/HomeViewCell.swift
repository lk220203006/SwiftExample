//
//  HomeViewCell.swift
//  WeiBoWithSB
//
//  Created by digitalforest on 2018/2/24.
//  Copyright © 2018年 liukun. All rights reserved.
//

import UIKit
import SDWebImage

private let edgeMargin:CGFloat = 15
private let itemMaigin:CGFloat = 10

@objcMembers
class HomeViewCell: UITableViewCell {
    //MARK:- 控件属性
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var verifiedView: UIImageView!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var vipView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var contentLabel: HYLabel!
    @IBOutlet weak var picView: PicCollectionView!
    @IBOutlet weak var retweetedContentLabel: HYLabel!
    @IBOutlet weak var retweetedBgView: UIView!
    
    //MARK:- 约束的属性
    @IBOutlet weak var picViewWCons: NSLayoutConstraint!
    @IBOutlet weak var picViewHCons: NSLayoutConstraint!
    @IBOutlet weak var picViewBottomCons: NSLayoutConstraint!
    
    @IBOutlet weak var retweetedContentLabelTopCons: NSLayoutConstraint!
    //MARK:- 自定义属性
    var viewModel:StatusViewModel?{
        didSet{
            guard let viewModel = viewModel else {
                return
            }
            //用户头像
            iconView.sd_setImage(with: viewModel.profileURL, placeholderImage: nil, options: .retryFailed, completed: nil)
            //认证图标
            verifiedView.image = viewModel.verifiedImage
            //用户昵称
            screenNameLabel.text = viewModel.status?.user?.screen_name
            //会员图标
            vipView.image = viewModel.vipImage
            //时间
            timeLabel.text = viewModel.createAtText
            //来源
            if let sourceText = viewModel.sourceText {
                sourceLabel.text = "来自 " + sourceText
            }
            else{
                sourceLabel.text = nil
            }
            //设置正文
            contentLabel.attributedText = FindEmoticon.shareInstance.findAttrString(statusText: viewModel.status?.text, font: contentLabel.font)
            //设置昵称的文字颜色
            screenNameLabel.textColor = viewModel.vipImage == nil ? UIColor.black : UIColor.orange
            //计算picView的宽度和高度的约束
            let picViewSize = calculatePicViewSize(count: viewModel.picURLs.count)
            picViewWCons.constant = picViewSize.width
            picViewHCons.constant = picViewSize.height
            //将picURL数据传递给picView
            picView.picURLs = viewModel.picURLs
            //设置转发微博的正文
            if viewModel.status?.retweeted_status != nil {
                if let screenName = viewModel.status?.retweeted_status?.user?.screen_name,
                    let retweetedText = viewModel.status?.retweeted_status?.text{
                    let retweetedT = "@" + screenName + ":" + retweetedText
                    retweetedContentLabel.attributedText = FindEmoticon.shareInstance.findAttrString(statusText: retweetedT, font: retweetedContentLabel.font)
                    retweetedContentLabelTopCons.constant = 15;
                }
                retweetedBgView.isHidden = false
            }
            else{
                retweetedContentLabel.text = nil
                retweetedContentLabelTopCons.constant = 0;
                retweetedBgView.isHidden = true
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentLabel.matchTextColor = UIColor.orange
        retweetedContentLabel.matchTextColor = UIColor.orange
        // 监听@谁谁谁的点击
        contentLabel.userTapHandler = { (label, user, range) in
            print(user)
            print(range)
        }
        
        // 监听链接的点击
        contentLabel.linkTapHandler = { (label, link, range) in
            print(link)
            print(range)
        }
        
        // 监听话题的点击
        contentLabel.topicTapHandler = { (label, topic, range) in
            print(topic)
            print(range)
        }
        
        // 监听@谁谁谁的点击
        retweetedContentLabel.userTapHandler = { (label, user, range) in
            print(user)
            print(range)
        }
        
        // 监听链接的点击
        retweetedContentLabel.linkTapHandler = { (label, link, range) in
            print(link)
            print(range)
        }
        
        // 监听话题的点击
        retweetedContentLabel.topicTapHandler = { (label, topic, range) in
            print(topic)
            print(range)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

//MARK:- 计算方法
extension HomeViewCell{
    private func calculatePicViewSize(count:Int) -> CGSize{
        //取出picview的布局
        let layout = picView.collectionViewLayout as! UICollectionViewFlowLayout
        
        //没有配图
        if count == 0 {
            picViewBottomCons.constant = 0;
            return CGSize.zero
        }
        picViewBottomCons.constant = 10;
        //计算出来imageviewwh
        let imageViewWH = (UIScreen.main.bounds.width - 2*edgeMargin-2*itemMaigin)/3
        //取出图片
        var height:CGFloat = 0
        for picURL in (viewModel?.picURLs)!{
            let urlString = picURL.absoluteString
            let image = SDWebImageManager.shared().imageCache?.imageFromDiskCache(forKey: urlString)
            let imageh = (image?.size.height)!*imageViewWH/(image?.size.width)!
            if imageh > height{
                height = imageh
            }
        }
        
        //单张配图
        if count == 1 {
            layout.itemSize = CGSize(width: imageViewWH, height: height)
            //请求到图片的宽度和高度
            return CGSize(width: imageViewWH, height: height)
        }
        layout.itemSize = CGSize(width: imageViewWH, height: imageViewWH)
        
        //四张配图
        if count == 4 {
            let picViewWH = imageViewWH * 2 + itemMaigin*2
            return CGSize(width: picViewWH, height: picViewWH)
        }
        //其它张配图
        //计算行数
        let rows = CGFloat((count-1)/3+1)
        //计算高度
        let picViewH = rows * imageViewWH + (rows-1)*itemMaigin
        //计算宽度
        let picViewW = UIScreen.main.bounds.width - 2*edgeMargin
        return CGSize(width: picViewW, height: picViewH)
    }
}
