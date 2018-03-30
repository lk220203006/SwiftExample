//
//  PicPickerViewCell.swift
//  WeiBoWithSB
//
//  Created by digitalforest on 2018/3/30.
//  Copyright © 2018年 liukun. All rights reserved.
//

import UIKit

class PicPickerViewCell: UICollectionViewCell {
    
    @IBOutlet weak var addPhotoBtn: UIButton!
    
    var image:UIImage?{
        didSet{
            if image != nil {
                addPhotoBtn.setBackgroundImage(image, for: .normal)
                addPhotoBtn.isUserInteractionEnabled = false
            }
            else{
                addPhotoBtn.setBackgroundImage(UIImage(named: "compose_pic_add"), for: .normal)
                addPhotoBtn.isUserInteractionEnabled = true
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func addPhotoClick(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: PicPickerAddPhotoNote), object: self)
    }
}
