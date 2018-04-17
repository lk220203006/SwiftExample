//
//  EmoticonController.swift
//  09-表情键盘
//
//  Created by digitalforest on 2018/4/2.
//  Copyright © 2018年 liukun. All rights reserved.
//

import UIKit

private let EmotionCell = "EmotionCell"

class EmoticonController: UIViewController {
    //MARK:- 定义属性
    var emoticonCallBack: (_ emoticon:Emoticon) -> ()
    
    private lazy var collectionView:UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: EmotionCollectionViewLayout())
    private lazy var toolBar:UIToolbar = UIToolbar()
    private lazy var manager:EmoticonManager = EmoticonManager()

    //MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }
    
    //MARK:- 自定义构造函数
    init(emoticonCallBack:@escaping (_ emoticon:Emoticon) -> ()){
        self.emoticonCallBack = emoticonCallBack
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension EmoticonController{
    private func setupUI(){
        //添加子控件
        view.addSubview(collectionView)
        view.addSubview(toolBar)
        collectionView.backgroundColor = UIColor.white
        toolBar.backgroundColor = UIColor.green
        
        //设置子控件的frame
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        let views = ["toolBar":toolBar,"collectionView":collectionView]
        var cons = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[toolBar]-0-|", options: [], metrics: nil, views: views)
        cons += NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[collectionView]-0-[toolBar]-0-|", options: [.alignAllLeft,.alignAllRight], metrics: nil, views: views)
        view.addConstraints(cons)
        
        //准备collectionView
        prepareForCollectionView()
        //准备toolbar
        prepareForToolBar()
    }
    
    private func prepareForCollectionView(){
        //注册cell和设置数据源
        collectionView.register(EmoticonViewCell.self, forCellWithReuseIdentifier: EmotionCell)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func prepareForToolBar(){
        //定义titles
        let titles = ["最近","默认","emoji","浪小花"]
        //遍历标题 创建item
        var index = 0
        var tempItems = [UIBarButtonItem]()
        for title in titles {
            let item = UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(itemClick(_:)))
            item.tag = index
            index += 1
            tempItems.append(item)
            tempItems.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil))
        }
        tempItems.removeLast()
        toolBar.items = tempItems
        toolBar.tintColor = UIColor.orange
    }
    @objc private func itemClick(_ item:UIBarButtonItem){
        let tag = item.tag
        let indexPath = NSIndexPath(item: 0, section: tag)
        collectionView.scrollToItem(at: indexPath as IndexPath, at: .left, animated: true)
    }
}


extension EmoticonController:UICollectionViewDataSource,UICollectionViewDelegate{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return manager.packages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let package = manager.packages[section]
        return package.emoticons.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmotionCell, for: indexPath) as! EmoticonViewCell
        let package = manager.packages[indexPath.section]
        let emoticon = package.emoticons[indexPath.item]
        cell.emoticon = emoticon
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //取出点击的表情
        let package = manager.packages[indexPath.section]
        let emoticon = package.emoticons[indexPath.item]
        //将点击的表情插入最近分组中
        insertRecentlyEmoticon(emoticon: emoticon)
        //将表情回掉给外界控制器
        emoticonCallBack(emoticon)
    }
    
    private func insertRecentlyEmoticon(emoticon:Emoticon){
        //如果是空白表情或者删除按钮，不需要插入
        if emoticon.isRemove || emoticon.isEmpty {
            return
        }
        //删除一个表情
        if manager.packages.first!.emoticons.contains(emoticon) {
            let index = manager.packages.first?.emoticons.index(of: emoticon)
            manager.packages.first?.emoticons.remove(at: index!)
        }
        else{
            manager.packages.first?.emoticons.remove(at: 19)
        }
        //将emoticon插入最近分组中
        manager.packages.first?.emoticons.insert(emoticon, at: 0)
    }
}

class EmotionCollectionViewLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        //计算itemWH
        let itemWH = UIScreen.main.bounds.size.width/7
        itemSize = CGSize(width: itemWH, height: itemWH)
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        scrollDirection = .horizontal
        collectionView?.isPagingEnabled = true
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.showsHorizontalScrollIndicator = false
        let insetMargin = ((collectionView?.bounds.height)! - 3*itemWH)/2
        collectionView?.contentInset = UIEdgeInsetsMake(insetMargin, 0, insetMargin, 0)
    }
}
