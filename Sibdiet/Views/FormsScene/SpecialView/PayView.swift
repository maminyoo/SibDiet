//
//  PayView.swift
//  Sibdiet
//
//  Created by Apple on 12/1/19.
//  Copyright © 2019 maminyoo. All rights reserved.
//

import UIKit
import WebKit

protocol PayViewDelegate{
    func closeWebView()
}

class PayView: UIView, WKNavigationDelegate, PayViewDelegate{
    
    var delegatePayView:PayViewDelegate?
    func delegate(_ delegate: PayViewDelegate){
        delegatePayView = delegate
    }
    
    func initView(){
        setWebContainer()
    }
    
    //MARK: WEB CONTAINER
    var webContainer = UIView()
    func setWebContainer(){
        webContainer.frame(bounds)
        setTopWebView()
        setProgressBar()
        setBackWeb()
        setUrlAddress()
        setWebView()
        addSubview(webContainer)
    }
    
    //MARK: WEB HEADER
    var topWebView = UIView()
    func setTopWebView(){
        topWebView.frame(0, hasSafeArea ? 32 : (hasSafeArea ? 44 : 20), width, 62)
        topWebView.shadow(CGSize(0,1), gray12, 4, 1)
        topWebView.backgroundColor(gray00)
        webContainer.addSubview(topWebView)
    }
    
    //MARK: URL
    var urlAddress = UILabel()
    func setUrlAddress(){
        urlAddress.frame(70, 5, width-65 , 52)
        urlAddress.font(GillSans, 20)
        urlAddress.textColor(skyBlue01)
        topWebView.addSubview(urlAddress)
    }
    
    //MARK: PROGRESS BAR
    var progressBar = UIView()
    func setProgressBar(){
        progressBar.frame(0, 59, width, 3)
        progressBar.cornerRadius(1)
        progressBar.backgroundColor(green)
        progressBar.clipsToBounds(true)
        let gradient = CAGradientLayer()
        gradient.frame(progressBar.bounds)
        gradient.colors([skyBlue01, skyBlue02])
        gradient.startPoint(0, 0)
        gradient.endPoint(0, 1)
        progressBar.addSublayer(gradient)
        topWebView.addSubview(progressBar)
    }
    
    //MARK: BACK WEB
    var backWeb = BarButton()
    func setBackWeb(){
        backWeb.frame(5, 5, 60, 52)
        backWeb.image01(CLOSE_IMG)
        backWeb.text(SpecialInfoViewValues().backWebTitle)
        backWeb.onTap(self, #selector(closeWebView))
        backWeb.initView()
        topWebView.addSubview(backWeb)
    }
    
    //MARK: WEB VIEW
    var websView: WKWebView!
    func setWebView(){
        let preferences = WKPreferences()
        preferences.javaScriptEnabled = true
        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences
        let frame = CGRect(0,
                           topWebView.height/2+topWebView.y,
                           width,
                           webContainer.height - topWebView.height)
        websView = WKWebView(frame: frame, configuration: configuration)
        websView.navigationDelegate = self
        websView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        webContainer.addSubview(websView)
    }
    
    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?,
                               context: UnsafeMutableRawPointer?) {
        let  progress = CGFloat(websView.estimatedProgress)
        progressBar.animate(width: self.width*progress, 0.3, curveEaseOut05)
        progressBar.animate(x: progressBar.width/2, 0.3, curveEaseOut05)
        progressBar.animate(height: progressBar.width == width ? 0 : 3 , 0.3, 0.6, 0.3)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        paymentConnection.paymentResult()
    }
    
    func webView(_ webView: WKWebView,
                 didStartProvisionalNavigation navigation: WKNavigation!) {
        if let text = webView.url?.absoluteString{
            urlAddress.text = text
        }
    }
    
    //MARK: SHOW WEB
    func showWebView(){
        websView.evaluateJavaScript("document.documentElement.remove()")
        websView.load(paymentConnection.payUrl)
    }
    
    //MARK: CLOSE WEB
    @objc func closeWebView(){
        delegatePayView?.closeWebView()
    }
}
