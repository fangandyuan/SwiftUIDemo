//
//  ZWCarouselView.swift
//  SwiftUIDemo
//
//  Created by 章伟 on 16/12/22.
//  Copyright © 2016年 方圆. All rights reserved.
//

import UIKit

protocol ZWCarouselViewDelegate {
    //点击imageView执行的方法
    func clickImageView(image: UIImage, index: Int)
}

class ZWCarouselView: UIView, UIScrollViewDelegate {

    ///设置缓存图片的个数
    let imageViewMaxCount: Int = 2
    
    ///切换图片的时间
    var time: Double = 0
    
    ///定时器
    var timer: Timer?
    
    ///当前的下标
    var currIndex: Int = 0
    
    ///next下标
    var nextIndex: Int = 0
    
    ///图片数组
    var imageArray: [UIImage] = []
    
    ///代理
    var delegate: ZWCarouselViewDelegate?
    
    ///图片名称数组
    var images: [AnyObject]? {
        didSet{
            
            //保证有图片显示
            guard images!.count >= 1 else {
                print("给的图片不能少于1个")
                return
            }
            
            //通过传入的images生成image数组并保存起来
            for image in images! {
                
                if image.isKind(of: UIImage.self) == true {
                    
                    //当传入的为UIImage的时候,直接添加到数组里面
                    imageArray.append(image as! UIImage)
                    
                }else if image is String == true {
                    
                    //传入的为字符串
                    //如果字符串是以http开头的,说明是网络图片,那么需要下载,否则就在本地
                    if image.hasPrefix("http") == true {
                        //如果是网络图片，则先添加占位图片(占位图片肯定有)，下载完成后替换
                        let placeHolderImg = UIImage(named: "CarouselImg1")!
                        imageArray.append(placeHolderImg)
                    } else {
                        
                        //如果不是网络图片那么直接生成图片并添加
                        guard let newImage = UIImage(named: image as! String) else {
                            print("找不到对应的图片, 请检查")
                            return
                        }
                        imageArray.append(newImage)
                    }
                }
            }
            
            //默认显示第一张图片
            currIndex = 0
            currImageView.image = imageArray[currIndex]
            pageControl.numberOfPages = imageArray.count
            layoutSubviews()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //添加滚动界面
        buildImageScrollView()
        
        //添加pageControl
        addSubview(pageControl)
    }
    
    ///添加滚动界面
    private func buildImageScrollView(){
        
        //添加scrollView
        addSubview(imageScrollView)
        imageScrollView.delegate = self
        
        //向scrollView里面添加imageView
        imageScrollView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ZWCarouselView.imageViewClick(tap:))))
        
        //向scrollView添加currImageView以及otherImageView
        imageScrollView.addSubview(currImageView)
        imageScrollView.addSubview(otherImageView)
        
    }
    
    ///点击image
    func imageViewClick(tap: UITapGestureRecognizer) {
        
        //当实现了代理方法,就执行代理方法
        if let myDelegate = delegate {
            myDelegate.clickImageView(image: imageArray[currIndex] as UIImage, index: currIndex)
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setScrollViewContentSize()
    }
    
    ///设置设置scrollView的contentSize
    private func setScrollViewContentSize() {
        guard imageArray.count > 1 else {
            //当图片的个数为1的时候,不允许scroll滚动
            imageScrollView.contentSize = CGSize.zero
            imageScrollView.contentOffset = CGPoint.zero
            currImageView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
            
            //当只有一个图片的时候不显示pagecontrol
            pageControl.frame = CGRect(x: 100, y: 100, width: 200, height: 30)
            
            stopTimer()
            return
        }
        
        //当图片的个数大于1时
        //设置scrollView的frame
        imageScrollView.frame = bounds
        //设置scrollView的contentSize,设置5是因为如果只是设置3那么滚动到最后一张时检测不到继续向同一侧的滚动了所以设置大小为3+2=5
        imageScrollView.contentSize = CGSize(width: CGFloat(5) * frame.width, height: 0)
        imageScrollView.contentOffset = CGPoint(x: CGFloat(2) * frame.width, y: 0)
        //还原scrollview设置后重新摆放currImageView的位置
        currImageView.frame = CGRect(x: CGFloat(2) * frame.width, y: 0, width: frame.width, height: frame.height)
        
        //当有多张图片的时候显示pagecontrol
        pageControl.frame = CGRect(x: 100, y: 100, width: 200, height: 30)
        
        //开启定时器
        startTimer()
    }
    
    ///开启定时器
    func startTimer() {
        guard imageArray.count > 1 else {
            //当图片的个数为1的时候,不用开启定时器
            return
        }
        
        //当图片的个数大于1时
        //如果定时器已经开启,那么先关闭定时器
        if timer != nil {
            stopTimer()
        }
        
        //创建定时器,有一个block方法,但是还要适配10.0一下的版本,所以这里就不写了
        timer = Timer.scheduledTimer(timeInterval: time, target: self, selector: #selector(ZWCarouselView.nextPage), userInfo: nil, repeats: true)
    }
    
    ///关闭定时器
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    ///定时调用的方法
    func nextPage() {
        imageScrollView.setContentOffset(CGPoint(x: CGFloat(3) * frame.width, y: 0), animated: true)
    }
    
    
    // MARK: -UIScrollViewDelegate
    ///滑动scrollview
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //scrollview的contentsize为0时不执行操作
        guard !scrollView.contentSize.equalTo(CGSize.zero) else {
            return
        }
        
        let offsetX = scrollView.contentOffset.x
        
        //设置pageControl的值
        changeCurrentPageWithOffset(offsetX: offsetX)
        
        if offsetX > frame.width * 2 {
            //向左滚动
            nextIndex = (currIndex + 1) % imageArray.count
            otherImageView.image = imageArray[nextIndex]
            
            otherImageView.frame = CGRect(x: currImageView.frame.maxX, y: 0, width: frame.width, height: frame.height)
            if offsetX > CGFloat(3) * frame.width {
                //当滚动到nextIndex之后,还原设置
                changeToNext()
            }
            
        }else if offsetX < frame.width * 2 {
            //向右滚动
            nextIndex = (currIndex - 1)
            if nextIndex < 0 {
                nextIndex = imageArray.count - 1
            }
            otherImageView.image = imageArray[nextIndex]
            otherImageView.frame = CGRect(x: frame.width, y: 0, width: frame.width, height: frame.height)
            if offsetX < frame.width {
                //当滚动到nextIndex之后,还原设置
                changeToNext()
            }
        }
    }
    
    ///滚动过程中动态改变pagecontrol的值
    func changeCurrentPageWithOffset(offsetX: CGFloat) {
        guard offsetX >= frame.width * 1.5 else {
            //当offsetX < frame.width * 1.5时应该减1
            var index = currIndex - 1
            if index < 0 {
                index = imageArray.count - 1
            }
            pageControl.currentPage = index
            return
        }
        
        guard offsetX <= frame.width * 2.5 else {
            //当offsetX > frame.width * 2.5时应该加1
            pageControl.currentPage = (currIndex + 1) % imageArray.count
            return
        }
        
        //其他情况下均不变
        pageControl.currentPage = currIndex
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        //获取currimageView的偏移量在scrollview里面的位置
        let currPointInSelf = scrollView.convert(currImageView.frame.origin, to: self)
        if currPointInSelf.x >= -frame.width / 2 && currPointInSelf.x <= frame.width / 2 {
            scrollView.setContentOffset(CGPoint(x: frame.width * 2, y: 0), animated: true)
        }else {
            changeToNext()
        }
    }
    
    ///当scrollView停止滚动时还原设置
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        changeToNext()
    }
    
    ///开始拖拽的时候停止定时器
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        stopTimer()
    }
    
    ///停止拖拽的时候开启定时器
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        startTimer()
    }
    
    ///还原设置
    func changeToNext(){
        currImageView.image = otherImageView.image
        imageScrollView.contentOffset = CGPoint(x: frame.width * 2, y: 0)
        imageScrollView.layoutSubviews()
        currIndex = nextIndex
        pageControl.currentPage = currIndex
    }
    
    // MARK: -懒加载
    //imageScrollView
    private lazy var imageScrollView: UIScrollView = {
        let imageScrollView = UIScrollView()
        imageScrollView.bounces = false
        imageScrollView.showsHorizontalScrollIndicator = true
        imageScrollView.showsVerticalScrollIndicator = false
        imageScrollView.isPagingEnabled = true
        return imageScrollView
    }()
    
    //uiPageControl
    private lazy var pageControl: UIPageControl = {
       let pageControl = UIPageControl()
        pageControl.isUserInteractionEnabled = false
        pageControl.pageIndicatorTintColor = UIColor.red
        pageControl.currentPageIndicatorTintColor = UIColor.blue
        return pageControl
    }()
    
    //当前的imageView
    private lazy var currImageView: UIImageView = {
        let currImageView = UIImageView()
        return currImageView
    }()
    //滚动显示的imageView
    private lazy var otherImageView: UIImageView = {
        let otherImageView = UIImageView()
        return otherImageView
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
