//
//  PicCollectionView.swift
//  WeiBoWithSB
//
//  Created by digitalforest on 2018/2/27.
//  Copyright © 2018年 liukun. All rights reserved.
//

import UIKit
import SDWebImage

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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //获取通知需要传递的参数
        let userInfo = [ShowPhotoBrowserIndexKey:indexPath,ShowPhotoBrowserUrlsKey:picURLs] as [String : Any]
        //发出通知
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: ShowPhotoBrowserNote), object: self, userInfo: userInfo)
    }
}

extension PicCollectionView:AnimatorPresentedDelegate{
    func startRect(indexPath: NSIndexPath) -> CGRect {
        //获取cell
        let cell = self.cellForItem(at: indexPath as IndexPath)!
        //获取cell的frame
        let startFrame = self.convert(cell.frame, to: UIApplication.shared.keyWindow)
        return startFrame
    }
    
    func endRect(indexPath: NSIndexPath) -> CGRect {
        //获取该位置的image对象
        let picURL = picURLs[indexPath.item]
        let image = SDWebImageManager.shared().imageCache?.imageFromDiskCache(forKey: picURL.absoluteString)
        //计算结束后的frame
        let w = UIScreen.main.bounds.size.width
        let h = w/image!.size.width * image!.size.height
        var y:CGFloat = 0
        if h > UIScreen.main.bounds.size.height {
            y = 0
        }
        else{
            y = (UIScreen.main.bounds.size.height - h)*0.5
        }
        return CGRect(x: 0, y: y, width: w, height: h)
    }
    
    func imageView(indexPath: NSIndexPath) -> UIImageView {
        //创建uiimageview对象
        let imageview = UIImageView()
        //获取该位置的image对象
        let picURL = picURLs[indexPath.item]
        let image = SDWebImageManager.shared().imageCache?.imageFromDiskCache(forKey: picURL.absoluteString)
        //设置imageview的属性
        imageview.image = image
        imageview.contentMode = UIViewContentMode.scaleAspectFit
        imageview.clipsToBounds = true
        
        return imageview
    }
    
    
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
