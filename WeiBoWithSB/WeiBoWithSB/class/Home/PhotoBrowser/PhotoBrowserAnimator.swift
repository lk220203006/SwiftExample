//
//  PhotoBrowserAnimator.swift
//  WeiBoWithSB
//
//  Created by digitalforest on 2018/4/17.
//  Copyright © 2018年 liukun. All rights reserved.
//

import UIKit

class PhotoBrowserAnimator: NSObject {
    var isPresented:Bool = false
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
        //取出弹出的view
        let presentedView = transitionContext.view(forKey: .to)!
        //将presentedview添加到containerview中
        transitionContext.containerView.addSubview(presentedView)
        //执行动画
        presentedView.alpha = 0.0
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            presentedView.alpha = 1.0
        }) { (_)->Void in
            transitionContext.completeTransition(true)
        }
    }
    
    func animationForDismissView(using transitionContext: UIViewControllerContextTransitioning){
        //取出要消失的view
        let dismissView = transitionContext.view(forKey: .from)!
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            dismissView.alpha = 0.0
        }) { (_) in
            dismissView.removeFromSuperview()
            transitionContext.completeTransition(true)
        }
    }
}
