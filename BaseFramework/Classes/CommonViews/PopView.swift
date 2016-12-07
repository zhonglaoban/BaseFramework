//
//  PopView.swift
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
public class PopView: UIView {
    var isClick:Bool = false
    var lastFrame:CGRect = CGRect.zero
    public let screenSize = UIScreen.main.bounds.size
    var clickBlock:((UIBarButtonItem)->())?
    var type:menuType = .left
    
    public override func awakeFromNib() {
        super.awakeFromNib()
    }
    @IBAction func itemClick(_ sender: UIBarButtonItem) {
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
        if lastFrame.contains(movedPoint) {
            isClick = false
        }
        if (movedPoint.x - width/2 < 0 ||
            movedPoint.x + width/2 > screenSize.width ||
            movedPoint.y - height/2 < 0 ||
            movedPoint.y + height/2 > screenSize.height)
        {
            return
        }
        center = movedPoint
    }
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        lastFrame = frame
        adjustPosition()
        if isClick {
            showMenu()
        }
    }
    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    func adjustPosition() {
        
    }
    func showMenu() {
        
    }
}
