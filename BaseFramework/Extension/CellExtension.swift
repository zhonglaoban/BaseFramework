//
//  CellExtension.swift
//  MyRill
//
//  Created by 钟凡 on 16/8/12.
//
//

import UIKit

open class ExtensionCell: UITableViewCell {
    
    lazy var redBadge: UILabel = {
        let red = UILabel()
        red.textColor = UIColor.white
        red.textAlignment = NSTextAlignment.center
        red.font = UIFont.systemFont(ofSize: 14)
        red.layer.cornerRadius = 9
        red.layer.masksToBounds = true
        red.backgroundColor = UIColor.red
        return red
    }()
    lazy var separatorLine: CALayer = {
        let line = CALayer()
        line.backgroundColor = UIColor(r: 218, g: 224, b: 231, a: 1).cgColor
        return line
    }()
    
    open func show(model:Any) {
        
    }
    public func showaBadge(_ title:String) {
        if subviews.contains(redBadge) {
            return
        }
        redBadge.frame = CGRect(x: UIScreen.main.bounds.width - 70, y: height * 0.5 - 8, width: 40, height: 18)
        addSubview(redBadge)
    }
    public func hideaBadge() {
        if subviews.contains(redBadge) {
            redBadge.removeFromSuperview()
        }
    }
    public func showSeperateLine(lineFrame:CGRect) {
        separatorLine.frame = lineFrame
        if !layer.sublayers!.contains(separatorLine) {
            layer.addSublayer(separatorLine)
        }
    }
}
