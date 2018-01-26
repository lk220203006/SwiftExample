//
//  PopoverAnimator.swift
//  WeiBoWithSB
//
//  Created by digitalforest on 2018/1/25.
//  Copyright © 2018年 liukun. All rights reserved.
//

import UIKit

class PopoverAnimator: NSObject {
    //MARK:- 对外提供的属性
    var isPresented:Bool = false
    var presentedFrame: CGRect = CGRect.zero
    
    var callBack:((_ presented:Bool) -> ())?
    
    init(callBack:@escaping (_ presented:Bool) -> ()) {
        self.callBack = callBack
    }
}

// MARK:- 自定义转场代理的方法
extension PopoverAnimator:UIViewControllerTransitioningDelegate{
    //改变弹出view的尺寸
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let presentation = XMGPresentationController(presentedViewController: presented, presenting: presenting)
        presentation.presentedFrame = presentedFrame
        return presentation
    }
    //自定义弹出的动画
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresented = true
        callBack!(isPresented)
        return self
    }
    //自定义消失的动画
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresented = false
        callBack!(isPresented)
        return self
    }
}

//弹出和消失动画代理的方法
extension PopoverAnimator:UIViewControllerAnimatedTransitioning{
    //动画执行的时间
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval{
        return 0.5
    }
    
    //获取转场的上下文：可以通过转场上下文获取弹出的view和消失的view
    //UITransitionContextFromViewKey, and UITransitionContextToViewKey
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning){
        isPresented ? animationForPresentedView(using: transitionContext):animationForDismissView(using: transitionContext)
    }
    
    //自定义弹出动画
    private func animationForPresentedView(using transitionContext: UIViewControllerContextTransitioning){
        //获取弹出的view
        let presentedView = transitionContext.view(forKey: .to)!
        //将弹出的view添加到containerview中
        transitionContext.containerView.addSubview(presentedView)
        //执行动画
        presentedView.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
        presentedView.transform = CGAffineTransform(scaleX: 1.0,y: 0.0)
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            presentedView.transform = CGAffineTransform.identity
        }) { (isFinished) in
            transitionContext.completeTransition(true)
        }
    }
    //自定义消失动画
    private func animationForDismissView(using transitionContext: UIViewControllerContextTransitioning){
        let dismissView = transitionContext.view(forKey: .from)
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            dismissView?.transform = CGAffineTransform(scaleX: 1.0, y: 0.001)
        }) { (_) in
            dismissView?.removeFromSuperview()
            transitionContext.completeTransition(true)
        }
    }
}
