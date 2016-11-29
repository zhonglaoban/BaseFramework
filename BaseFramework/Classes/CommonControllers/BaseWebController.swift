//
//  BaseWebController.swift
//  Relax
//
//  Created by 钟凡 on 16/9/6.
//  Copyright © 2016年 钟凡. All rights reserved.
//

import UIKit
import WebKit

open class BaseWebController: UIViewController , WKNavigationDelegate, WKUIDelegate {
    var urlString:String!
    lazy var webView:WKWebView = {
        let config = WKWebViewConfiguration()
        // 适应手机屏幕
//        let jScript = "var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);"
//        let wkUScript = WKUserScript(source: jScript, injectionTime: WKUserScriptInjectionTime.AtDocumentEnd, forMainFrameOnly: true)
//        let wkUController = WKUserContentController()
//        wkUController.addUserScript(wkUScript)
//        config.userContentController = wkUController
        /** WebView的偏好设置*/
        config.preferences.minimumFontSize = 10
        config.preferences.javaScriptEnabled = true
        config.suppressesIncrementalRendering = true
        /** 默认是不能通过JS自动打开窗口的，必须通过用户交互才能打开 */
        config.preferences.javaScriptCanOpenWindowsAutomatically = true
        let w = WKWebView(frame: CGRect(x: 0, y: 20, width: self.view.width, height: self.view.height - 20), configuration: config)
        w.navigationDelegate = self
        w.uiDelegate = self
        w.addObserver(self, forKeyPath: "estimatedProgress", options: NSKeyValueObservingOptions.new, context: nil)
        return w
    }()
    lazy var progressView: UIProgressView = {
        let p = UIProgressView(frame: CGRect(x: 0, y: 20, width: self.view.width, height: 0))
        p.tintColor = StyleManager.tintColor
        p.trackTintColor = UIColor.clear
        return p
    }()
    lazy var bublleBtn: BublleBtn = {
        let b = BublleBtn(frame:CGRect(x: self.view.width - 60, y: 160, width: 60, height: 60))
        b.isHidden = false
        return b
    }()
    let tools = ["btn_back", "btn_home", "btn_share", "btn_refresh", "btn_quit"]
    lazy var toolbar: UIToolbar = {
        let t = UIToolbar(frame: CGRect(x: 0, y: self.view.height - 44, width: self.view.width, height: 44))
        let placeHolderItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        var items = [UIBarButtonItem]()
        for (i, imgName) in self.tools.enumerated() {
            let item = UIBarButtonItem(image: UIImage(named:imgName), style: UIBarButtonItemStyle.plain, target: self, action: #selector(BaseWebController.itemAction(_:)))
            item.tag = i
            items.append(item)
            if i < self.tools.count - 1 {
                items.append(placeHolderItem)
            }
        }
        t.items = items
        return t
    }()
    
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        automaticallyAdjustsScrollViewInsets = false
        buildUI()
        loadData()
    }
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.setStatusBarStyle(UIStatusBarStyle.default, animated: true)
        if title != nil {
//            MobClick.beginLogPageView(title!)
        }
    }
    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if title != nil {
//            MobClick.endLogPageView(title!)
        }
    }
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    deinit {

    }
    
    func loadData() {
        
    }
    func buildUI() {
        view.addSubview(webView)
        view.addSubview(progressView)
        view.addSubview(bublleBtn)
        view.addSubview(toolbar)
    }
    public func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let ac = UIAlertController(title: webView.title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        ac.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: { (aa) -> Void in
            completionHandler()
        }))
        self.present(ac, animated: true, completion: nil)
    }
    public func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
            completionHandler(true)
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: { (action) in
            completionHandler(false)
        }))
        present(alertController, animated: true, completion: nil)
    }
    public func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addTextField { (textFeild) in
            textFeild.text = defaultText
        }
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
            completionHandler(alertController.textFields?.first?.text ?? "")
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: { (action) in
            completionHandler(nil)
        }))
        present(alertController, animated: true, completion: nil)
    }
    override open func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            if (object! as AnyObject).isEqual(webView) {
                let progress = change![NSKeyValueChangeKey.newKey] as? Float
                if progress == 1 {
                    progressView.isHidden = true
                    progressView.setProgress(0, animated: false)
                }else {
                    progressView.isHidden = false
                    progressView.setProgress(progress ?? 0, animated: true)
                }
            }else {
                super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
            }
        }else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
    func itemAction(_ item: UIBarButtonItem) {
        switch item.tag {
        case 0:
            goback()
            break
        case 1:
            goHome()
            break
        case 2:
            share()
            break
        case 3:
            reloadPage()
            break
        case 4:
            closePage()
            break
        default:
            break
        }
    }
    func goback(){
        if webView.canGoBack {
            webView.goBack()
        }else {
            goHome()
        }
    }
    func share() {
        
    }
    func goHome() {
        _ = navigationController?.popViewController(animated: true)
    }
    func reloadPage(){
        webView.reload()
    }
    func closePage(){
        toolbar.isHidden = !toolbar.isHidden
        bublleBtn.isHidden = !bublleBtn.isHidden
    }
}
