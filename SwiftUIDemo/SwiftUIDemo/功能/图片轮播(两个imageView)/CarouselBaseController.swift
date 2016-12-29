//
//  CarouselBaseController.swift
//  SwiftUIDemo
//
//  Created by 章伟 on 16/12/22.
//  Copyright © 2016年 方圆. All rights reserved.
//

import UIKit

class CarouselBaseController: UIViewController {

    var carouselView: ZWCarouselView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        //添加轮播器
        addCarouselView()
        
    }
    
    ///添加轮播器0, 100, 375, 180
    func addCarouselView(){
        carouselView = ZWCarouselView(frame: CGRect(x: 20, y: 100, width: 375, height: 180))
        carouselView?.images = [
            UIImage.gifImage(name: "2.gif")!,  //本地gif使用gifImageNamed(name)函数创建
            "CarouselImg2" as AnyObject, //本地图片
            "http://pic39.nipic.com/20140226/18071023_162553457000_2.jpg" as AnyObject,  //网络图片
            UIImage(named: "CarouselImg3")!, //本地图片,传image不传图片名称
            "http://photo.l99.com/source/11/1330351552722_cxn26e.gif" as AnyObject, //网络gif图片
            
        ]
        carouselView?.time = 1
        view.addSubview(carouselView!)
        carouselView?.delegate = self
    }
    
    ///点击返回按钮
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        carouselView?.stopTimer()
        carouselView?.removeFromSuperview()
        carouselView = nil
        dismiss(animated: true, completion: nil)
    }
    
    ///释放控制器
    deinit {
        print("控制器释放")
    }

}

extension CarouselBaseController: ZWCarouselViewDelegate {
    func clickImageView(image: UIImage, index: Int) {
        print("\(index)????")
    }
}
