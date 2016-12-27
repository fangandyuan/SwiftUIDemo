//
//  PopoverPresentationController.swift
//  SwiftUIDemo
//
//  Created by 章伟 on 16/12/21.
//  Copyright © 2016年 方圆. All rights reserved.
//

import UIKit

class PopoverPresentationController: UIPresentationController {
    
    /// 定义属性保存菜单的大小
    var presentFrame = CGRect.zero
    /**
     初始化方法, 用于创建负责转场动画的对象
     
     :param: presentedViewController  被展现的控制器
     :param: presentingViewController 发起的控制器, Xocde6是nil, Xcode7是野指针
     
     :returns: 负责转场动画的对象
     */
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
    }
    
    /**
     即将布局转场子视图时调用
     :param :presentedView 被弹出的view
     :param :containerView 容器的view
     */
    override func containerViewWillLayoutSubviews()
    {
        // 1.修改弹出视图的大小
        if presentFrame == CGRect.zero{
            
            presentedView?.frame = CGRect(x: 100, y: 56, width: 200, height: 200)
        }else
        {
            presentedView?.frame = presentFrame
        }
        
        // 2.在容器视图上添加一个蒙版, 插入到展现视图的下面
        containerView?.insertSubview(coverView, at: 0)
    }
    
    // MARK: - 懒加载
    private lazy var coverView: UIView = {
        // 1.创建view
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.0, alpha: 0.2)
        view.frame = UIScreen.main.bounds
        
        // 2.添加监听
        let tap = UITapGestureRecognizer(target: self, action: #selector(PopoverPresentationController.close))
        view.addGestureRecognizer(tap)
        return view
    }()
    
    func close(){
        // presentedViewController拿到当前弹出的控制器
        presentedViewController.dismiss(animated: true, completion: nil)
    }
}
