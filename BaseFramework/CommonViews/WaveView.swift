//
//  WaveView.swift
//
//
//  Created by 钟凡 on 16/8/16.
//  Copyright © 2016年 钟凡. All rights reserved.
//

import UIKit

/**
 *  函数参考 y=Asin(ωx+φ)+k
 *  - A——振幅，当物体作轨迹符合正弦曲线的直线往复运动时，其值为行程的1/2。
 *  - (ωx+φ)——相位，反映变量y所处的状态。
 *  - φ——初相，x=0时的相位；反映在坐标系上则为图像的左右移动。
 *  - k——偏距，反映在坐标系上则为图像的上移或下移。
 *  - ω——角速度， 控制正弦周期(单位角度内震动的次数)。
 *  - 因为波浪一直在动 不考虑 φ，x轴方向的偏移
*/
open class WaveView: UIView {
    fileprivate var timer:Timer!
    fileprivate var deltaX:CGFloat = 0
    fileprivate var deltaY:CGFloat = 0
    fileprivate var step:Int = 0
    fileprivate var angle:CGFloat = 0
    /// 波浪起始位置 相当于 k 初始值为30
    public var startY:CGFloat = 20
    public var endY:CGFloat = 20
    /// 波浪振幅 相当于 A 初始值为20
    public var amplitude:CGFloat = 20
    public var direction:WaveDirection = .down
    
    public var colors:[UIColor] = [UIColor(r: 0, g: 222, b: 255, a: 0.2), UIColor(r: 157, g: 192, b: 249, a: 0.2), UIColor(r: 0, g: 168, b: 255, a: 0.2)]
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override open func draw(_ rect: CGRect) {
        let ctx = UIGraphicsGetCurrentContext()
        step += 2
        for color in colors {
            let i = colors.index(of: color)
            angle = CGFloat(step + i! * 50) * CGFloat(M_PI/180)
            deltaY = sin(angle) * amplitude
            deltaX = cos(angle) * amplitude
            
            let path = UIBezierPath()
            path.move(to: CGPoint(x: 0, y: startY + deltaY))
            path.addCurve(to: CGPoint(x: width, y: endY + deltaX), controlPoint1: CGPoint(x: width * 0.5, y: startY + deltaY + amplitude), controlPoint2: CGPoint(x: width * 0.5, y: endY + deltaX + amplitude))
            if direction == .down {
                path.addLine(to: CGPoint(x: width, y: height))
                path.addLine(to: CGPoint(x: 0, y: height))
            }
            if direction == .up {
                path.addLine(to: CGPoint(x: width, y: 0))
                path.addLine(to: CGPoint(x: 0, y: 0))
            }
            
            color.setStroke()
            color.setFill()
            path.close()
            ctx?.addPath(path.cgPath)
            ctx?.fillPath()
        }
    }
    public func start()
    {
        if direction == .down {
            startY = height - startY
            amplitude = -amplitude
        }
        timer?.invalidate()
        timer  = Timer.scheduledTimer(timeInterval: 1.0/30, target: self, selector: #selector(refresh), userInfo: nil, repeats: true)
        RunLoop.current.add(timer, forMode: RunLoopMode.commonModes)
    }
    func refresh()
    {
        self.setNeedsDisplay()
    }
}
