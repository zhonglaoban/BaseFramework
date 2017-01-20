//
//  SinView.swift
//  Pods
//
//  Created by 钟凡 on 2016/12/6.
//
//

import UIKit
/**
 *  函数参考 y=Asin(ωx+φ)+k
 *  - A——振幅，当物体作轨迹符合正弦曲线的直线往复运动时，其值为行程的1/2。
 *  - (ωx+φ)——相位，反映变量y所处的状态。
 *  - φ——初相，x=0时的相位；反映在坐标系上则为图像的左右移动。
 *  - k——偏距，反映在坐标系上则为图像的上移或下移。
 *  - ω——角速度， 控制正弦周期(单位角度内震动的次数)。
 */
public enum WaveDirection {
    case up
    case down
}
open class SinView: UIView {
    fileprivate var timer:Timer!
    fileprivate var step:Int = 0
    public var startY:CGFloat = 20
    public var endY:CGFloat = 20
    public var amplitude:CGFloat = 20
    public var colors:[UIColor] = [UIColor(r: 0, g: 222, b: 255, a: 0.2), UIColor(r: 157, g: 192, b: 249, a: 0.2), UIColor(r: 0, g: 168, b: 255, a: 0.2)]
    lazy var layers: [CAShapeLayer] = {
        return [CAShapeLayer]()
    }()
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        initLayers()
        start()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func initLayers() {
        for color in colors {
            let shapeLayer = CAShapeLayer()
            shapeLayer.fillColor = color.cgColor
            layers.append(shapeLayer)
            self.layer.addSublayer(shapeLayer)
        }
    }
    public func start()
    {
        timer?.invalidate()
        timer  = Timer.scheduledTimer(timeInterval: 1.0/30, target: self, selector: #selector(refresh), userInfo: nil, repeats: true)
        RunLoop.current.add(timer, forMode: RunLoopMode.commonModes)
    }
    func refresh()
    {
        step += 2
        for (index,shapeLayer) in layers.enumerated() {
            let path = UIBezierPath()
            let angle = CGFloat(step + index * 50) * CGFloat(M_PI/180)
            let deltaY = sin(angle) * amplitude
            let deltaX = cos(angle) * amplitude
            path.move(to: CGPoint(x: 0, y: startY + deltaY))
            path.addCurve(to: CGPoint(x: width, y: endY + deltaX), controlPoint1: CGPoint(x: width * 0.5, y: startY + deltaY + amplitude), controlPoint2: CGPoint(x: width * 0.5, y: endY + deltaX + amplitude))
            path.addLine(to: CGPoint(x: width, y: 0))
            path.addLine(to: CGPoint(x: 0, y: 0))
            path.close()
            shapeLayer.path = path.cgPath
        }
    }
}
