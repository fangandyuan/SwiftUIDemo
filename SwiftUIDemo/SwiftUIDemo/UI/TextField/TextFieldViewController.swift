//
//  TextFieldViewController.swift
//  SwiftUIDemo
//
//  Created by 章伟 on 16/12/21.
//  Copyright © 2016年 方圆. All rights reserved.
//

import UIKit

class TextFieldViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white

        let textField = UITextField(frame: CGRect(x: 50, y: 100, width: 300, height: 90))
//        textField.backgroundColor = UIColor.red
        
        //设置边框样式
        textField.borderStyle = UITextBorderStyle.bezel
        
//        //当文字超出文本框宽度时，自动调整文字大小,默认是省略
//        textField.adjustsFontSizeToFitWidth = true
        
        //最小可缩小的字号
        textField.minimumFontSize = 14
        
//        //水平方向上对其
//        textField.textAlignment = NSTextAlignment.center
//        
//        textField.contentVerticalAlignment = UIControlContentVerticalAlignment.top
        
        //设置背景图片
//        textField.background = UIImage(named: "")
        
        //设置清除按钮的显示模式
//        UITextFieldViewModeNever,  //从不显示
//        UITextFieldViewModeWhileEditing,  //当编辑的时候显示
//        UITextFieldViewModeUnlessEditing,     //当编辑结束的时候显示
//        UITextFieldViewModeAlways     //一直显示
        textField.clearButtonMode = UITextFieldViewMode.unlessEditing
        
        //设置键盘类型
//        Default：系统默认的虚拟键盘
//        ASCII Capable：显示英文字母的虚拟键盘
//        Numbers and Punctuation：显示数字和标点的虚拟键盘
//        URL：显示便于输入url网址的虚拟键盘
//        Number Pad：显示便于输入数字的虚拟键盘
//        Phone Pad：显示便于拨号呼叫的虚拟键盘
//        Name Phone Pad：显示便于聊天拨号的虚拟键盘
//        Email Address：显示便于输入Email的虚拟键盘
//        Decimal Pad：显示用于输入数字和小数点的虚拟键盘
//        Twitter：显示方便些Twitter的虚拟键盘
//        Web Search：显示便于在网页上书写的虚拟键盘
        textField.keyboardType = UIKeyboardType.default
        
        //自动获取/失去焦点
//        textField.becomeFirstResponder()
        textField.resignFirstResponder()
        
        view.addSubview(textField)
        
    }

}
