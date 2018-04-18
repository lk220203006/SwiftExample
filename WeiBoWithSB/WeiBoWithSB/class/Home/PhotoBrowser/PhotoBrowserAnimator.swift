//
//  PhotoBrowserAnimator.swift
//  WeiBoWithSB
//
//  Created by digitalforest on 2018/4/17.
//  Copyright © 2018年 liukun. All rights reserved.
//

import UIKit

protocol  AnimatorPresentedDelegate:NSObjectProtocol{
    func startRect(indexPath:NSIndexPath) -> CGRect
    func endRect(indexPath:NSIndexPath) -> CGRect
    func imageView(indexPath:NSIndexPath) -> UIImageView
}

protocol AnimatorDismissDelegate:NSObjectProtocol {
    func indexPathForDismissView() -> NSIndexPath
    func imageViewForDismissView() -> UIImageView
}

class PhotoBrowserAnimator: NSObject {
    var isPresented:Bool = false
    
    var presentedDelegate:AnimatorPresentedDelegate?
    var dismissDelegate:AnimatorDismissDelegate?
    var indexPath:NSIndexPath?
}

extension PhotoBrowserAnimator:UIViewControllerTransitioningDelegate{
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresented = true
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresented = false
        return self
    }
}

extension PhotoBrowserAnimator:UIViewControllerAnimatedTransitioning{
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        isPresented ? animationForPresentedView(using: transitionContext):animationForDismissView(using: transitionContext)
    }
    
    func animationForPresentedView(using transitionContext: UIViewControllerContextTransitioning){
        //nil值校验
        guard let presentedDelegate = presentedDelegate, let indexPath = indexPath else {
            return
        }
        //取出弹出的view
        let presentedView = transitionContext.view(forKey: .to)!
        //将presentedview添加到containerview中
        transitionContext.containerView.addSubview(presentedView)
        //获取执行动画的imageView
        let startRect = presentedDelegate.startRect(indexPath: indexPath)
        let imageview = presentedDelegate.imageView(indexPath: indexPath)
        transitionContext.containerView.addSubview(imageview)
        imageview.frame = startRect
        //执行动画
        presentedView.alpha = 0.0
        transitionContext.containerView.backgroundColor = UIColor.black
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {()->Void in
            imageview.frame = presentedDelegate.endRect(indexPath: indexPath)
        }) { (_)->Void in
            imageview.removeFromSuperview()
            presentedView.alpha = 1.0
            transitionContext.containerView.backgroundColor = UIColor.clear
            transitionContext.completeTransition(true)
        }
    }
    
    func animationForDismissView(using transitionContext: UIViewControllerContextTransitioning){
        //nil值校验
        guard let dismissDelegate = dismissDelegate,let presentedDelegate = presentedDelegate else {
            return
        }
        //取出要消失的view
        let dismissView = transitionContext.view(forKey: .from)!
        dismissView.removeFromSuperview()
        //获取执行动画的imageview
        let imageview = dismissDelegate.imageViewForDismissView()
        transitionContext.containerView.addSubview(imageview)
        let indexPath = dismissDelegate.indexPathForDismissView()
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            imageview.frame = presentedDelegate.startRect(indexPath: indexPath)
        }) { (_) in
            
            transitionContext.completeTransition(true)
        }
    }
}
