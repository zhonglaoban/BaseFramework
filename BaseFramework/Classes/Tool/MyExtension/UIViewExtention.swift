//
//  UIView+Extention.swift
//  Relax
//
//  Created by 钟凡 on 16/9/27.
//  Copyright © 2016年 钟凡. All rights reserved.
//

import Foundation

extension UIView {

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
