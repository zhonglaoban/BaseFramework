//
//  ShowImageController.swift
//  SwiftWeibo
//
//  Created by 钟凡 on 15/12/24.
//  Copyright © 2015年 zhongfan. All rights reserved.
//

import UIKit

class ShowImageController: UIViewController, UIScrollViewDelegate {
    
    lazy var alertTitles:[String] = {
       return [String]()
    }()
    /// 图像的缩放比例
    var scale: CGFloat = 1

    /// 滚动视图
    lazy var scrollView: UIScrollView = {
        let s = UIScrollView(frame: self.view.bounds)
        s.backgroundColor = UIColor.black
        // 支持缩放
        // 1. 设置代理
        s.delegate = self
        // 2. 最小大缩放比例
        s.minimumZoomScale = 1
        s.maximumZoomScale = 2.0
        
        return s
    }()
    
    /// 图像视图
    lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    //图片
    var image: UIImage? {
        didSet {
            _ = self.calaImageSize(image!)
        }
    }
    /// 显示图像的 URL
    var imageURL: URL? {
        didSet {
            // 下载图像
//            imageView.sd_setImage(with: imageURL) { (image, error, _, _) -> Void in
//                if error != nil {
//                        return
//                    }
//                _ = self.calaImageSize(image!)
//            }
        }
    }
    
    /// 计算图像大小
    func calaImageSize(_ image: UIImage) -> CGRect{
        // 重置 scrollView 的属性
        let size = scaleImageSize(image)
        scrollView.contentSize = size
        // 设置图像
        imageView.image = image
        // 设置图像大小
        imageView.size = size
        
        // 判断长短图
        if size.height > view.bounds.height {
            // 长图－置顶－设置滚动区域
            imageView.origin = CGPoint.zero
        } else {
            imageView.center = CGPoint(x: scrollView.center.x, y: scrollView.center.y)
        }
        return imageView.frame
    }
    /// 按照屏幕宽度计算缩放后的图像尺寸
    func scaleImageSize(_ image: UIImage) -> CGSize {
        let scale = image.size.width / view.bounds.size.width
        let h = image.size.height / scale
        
        return CGSize(width: view.bounds.size.width, height: h)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 添加滚动视图
        view.addSubview(scrollView)
        // 将图像视图添加到滚动视图中
        scrollView.addSubview(imageView)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ShowImageController.close))
        self.view.addGestureRecognizer(tap)
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(ShowImageController.alertWithTitle(_:)))
        self.view.addGestureRecognizer(longPress)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.setStatusBarHidden(true, with: UIStatusBarAnimation.fade)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.setStatusBarHidden(false, with: UIStatusBarAnimation.none)
    }
    //关闭图片查看器
    func close() {
        dismiss(animated: true, completion: nil)
    }
    func alertWithTitle(_ longpress:UILongPressGestureRecognizer) {
        if alertTitles.count <= 0 {
            return
        }
        if longpress.state == UIGestureRecognizerState.began {
            let alert = SNActionSheet(title: nil, buttonTitles: alertTitles, hightlightIndex: -1, hightlightColor: nil) { (action, buttonIndex, title) in
                if title == ConfigManager.alertTitle_saveImage {
                    self.saveToLocal(self.image)
                }
                if title == ConfigManager.alertTitle_send {
                    
                }
                if title == ConfigManager.alertTitle_collect {
                    
                }
            }
            alert?.show()
        }
    }
    // MARK:- 保存图片到本地
    func saveToLocal(_ image:UIImage?) {
        if image != nil {
            UIImageWriteToSavedPhotosAlbum(image!, self, #selector(ShowImageController.image(_:didFinishSavingWithError:contextInfo:)), nil)
        }
    }
    func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo:UnsafeRawPointer){
        if error == nil {
            ShowMessageTool.shareInstance().showTextMessage("保存成功，到相册中查看")
        }else {
            ShowMessageTool.shareInstance().showTextMessage("保存失败，请重试")
        }
    }
    // MARK: - ScrollView 的代理
    /// 返回要缩放的视图
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        var rect = imageView.frame
        rect.origin.x = 0
        rect.origin.y = 0
        if rect.width < scrollView.width {
            rect.origin.x = (scrollView.width - rect.width) / 2.0
        }
        if rect.height < scrollView.height {
            rect.origin.y = (scrollView.height - rect.height) / 2.0
        }
        imageView.frame = rect
    }
}
