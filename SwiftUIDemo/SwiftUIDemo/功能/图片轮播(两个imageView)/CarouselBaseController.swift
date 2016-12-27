//
//  CarouselBaseController.swift
//  SwiftUIDemo
//
//  Created by 章伟 on 16/12/22.
//  Copyright © 2016年 方圆. All rights reserved.
//

import UIKit

class CarouselBaseController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        //添加轮播器
        addCarouselView()
        
    }
    
    ///添加轮播器0, 100, 375, 180
    func addCarouselView(){
        let carouselView = ZWCarouselView(frame: CGRect(x: 20, y: 100, width: 375, height: 180))
        carouselView.imageNames = ["CarouselImg1", "CarouselImg2", "CarouselImg3"]
        carouselView.time = 1
        view.addSubview(carouselView)
        carouselView.delegate = self
    }

}

extension CarouselBaseController: ZWCarouselViewDelegate {
    func clickImageView(image: UIImage, index: Int) {
        print("\(index)????")
    }
}
