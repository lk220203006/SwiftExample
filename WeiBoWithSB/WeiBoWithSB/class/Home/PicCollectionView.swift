//
//  PicCollectionView.swift
//  WeiBoWithSB
//
//  Created by digitalforest on 2018/2/27.
//  Copyright © 2018年 liukun. All rights reserved.
//

import UIKit

class PicCollectionView: UICollectionView {
    var picURLs:[URL] = [URL](){
        didSet{
            self.reloadData()
        }
    }
    //MARK:- 系统回掉函数
    override func awakeFromNib() {
        super.awakeFromNib()
        dataSource = self
        delegate = self
    }
}

extension PicCollectionView:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return picURLs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //获取cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PicCell", for: indexPath) as! PickCollectionViewCell
        //给cell设置数据
        cell.picURL = picURLs[indexPath.row]
        return cell
    }
}

extension PicCollectionView:UICollectionViewDelegate{
    
}

class PickCollectionViewCell: UICollectionViewCell {
    //MARK:- 定义模型属性
    var picURL:URL?{
        didSet{
            guard let picURL = picURL else {
                return
            }
            iconView.sd_setImage(with: picURL, placeholderImage: UIImage(named: "compose_toolbar_picture"), options: .retryFailed, completed: nil)
        }
    }
    @IBOutlet weak var iconView: UIImageView!
    
}
