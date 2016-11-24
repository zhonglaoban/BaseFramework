//
//  UITabBar+Custom.swift
//  testTabbar
//
//  Created by 钟凡 on 16/6/12.
//  Copyright © 2016年 钟凡. All rights reserved.
//

import UIKit
extension UITabBar {
    public func showBadgeOnItemIndex(_ index:Int) {
        for view in subviews {
            if view.tag == 888 + index {
                view.isHidden = false
                return
            }
        }
        let count = self.items?.count ?? 0
        let redBadge = UIView()
        let width = (self.bounds.width / CGFloat(count))
        redBadge.frame = CGRect(x: width * CGFloat(index + 1) - 20, y: 4, width: 10, height: 10)
        redBadge.layer.cornerRadius = 5
        redBadge.layer.masksToBounds = true
        redBadge.tag = 888 + index
        redBadge.backgroundColor = UIColor.red
        addSubview(redBadge)
    }
    public func hideBadgeOnItemIndex(_ index:Int) {
        for view in subviews {
            if view.tag == 888 + index {
                view.isHidden = true
            }
        }
    }
}
