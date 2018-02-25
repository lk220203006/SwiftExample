//
//  HomeViewCell.swift
//  WeiBoWithSB
//
//  Created by digitalforest on 2018/2/24.
//  Copyright © 2018年 liukun. All rights reserved.
//

import UIKit
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
    @IBOutlet weak var contentLabel: UILabel!
    //MARK:- 约束的属性
    @IBOutlet weak var picViewWCons: NSLayoutConstraint!
    @IBOutlet weak var picViewHCons: NSLayoutConstraint!
    
    //MARK:- 自定义属性
    var viewModel:StatusViewModel?{
        didSet{
            guard let viewModel = viewModel else {
                return
            }
            //用户头像
            iconView.sd_setImage(with: viewModel.profileURL, placeholderImage: UIImage(named: ""), options: .retryFailed, completed: nil)
            //认证图标
            verifiedView.image = viewModel.verifiedImage
            //用户昵称
            screenNameLabel.text = viewModel.status?.user?.screen_name
            //会员图标
            vipView.image = viewModel.vipImage
            //时间
            timeLabel.text = viewModel.createAtText
            //来源
            sourceLabel.text = viewModel.sourceText
            //设置正文
            contentLabel.text = viewModel.status?.text
            //设置昵称的文字颜色
            screenNameLabel.textColor = viewModel.vipImage == nil ? UIColor.black : UIColor.orange
            //计算picView的宽度和高度的约束
            let picViewSize = calculatePicViewSize(count: viewModel.picURLs.count)
            picViewWCons.constant = picViewSize.width
            picViewHCons.constant = picViewSize.height
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension HomeViewCell{
    private func calculatePicViewSize(count:Int) -> CGSize{
        if count == 0 {
            return CGSize.zero
        }
        let imageViewWH = (UIScreen.main.bounds.width - 2*edgeMargin-2*itemMaigin)/3
        if count == 4 {
            let picViewWH = imageViewWH * 2 + itemMaigin
            return CGSize(width: picViewWH, height: picViewWH)
        }
        let rows = CGFloat((count-1)/3+1)
        let picViewH = rows * imageViewWH + (rows-1)*itemMaigin
        let picViewW = UIScreen.main.bounds.width - 2*edgeMargin
        return CGSize(width: picViewW, height: picViewH)
    }
}
