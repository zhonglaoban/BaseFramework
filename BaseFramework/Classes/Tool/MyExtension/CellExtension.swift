//
//  CellExtension.swift
//  MyRill
//
//  Created by 钟凡 on 16/8/12.
//
//

import UIKit

extension UITableViewCell {
    
    public func showBadge(_ title:String) {
        for view in subviews {
            if view.tag == 888 {
                view.isHidden = false
                return
            }
        }
        let redBadge = UILabel()
        redBadge.text = title
        redBadge.textColor = UIColor.white
        redBadge.textAlignment = NSTextAlignment.center
        redBadge.font = UIFont.systemFont(ofSize: 14)
        redBadge.frame = CGRect(x: UIScreen.main.bounds.width - 70, y: height * 0.5 - 8, width: 40, height: 18)
        redBadge.layer.cornerRadius = 9
        redBadge.layer.masksToBounds = true
        redBadge.tag = 888
        redBadge.backgroundColor = UIColor.red
        addSubview(redBadge)
    }
    public func hideBadge() {
        for view in subviews {
            if view.tag == 888 {
                view.isHidden = true
            }
        }
    }
    public func showSeperateLine(lineFrame:CGRect) {
        let line = CALayer()
        line.backgroundColor = StyleManager.separatorColor?.cgColor
        line.frame = lineFrame
        if !layer.sublayers!.contains(line) {
            layer.addSublayer(line)
        }
    }
}
