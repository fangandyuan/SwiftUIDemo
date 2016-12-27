//
//  WebViewController.swift
//  SwiftUIDemo
//
//  Created by 章伟 on 16/12/16.
//  Copyright © 2016年 方圆. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //创建简单的webview
        createWebView()
        
        //通过webview请求网页
        requestWebView()
        
    }
    
    ///创建简单的webview
    func createWebView(){
        view.addSubview(webView)
        webView.frame = view.bounds
        webView.delegate = self
    }
    
    ///通过webview请求网页
    func requestWebView(){
        //简单请求一个网页
//        let request = URLRequest(url: URL(string: "http://www.baidu.com")!)
        
        let request = URLRequest(url: Bundle.main.url(forResource: "index.html", withExtension: nil)!)
        webView.loadRequest(request)
        
    }
    
    ///待调度方法1
    func callFirst(){
        print("callFirst")
    }
    ///待调度方法2
    func callSecond(first :String, second: String){
        print("callSecond")
        //callSecondWithFirst:second:
    }
    ///待调度方法3
    func callThird(){
        print("callThird")
    }
    
    //MARK: -懒加载
    ///webview
    private lazy var webView: UIWebView = {
        let webView = UIWebView()
        return webView
    }()
}

extension WebViewController: UIWebViewDelegate{
    /**
     * 每当webView即将发送一个请求之前，都会调用这个方法
     * 返回YES：允许加载这个请求
     * 返回NO：禁止加载这个请求
     */
    public func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool{
        
//        //一.当请求里面包含baidu时,允许请求,否则不允许
//        let requestUrl = request.url
//        guard requestUrl?.absoluteString.contains("baidu") == true else {
//            return false
//        }
//        return true
        
        //二.通过html调用oc代码:zhangwei://openCamera
        //1.获取urlStr
        let urlStr = request.url!.absoluteString
        let headerStr = "zhangwei://"
        //判断请求的url是否以zhangwei://开头
        guard urlStr.hasPrefix(headerStr) == true else {
            //如果不是以zhangwei://开头也放过😜
            return true
        }
        
        //获取url的参数部分
        //获取zhangwei://的字符个数
        let offset = headerStr.distance(from: headerStr.startIndex, to: headerStr.endIndex)
        //剪切
        let methodNames = urlStr.substring(from: urlStr.index(urlStr.startIndex, offsetBy: offset))
        
        //对方法部分按照分隔符分割:&
        let methodArr = methodNames.components(separatedBy: "&")
        
        guard methodArr.count > 0 else {
            //当后面没有参数的时候默认调用callFirst方法
            self.callFirst()
            return true
        }
        
        for method in methodArr {
            //获取每个方法部分后对方法部分进行参数分隔
            //callSecond(first :String, second: String)+string1_string2
            let nameAndParamArr = method.components(separatedBy: "+")
            let methodName = nameAndParamArr.first!
            
            //通过方法名字依次调用方法
            let selector = NSSelectorFromString(methodName)
//            let selector = #selector(callSecond(first:second:))
            
            
            guard nameAndParamArr.count == 2 else {
                //当count个数不为2时,说明调用的方法没有参数
                self.perform(selector)
                continue
            }
            
            let paramArr = nameAndParamArr.last!.components(separatedBy: "_")
            
            //暂时支持三个以内的参数
            //一个参数
            guard paramArr.count != 1 else {
                self.perform(selector, with: paramArr.first! as String)
                continue
            }
            
            //二个参数
            guard paramArr.count != 2 else {
                self.perform(selector, with: paramArr.first! as String, with: paramArr.last! as String)
                continue
            }
            
        }
        return false
    }
    
    public func webViewDidStartLoad(_ webView: UIWebView){
        print("webViewDidStartLoad")
    }
    
    public func webViewDidFinishLoad(_ webView: UIWebView){
        //通过oc代码调用html页面,注意,必须等待加载完成后调用,否则将发生未知错误
        //同样可以获取html中的一些值,例如:document.title;
        webView.stringByEvaluatingJavaScript(from: "login1();")
        print("webViewDidFinishLoad")
    }
    
    public func webView(_ webView: UIWebView, didFailLoadWithError error: Error){
        print("didFailLoadWithError")
    }
}
