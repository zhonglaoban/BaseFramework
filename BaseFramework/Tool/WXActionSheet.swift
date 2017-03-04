//
//  WXActionSheet.swift
//  Pods
//
//  Created by 钟凡 on 2017/3/4.
//
//

import UIKit

open class WXActionSheet: UIView {
    let btnHeight = 44
    let screenSize = UIScreen.main.bounds.size
    var btnClickBlock:((UIButton) -> ())?
    
    public init(titles:[String], cancelTitle:String, didSelectedBlock:@escaping ((_ button:UIButton) -> ())) {
        super.init(frame:CGRect(origin: CGPoint.zero, size: screenSize))
        backgroundColor = UIColor(r: 46, g: 49, b: 50, a: 0)
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismiss))
        addGestureRecognizer(tap)
        
        buildViews(titles: titles, cancelTitle: cancelTitle, didSelectedBlock: didSelectedBlock)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    func buildViews(titles:[String], cancelTitle:String, didSelectedBlock:@escaping ((_ button:UIButton) -> ())) {
        btnClickBlock = {btn in
            didSelectedBlock(btn)
        }
        
        let height = (titles.count + 1) * btnHeight + 8
        let containerView = UIView(frame: CGRect(x: 0, y: Int(screenSize.height) - height, width: Int(screenSize.width), height: height))
        containerView.backgroundColor = UIColor(r: 240, g: 242, b: 246, a: 0.4)
        addSubview(containerView)
        
        for (i,title) in titles.enumerated() {
            let btn = UIButton(frame:CGRect(x: 0, y: btnHeight * i, width: Int(screenSize.width), height: btnHeight))
            btn.tag = i
            btn.backgroundColor = UIColor(white: 1, alpha: 0.8)
            btn.setBackgroundImage(UIImage(from: UIColor(r: 235, g: 235, b: 235, a: 0.8)), for: .highlighted)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
            btn.setTitleColor(UIColor(r: 74, g: 83, b: 94, a: 1), for: .normal)
            btn.setTitle(title, for: .normal)
            btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
            containerView.addSubview(btn)
        }
        let cancelBtn = UIButton(frame:CGRect(x: 0, y: height - btnHeight, width: Int(screenSize.width), height: btnHeight))
        cancelBtn.tag = -1
        cancelBtn.backgroundColor = UIColor.white
        cancelBtn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        cancelBtn.setTitleColor(UIColor(r: 74, g: 83, b: 94, a: 1), for: .normal)
        cancelBtn.setTitle(cancelTitle, for: .normal)
        cancelBtn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        containerView.addSubview(cancelBtn)
        
        for i in 1..<titles.count {
            let line = CALayer()
            line.backgroundColor = UIColor.lightGray.cgColor
            line.frame = CGRect(x: 0, y: CGFloat(btnHeight * i), width: screenSize.width, height: 0.5)
            containerView.layer.addSublayer(line)
        }
    }
    public func show() {
        let window = UIApplication.shared.keyWindow
        window?.addSubview(self)
        UIView.animate(withDuration: 0.3) { 
            self.backgroundColor = UIColor(r: 46, g: 49, b: 50, a: 0.4)
        }
    }
    func dismiss() {
        removeFromSuperview()
    }
    func btnClick(btn:UIButton) {
        if btnClickBlock != nil {
            btnClickBlock!(btn)
        }
    }
}
