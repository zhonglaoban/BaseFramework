//
//  ProgressView.swift
//  Relax
//
//  Created by 钟凡 on 16/9/23.
//  Copyright © 2016年 钟凡. All rights reserved.
//

import UIKit

class ProgressView: UIView {
    var pauseLayer: CAShapeLayer?
    var progressLayer: CAShapeLayer?
    var endAg:CGFloat = 0
    var startAg:CGFloat = 0
    var progress:CGFloat = 0.0 {
        didSet {
            if progress >= 1 {
                complete = true
                isHidden = true
            }
            setNeedsDisplay()
        }
    }
    var pause:Bool = false {
        didSet {
            setNeedsDisplay()
        }
    }
    var complete:Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        let ctx = UIGraphicsGetCurrentContext()
        let xCenter = rect.size.width * 0.5
        let yCenter = rect.size.height * 0.5
        let radius = min(xCenter, yCenter)
        let lineW = max(xCenter, yCenter)
        endAg = progress * CGFloat(M_PI * 2)
        let startAg = -CGFloat(M_PI) * 0.5
        // 背景遮罩
        UIColor(r: 240, g: 240, b: 240, a: 0.8).set()
        ctx?.setLineWidth(lineW)
        ctx?.addArc(center: CGPoint(x: xCenter, y: yCenter), radius: radius + lineW * 0.5, startAngle: startAg, endAngle: endAg + startAg, clockwise: true);
        ctx?.strokePath();
        
        if pause {
            ctx?.setLineWidth(2);
            ctx?.move(to: CGPoint(x: xCenter - 5, y: yCenter - 10))
            ctx?.addLine(to: CGPoint(x: xCenter - 5, y: yCenter + 10))
            ctx?.move(to: CGPoint(x: xCenter + 5, y: yCenter - 10))
            ctx?.addLine(to: CGPoint(x: xCenter + 5, y: yCenter + 10))
            ctx?.strokePath();
        }else {
            // 进程圆
            ctx?.setLineWidth(1);
            ctx?.move(to: CGPoint(x: xCenter, y: yCenter));
            ctx?.addArc(center: CGPoint(x: xCenter, y: yCenter), radius: radius + lineW * 0.5, startAngle: startAg, endAngle: endAg + startAg, clockwise: true);
            ctx?.closePath();
            ctx?.fillPath();
        }
    }
}
