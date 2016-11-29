//
//  ShowMessageTool.swift
//  Relax
//
//  Created by 钟凡 on 16/9/1.
//  Copyright © 2016年 钟凡. All rights reserved.
//

import UIKit

public class ShowMessageTool: NSObject {
    
    static fileprivate let tool = ShowMessageTool()
    static func shareInstance() -> ShowMessageTool {
        return tool
    }
    
    lazy var textView:TextView = {
        
        return TextView()
    }()
    func showTextMessage(_ text:String) {
        if textView.superview != nil || text == "" {
            return
        }
        if text.characters.count > 0 {
            let width = UIScreen.main.bounds.size.width
            let height = UIScreen.main.bounds.size.height
            let size = text.boundingRect(with: CGSize(width: width - 32, height: CGFloat.greatestFiniteMagnitude), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 20)], context: nil).size
            textView.frame = CGRect(x: (width - size.width) * 0.5 , y: height - 64 - size.height, width: size.width, height: size.height)
            let window = UIApplication.shared.keyWindow
            window?.addSubview(textView)
            textView.showText(text)
        }
    }
}
class TextView:UIView, CAAnimationDelegate {
    lazy var textLab:UILabel = {
        let lab = UILabel()
        lab.backgroundColor = UIColor.clear
        lab.textAlignment = NSTextAlignment.center
        lab.font = UIFont.systemFont(ofSize: 15)
        lab.textColor = UIColor.white
        lab.numberOfLines = 0
        self.addSubview(lab)
        return lab
    }()
    lazy var opacityAnimation: CAKeyframeAnimation = {
        let animation = CAKeyframeAnimation(keyPath: "opacity")
        animation.delegate = self
        animation.values = [0.5, 1.0, 1.0, 1.0, 1.0, 0.8, 0.6, 0.4, 0.2, 0.0]
        animation.duration = 2.0
        animation.repeatCount = 1
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        return animation
    }()
    
    func showText(_ text:String) {
        textLab.text = text
        textLab.frame = self.bounds
        
        layer.add(opacityAnimation, forKey: "opacityAnimation")
    }
    func animationDidStart(_ anim: CAAnimation) {
        self.isHidden = false
    }
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        self.isHidden = true
        self.removeFromSuperview()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(r: 1, g: 1, b: 1, a: 0.8)
        isUserInteractionEnabled = false
        layer.cornerRadius = 2
        layer.masksToBounds = true
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
