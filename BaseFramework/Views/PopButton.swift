//
//  PopButton.swift
//  Pods
//
//  Created by 钟凡 on 2016/12/7.
//
//

import UIKit

enum menuType {
    case left
    case right
}
public class PopButton: UIButton {
    var isClick:Bool = false
    var isMenuShow:Bool = false
    var lastFrame:CGRect = CGRect.zero
    public var screenSize = UIScreen.main.bounds.size
    public var clickBlock:((UIButton)->())?
    var type:menuType = .left
    
    public var items:[UIButton] = [UIButton]()

    public override func awakeFromNib() {
        super.awakeFromNib()
    }
    public init() {
        let frame = CGRect(x: 0, y: 100, width: 50, height: 50)
        super.init(frame:frame)
        initViews()
    }
    override public init(frame: CGRect) {
        super.init(frame: frame)
        initViews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public func initViews() {
        let backImage = UIImage(named: "btn", in: Bundle(for:type(of:self)), compatibleWith: nil)
        setBackgroundImage(backImage, for: .normal)
        if items.count == 0 {
            let btn1 = UIButton()
            let image = UIImage(named: "btn_share", in: Bundle(for:type(of:self)), compatibleWith: nil)
            btn1.addTarget(self, action: #selector(itemClick(_:)), for: .touchUpInside)
            btn1.setBackgroundImage(image, for: .normal)
            btn1.tag = 0
            
            let btn2 = UIButton()
            btn2.addTarget(self, action: #selector(itemClick(_:)), for: .touchUpInside)
            btn2.setBackgroundImage(image, for: .normal)
            btn2.tag = 1
            items = [btn1, btn2]
        }
    }
    
    func itemClick(_ sender: UIButton) {
        print(sender.tag)
        if clickBlock != nil {
            clickBlock!(sender)
        }
    }
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        isClick = true
    }
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let movedPoint = touch!.location(in: superview)
        if !lastFrame.contains(movedPoint) {
            isClick = false
            center = movedPoint
            adjustItemPositon()
        }
    }
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        lastFrame = frame
        if isClick {
            if isMenuShow {
                hideMenu()
            }else {
                showMenu()
            }
        }
        adjustPosition()
    }
    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    func adjustItemPositon() {
        for (i,item) in items.enumerated() {
            var offset = CGFloat(i + 1) * width
            if center.x > screenSize.width * 0.5 {
                offset = -offset
            }
            item.origin = CGPoint(x: left + offset, y: top + width * 0.25)
            item.alpha = 1
            item.isUserInteractionEnabled = true
        }
    }
    func adjustPosition() {
        var endPoint = center
        
        if center.x <= screenSize.width * 0.5 {
            endPoint.x = size.width * 0.5 + 1
        }else {
            endPoint.x = screenSize.width - size.width * 0.5 - 1
        }
        UIView.animate(withDuration: 0.1, animations: { 
            self.center = endPoint
            self.adjustItemPositon()
        })
    }
    func showMenu() {
        isMenuShow = true
        for (_,item) in items.enumerated() {
            item.isUserInteractionEnabled = false
            item.alpha = 0
            let itemWidth = width * 0.5
            let itemHeight = height * 0.5
            let itemTop = top + itemHeight * 0.5
            
            item.frame = CGRect(x: left, y: itemTop, width: itemWidth, height: itemHeight)
            
            if !superview!.subviews.contains(item) {
                superview?.addSubview(item)
            }
        }
    }
    func hideMenu() {
        isMenuShow = false
        for item in items {
            item.isUserInteractionEnabled = false
            item.alpha = 0
            if superview!.subviews.contains(item) {
                item.removeFromSuperview()
            }
            UIView.animate(withDuration: 0.1, animations: {
                item.origin = CGPoint.zero
                item.isUserInteractionEnabled = false
                item.alpha = 0
            },completion: { isFinished in
                item.isUserInteractionEnabled = true
            })
        }
    }
    
}
