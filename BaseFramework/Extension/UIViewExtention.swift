//
//  UIView+Extention.swift
//  Relax
//
//  Created by 钟凡 on 16/9/27.
//  Copyright © 2016年 钟凡. All rights reserved.
//

import Foundation

extension UIView {
    public var origin:CGPoint {
        set(value) {
            frame.origin = value
        }
        get {
            return frame.origin
        }
    }
    public var size:CGSize {
        set(value) {
            frame.size = value
        }
        get {
            return frame.size
        }
    }
    
    public var left:CGFloat {
        set(value) {
            origin.x = value
        }
        get {
            return origin.x
        }
    }
    public var top:CGFloat {
        set(value) {
            origin.y = value
        }
        get {
            return origin.y
        }
    }
    public var width:CGFloat {
        set(value) {
            size.width = value
        }
        get {
            return size.width
        }
    }
    public var height:CGFloat {
        set(value) {
            size.height = value
        }
        get {
            return size.height
        }
    }
    
    public func clipToCircle() {
        layoutIfNeeded()
        clipsToBounds = true
        
        let maskLayer = CAShapeLayer()
        let xCenter = width * 0.5
        let yCenter = height * 0.5
        let center = CGPoint(x: xCenter, y: yCenter)
        let radius = max(xCenter, yCenter)
        let lineW = min(xCenter, yCenter)

        let circlePath = UIBezierPath(arcCenter: center, radius: radius + lineW * 0.5, startAngle: 0, endAngle: CGFloat(M_PI * 2), clockwise: true)
        maskLayer.lineWidth = lineW
        maskLayer.strokeColor = UIColor.white.cgColor
        maskLayer.fillColor = nil
        maskLayer.path = circlePath.cgPath
        
        layer.addSublayer(maskLayer)
    }
}
