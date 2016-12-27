//
//  BaseViewController.swift
//  SwiftUIDemo
//
//  Created by 章伟 on 16/12/21.
//  Copyright © 2016年 方圆. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //基本设置
        setUpBasic()
        
        
    }
    
    ///基本设置
    func setUpBasic() {
        view.backgroundColor = UIColor.white
        
        //添加标题,点击标题能弹出控制器
        let titleBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        titleBtn.setTitle("省份设置", for: UIControlState.normal)
        titleBtn.setTitleColor(UIColor.gray, for: UIControlState.normal)
        titleBtn.addTarget(self, action: #selector(BaseViewController.clickBtn), for: UIControlEvents.touchUpInside)
        navigationItem.titleView = titleBtn
        
    }
    
    ///点击按钮时触发
    func clickBtn(){
        let popoverVc = PopoverViewController()
        //设置转场代理
        popoverVc.transitioningDelegate = popoverAnimator
        //设置弹出的样式为自定义
        popoverVc.modalPresentationStyle = UIModalPresentationStyle.custom
        present(popoverVc, animated: true, completion: nil)
    }
    
    
    // MARK: -懒加载
    //一定要定义一个属性来保存自定义转场对象, 否则会报错
    private lazy var popoverAnimator: PopoverAnimator = {
        let popoverAnimator = PopoverAnimator()
        popoverAnimator.presentFrame = CGRect(x: 100, y: 56, width: 200, height: 350)
        return popoverAnimator
    }()
    
}
