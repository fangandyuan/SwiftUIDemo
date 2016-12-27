//
//  TextViewController.swift
//  SwiftUIDemo
//
//  Created by 章伟 on 16/12/19.
//  Copyright © 2016年 方圆. All rights reserved.
//

import UIKit

class TextViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white

        //创建textview
        let textView = UITextView(frame: CGRect(x: 50, y: 100, width: 300, height: 400))
        
        //设置内容
//        textView.text = "恶魔小丑——萨科（Shaco）是美国Riot Games开发的竞技游戏《英雄联盟》中的一位英雄。定位为追杀（或单杀）DPS英雄，由其"+"操作难度被玩家誉为最难驾驭的英雄之一。"+"小丑是个打野英雄，所以点出buff效果就显得尤为重要，其次他也有很好的输出能力，特别是在前期，21点的攻击天赋能让小丑的伤害提升一个等级。[1]"+"萨科可以通过从敌人背后行刺而造成恐怖的伤害，萨科还可以创造出一个可以战斗的幻象，当幻象时间结束后会猛烈爆炸来使他的敌人狼狈不堪。他那把恶毒的"+"匕首同样涂满了恐怖的剧毒，给敌人带来痛苦，煎熬和死亡。为了完成他那近乎于变态的杀人乐章，他还会在战场上布置像精神病人一样疯狂的玩偶去"+"攻击周围的敌人。无论你要做什么，千万不要告诉他你已经迷失了目标。[2] "
        
        //设置字体
        textView.font = UIFont.systemFont(ofSize: 17)
        
        //设置字体颜色
//        textView.textColor = UIColor.red
        
        //设置背景颜色
        textView.backgroundColor = UIColor.red
        
        //设置文字的对其方式
        textView.textAlignment = NSTextAlignment.center
        
        //设置富文本(文本)
        let attrStr = NSMutableAttributedString(string: "恶魔小丑——萨科")
        //        let dict = [NSForegroundColorAttributeName: UIColor.red];
        //        attrStr.addAttributes(dict, range: NSMakeRange(0, 4))
        textView.attributedText = attrStr
        
        //设置选中的范围(设置没显示效果,一般用于手动获取选择的区域)
        textView.becomeFirstResponder()
        textView.selectedRange = NSMakeRange(0, 4)
        
        //自动检测特殊内容:phoneNumber;link;address;calendarEvent;shipmentTrackingNumber;flightNumber;lookupSuggestion;all(all会添加所有的,也包含以后版本添加的)
        textView.dataDetectorTypes = UIDataDetectorTypes.phoneNumber
        
        textView.autoresizingMask = UIViewAutoresizing.flexibleHeight //自适应高度
        
        //设置返回值类型
        textView.returnKeyType = UIReturnKeyType.go;
        
        //设置圆角
        textView.layer.cornerRadius = 20;
        
        //是否允许点击链接和附件
        textView.isSelectable = true
        
        //设置是否可以滚动
        textView.isScrollEnabled = true
        
        //获取内容整体高度
//        textView.contentSize.height
        
//        //自定义键盘,其中只有高度有用
//        let inputView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 300))
//        inputView.backgroundColor = UIColor.green
//        textView.inputView = inputView
//        
//        //自定义键盘辅助框,其中只有高度有用
//        textView.inputAccessoryView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 44))
        
        
//        //textview系统通知
//        //开始输入文本
//        NotificationCenter.default.addObserver(self, selector: #selector(TextViewController.textDidBeginEditing), name: NSNotification.Name.UITextViewTextDidBeginEditing, object: nil)
//        //结束输入文本
//        NotificationCenter.default.addObserver(self, selector: #selector(TextViewController.textDidBeginEditing), name: NSNotification.Name.UITextViewTextDidEndEditing, object: nil)
//        //正在输入
//        NotificationCenter.default.addObserver(self, selector: #selector(TextViewController.textDidBeginEditing), name: NSNotification.Name.UITextViewTextDidChange, object: nil)
        
        textView.delegate = self
        
        view.addSubview(textView)
    }

}

extension TextViewController: UITextViewDelegate {
    
    //textview是否可以编辑
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return true
    }
    
    //textview结束编辑之后,是否可以再次被编辑
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        return true
    }
    
    //文本视图开始编辑，这个时候我们可以处理一些事情
    func textViewDidBeginEditing(_ textView: UITextView) {
        print(textView.text)
    }
    
    //文本视图结束编辑
    func textViewDidEndEditing(_ textView: UITextView) {
        print(textView.text)
    }

    
    //文本视图内容改变时，触发本方法，能得到改变的坐标和改变的内容
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        //如果是回车符号，则textView释放第一响应值，返回false
        if (text ==  "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }

    //文本视图改变后触发本代理方法
    func textViewDidChange(_ textView: UITextView) {
        print(textView.text)
    }
    
    
    //文本视图 改变选择内容，触发本代理方法
    func textViewDidChangeSelection(_ textView: UITextView) {
        print(textView.text)
    }
    
    
    //链接在文本中显示。当链接被点击的时候，会触发本代理方法
    @available(iOS 10.0, *)
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        return true
    }
    
    //文本视图允许提供文本附件，文本附件点击时，会触发本代理方法
    @available(iOS 10.0, *)
    func textView(_ textView: UITextView, shouldInteractWith textAttachment: NSTextAttachment, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        return true
    }
    
    
    @available(iOS, introduced: 7.0, deprecated: 10.0, message: "Use textView:shouldInteractWithURL:inRange:forInteractionType: instead")
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
        return true
    }

    @available(iOS, introduced: 7.0, deprecated: 10.0, message: "Use textView:shouldInteractWithTextAttachment:inRange:forInteractionType: instead")
    func textView(_ textView: UITextView, shouldInteractWith textAttachment: NSTextAttachment, in characterRange: NSRange) -> Bool {
        return true
    }
    
    
    
    
//    func textDidBeginEditing()
//    {
//        print("开始输入文本...")
//    }
//    
//    func textDidEndEditing()
//    {
//        print("结束输入...")
//    }
//    
//    func textDidChange()
//    {
//        print("正在输入...")
//    }
}
