//
//  PicPickerCollectionView.swift
//  WeiBoWithSB
//
//  Created by digitalforest on 2018/3/30.
//  Copyright © 2018年 liukun. All rights reserved.
//

import UIKit

private let picPickerCell = "picPickerCell"
private let edgeMargin:CGFloat = 15

class PicPickerCollectionView: UICollectionView {
    //MARK:- 定义属性
    var images:[UIImage] = [UIImage](){
        didSet{
            reloadData()
        }
    }
    //MARK:- 系统回掉函数
    override func awakeFromNib() {
        super.awakeFromNib()
        //设置layout
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        let itemWH = (UIScreen.main.bounds.size.width-4*edgeMargin)/3.0
        layout.itemSize = CGSize(width: itemWH, height: itemWH)
        layout.minimumInteritemSpacing = edgeMargin
        layout.minimumLineSpacing = edgeMargin
        
        //设置collectionview的属性
        register(UINib(nibName: "PicPickerViewCell", bundle: nil), forCellWithReuseIdentifier: picPickerCell)
        dataSource = self
        
        //设置内边距
        contentInset = UIEdgeInsetsMake(edgeMargin, edgeMargin, 0, edgeMargin)
    }

}

extension PicPickerCollectionView:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count + 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //获取cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: picPickerCell, for: indexPath) as! PicPickerViewCell
        //给cell设置数据
        cell.image = indexPath.item <= images.count-1 ? images[indexPath.item]:nil
        return cell
    }
}

