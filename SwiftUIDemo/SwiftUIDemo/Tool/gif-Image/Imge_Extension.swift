//
//  Imge_Extension.swift
//  SwiftUIDemo
//
//  Created by 章伟 on 16/12/27.
//  Copyright © 2016年 方圆. All rights reserved.
//

import UIKit
import ImageIO

extension UIImage {
    
    ///根据gifImageName生成.gif图片
    class func gifImage(name: String) -> UIImage? {
        
        var imageName = name
        
        if imageName.hasSuffix(".gif") != true {
            //如果传进来的ImageName没有带.gif后缀,那么加上
            imageName = "\(imageName).gif"
        }
        
        
        //CF_RETURNS_RETAINED
        
        guard let imagePath = Bundle.main.path(forResource: imageName, ofType: nil) else {
            print("找不到对应的图片")
            return nil
        }
        
        guard let imageData = NSData(contentsOfFile: imagePath) else {
            print("获取路径图片数据失败,该图片不是gif图片")
            return UIImage(named: imageName)
        }
        
        //当图片存在时,创建.gif图片
        let imageSource = CGImageSourceCreateWithData(imageData, nil)
        let count = CGImageSourceGetCount(imageSource!)
        guard count > 1 else {
            //当图片帧<=1时,非gif图片
            print("不是gif图片")
            return UIImage(data: imageData as Data)
        }
        
        var images: [UIImage] = []
        var duration = 0.0
        for i in 0..<count {
            //获取每帧的图片的imageRef
            guard let imageRef = CGImageSourceCreateImageAtIndex(imageSource!, i, nil) else {
                continue
            }
            // 获取到 gif每帧时间间隔
            guard let properties = CGImageSourceCopyPropertiesAtIndex(imageSource!, i, nil) ,
                  let gifInfo = (properties as NSDictionary)[kCGImagePropertyGIFDictionary as String] as? NSDictionary,
                let frameDuration = (gifInfo[kCGImagePropertyGIFDelayTime as String] as? NSNumber) else
            {
                return UIImage(data: imageData as Data)
            }
            
            duration += frameDuration.doubleValue
            // 获取帧的img
            let image = UIImage(cgImage: imageRef , scale: UIScreen.main.scale , orientation: UIImageOrientation.up)
            // 添加到数组
            images.append(image)
        }
        
        return UIImage.animatedImage(with: images, duration: duration)
    }
    
}

