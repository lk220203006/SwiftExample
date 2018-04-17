//
//  EmoticonViewCell.swift
//  09-表情键盘
//
//  Created by digitalforest on 2018/4/11.
//  Copyright © 2018年 liukun. All rights reserved.
//

import UIKit

class EmoticonViewCell: UICollectionViewCell {
    private lazy var emoticonBtn:UIButton = UIButton()
    
    //MARK:- 定义的属性
    var emoticon:Emoticon?{
        didSet{
            guard let emoticon = emoticon else {
                return
            }
            emoticonBtn.setImage(UIImage(contentsOfFile: emoticon.pngPath ?? ""), for: .normal)
            emoticonBtn.setTitle(emoticon.emojiCode, for: .normal)
            if emoticon.isRemove{
                emoticonBtn.setImage(UIImage(named: "compose_emotion_delete"), for: .normal)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EmoticonViewCell{
    private func setupUI(){
        contentView.addSubview(emoticonBtn)
        emoticonBtn.frame = contentView.bounds
        emoticonBtn.isUserInteractionEnabled = false
        emoticonBtn.titleLabel?.font = UIFont.systemFont(ofSize: 32)
    }
}
