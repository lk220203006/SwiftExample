//
//  PhotoBrowserController.swift
//  WeiBoWithSB
//
//  Created by digitalforest on 2018/4/17.
//  Copyright © 2018年 liukun. All rights reserved.
//

import UIKit
import SnapKit
import SVProgressHUD

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
    
    override func loadView() {
        super.loadView()
        view.frame.size.width += 20
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        //滚动到对应的图片
        collectionView.scrollToItem(at: indexPath as IndexPath, at: .left, animated: false)
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
            make.right.equalTo((-40))
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
        //获取当前正在显示的image
        let cell = collectionView.visibleCells.first as! PhotoBrowserViewCell
        guard let image = cell.imageView.image else {
            return
        }
        //将image对象保存相册
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(image:didFinishSavingWithError:contextInfo:)), nil)
    }
    @objc private func image(image:UIImage,didFinishSavingWithError error:NSError?,contextInfo:AnyObject){
        if error != nil {
            SVProgressHUD.showError(withStatus: "保存失败")
            SVProgressHUD.dismiss(withDelay: 1.5)
        }
        else{
            SVProgressHUD.showSuccess(withStatus: "保存成功")
            SVProgressHUD.dismiss(withDelay: 1.5)
        }
    }
}

extension PhotoBrowserController:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return picURLs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoBrowserCell, for: indexPath) as! PhotoBrowserViewCell
        cell.picURL = picURLs[indexPath.item]
        cell.delegate = self
        return cell
    }
}

extension PhotoBrowserController:PhotoBrowserViewCellDelegate{
    func imageViewClick() {
        closeBtnClick()
    }
}

//MARK:- 遵守AnimatorDismissDelegate
extension PhotoBrowserController:AnimatorDismissDelegate{
    func indexPathForDismissView() -> NSIndexPath {
        //获取当前正在显示的indexpath
        let cell = collectionView.visibleCells.first!
        return collectionView.indexPath(for: cell)! as NSIndexPath
    }
    
    func imageViewForDismissView() -> UIImageView {
        //创建uiimageview对象
        let imageView = UIImageView()
        //设置imageview的属性
        let cell = collectionView.visibleCells.first! as! PhotoBrowserViewCell
        imageView.frame = cell.imageView.frame
        imageView.image = cell.imageView.image
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }
    
    
}

class PhotoBrowserCollectionViewLayout:UICollectionViewFlowLayout{
    override func prepare() {
        super.prepare()
        
        itemSize = collectionView!.frame.size
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        scrollDirection = .horizontal
        collectionView?.isPagingEnabled = true
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.showsHorizontalScrollIndicator = false
    }
}
