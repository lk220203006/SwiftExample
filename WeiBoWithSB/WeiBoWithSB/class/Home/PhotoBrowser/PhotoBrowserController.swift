//
//  PhotoBrowserController.swift
//  WeiBoWithSB
//
//  Created by digitalforest on 2018/4/17.
//  Copyright © 2018年 liukun. All rights reserved.
//

import UIKit
import SnapKit

private let PhotoBrowserCell = "PhotoBrowserCell"

class PhotoBrowserController: UIViewController {
    //MARK:- 定义属性
    var indexPath:NSIndexPath
    var picURLs:[NSURL]
    
    //MARK:- 懒加载属性
    private lazy var collectionView:UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: PhotoBrowserCollectionViewLayout())
    private lazy var closeBtn:UIButton = UIButton(bgColor: UIColor.darkGray, fontSize: 14, title: "关 闭")
    private lazy var saveBtn:UIButton = UIButton(bgColor: UIColor.darkGray, fontSize: 14, title: "保 存")
    
    init(indexPath:NSIndexPath,picURLs:[NSURL]){
        self.indexPath = indexPath
        self.picURLs = picURLs
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension PhotoBrowserController{
    private func setupUI(){
        //添加子控件
        view.addSubview(collectionView)
        view.addSubview(closeBtn)
        view.addSubview(saveBtn)
        
        //设置frame
        collectionView.frame = view.bounds
        closeBtn.snp.makeConstraints { (make)->Void in
            make.left.equalTo(20)
            make.bottom.equalTo(-20)
            make.size.equalTo(CGSize(width: 90, height: 32))
        }
        saveBtn.snp.makeConstraints { (make)->Void in
            make.right.equalTo((-20))
            make.bottom.equalTo(-20)
            make.size.equalTo(CGSize(width: 90, height: 32))
        }
        //设置collectionview的属性
        collectionView.register(PhotoBrowserViewCell.self, forCellWithReuseIdentifier: PhotoBrowserCell)
        collectionView.dataSource = self
        
        //监听两个按钮的点击
        closeBtn.addTarget(self, action: #selector(closeBtnClick), for: .touchUpInside)
        saveBtn.addTarget(self, action: #selector(saveBtnClick), for: .touchUpInside)
    }
}
//MARK:- 事件监听函数
extension PhotoBrowserController{
    @objc private func closeBtnClick(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func saveBtnClick(){
    }
}

extension PhotoBrowserController:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return picURLs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoBrowserCell, for: indexPath) as! PhotoBrowserViewCell
        cell.picURL = picURLs[indexPath.item]
        return cell
    }
}

class PhotoBrowserCollectionViewLayout:UICollectionViewFlowLayout{
    override func prepare() {
        super.prepare()
        
        itemSize = UIScreen.main.bounds.size
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        scrollDirection = .horizontal
        collectionView?.isPagingEnabled = true
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.showsHorizontalScrollIndicator = false
    }
}
