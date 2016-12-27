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
        let request = URLRequest(url: URL(string: "http://www.baidu.com")!)
        webView.loadRequest(request)
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
        
        //当请求里面包含baidu时,允许请求,否则不允许
        let requestUrl = request.url
        guard requestUrl?.absoluteString.contains("baidu") == true else {
            return false
        }
        
        return true
    }
    
    public func webViewDidStartLoad(_ webView: UIWebView){
        print("webViewDidStartLoad")
    }
    
    public func webViewDidFinishLoad(_ webView: UIWebView){
        print("webViewDidFinishLoad")
    }
    
    public func webView(_ webView: UIWebView, didFailLoadWithError error: Error){
        print("didFailLoadWithError")
    }
}
