//
//  ComposeViewController.swift
//  WeiBoWithSB
//
//  Created by digitalforest on 2018/3/28.
//  Copyright © 2018年 liukun. All rights reserved.
//

import UIKit
import SVProgressHUD

@objc
class ComposeViewController: UIViewController {
    // MARK:- 控件属性
    @IBOutlet weak var textView: ComposeTextView!
    @IBOutlet weak var picPickerView: PicPickerCollectionView!
    @IBOutlet weak var picPickerBtn: UIButton!
    
    // MARK:- 懒加载属性
    lazy var titleView:ComposeTitleView = ComposeTitleView()
    private lazy var images:[UIImage] = [UIImage]()
    private lazy var emoticonVC:EmoticonController = EmoticonController {[weak self] (emoticon) in
        self?.textView.insertEmoticon(emoticon: emoticon)
        self?.textViewDidChange(self!.textView)
    }

    @IBOutlet weak var toolBar: UIToolbar!
    
    @IBOutlet weak var toolBarBottomCons: NSLayoutConstraint!
    @IBOutlet weak var picPickerViewHCons: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //设置导航栏
        setNavgationBar()
        setupNotifications()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        textView.becomeFirstResponder()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBAction func picPickerBtnClick(_ sender: UIButton) {
        textView.resignFirstResponder()
        picPickerViewHCons.constant = UIScreen.main.bounds.size.height * 0.65
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    @IBAction func emoticonBtnClick(_ sender: UIButton) {
        //退出键盘
        textView.resignFirstResponder()
        //切换键盘
        textView.inputView = textView.inputView != nil ? nil:emoticonVC.view
        //弹出键盘
        textView.becomeFirstResponder()
    }
    
}
// MARK:- 设置UI界面
extension ComposeViewController{
    private func setNavgationBar(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: .plain, target: self, action: #selector(closeItemClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发送", style: .plain, target: self, action: #selector(sendItemClick))
        navigationItem.rightBarButtonItem?.isEnabled = false
        titleView.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        titleView.layoutIfNeeded()
        navigationItem.titleView = titleView
    }
    
    private func setupNotifications(){
        //监听通知
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame(_:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(addPhotoClick), name: NSNotification.Name(rawValue: PicPickerAddPhotoNote), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(removePhotoClick(_:)), name: NSNotification.Name(rawValue: PicPickerRemovePhotoNote), object: nil)
    }
}

// MARK:- 事件监听
extension ComposeViewController{
    @objc private func closeItemClick(){
        dismiss(animated: true, completion: nil)
    }
    @objc private func sendItemClick(){
        //键盘退出
        textView.resignFirstResponder()
        //获取发送微博的微博正文
        let statusText = textView.getEmoticonString()
        //定义回掉的闭包
        let finishedCallback = {(isSuccess:Bool)->() in
            if !isSuccess{
                SVProgressHUD.showError(withStatus: "发送微博失败")
                return
            }
            else{
                SVProgressHUD.showSuccess(withStatus: "发送微博成功")
                self.dismiss(animated: true, completion: nil)
            }
        }
        //获取用户选中的图片
        if let image = images.first{
            NetworkTools.shareInstance.sendStatus(statusText: statusText, image: image,isSuccess:finishedCallback)
        }
        else{
            //调用接口发送微博
            NetworkTools.shareInstance.sendStatus(statusText: statusText,isSuccess:finishedCallback)
            }
    }
    @objc private func keyboardWillChangeFrame(_ note:NSNotification){
        //获取动画执行的时间
        let duration = note.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval
        //获取键盘最终y值
        let endframe = (note.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let y = endframe.origin.y
        //计算工具栏距离底部的间距
        let margin = UIScreen.main.bounds.size.height - y
        toolBarBottomCons.constant = margin
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
    }
}
//MARK:- 添加照片和删除照片的事件
extension ComposeViewController{
    @objc private func addPhotoClick(){
        if !UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            return
        }
        let ipc = UIImagePickerController()
        ipc.sourceType = .photoLibrary
        ipc.delegate = self
        present(ipc, animated: true, completion: nil)
    }
    
    @objc private func removePhotoClick(_ note:NSNotification){
        guard let image = note.object as? UIImage else {
            return
        }
        guard let index = images.index(of: image) else{
            return
        }
        images.remove(at: index)
        picPickerView.images = images
    }
}

extension ComposeViewController:UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
        self.textView.placeHolderLabel.isHidden = textView.hasText
        navigationItem.rightBarButtonItem?.isEnabled = textView.hasText
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.textView.resignFirstResponder()
    }
}

extension ComposeViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print(info)
        //获取选中的
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        images.append(image)
        picPickerView.images =  images
        //退出
        picker .dismiss(animated: true, completion: nil)
    }
}
