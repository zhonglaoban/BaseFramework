//
//  ViewController.swift
//  BaseFramework
//
//  Created by 钟凡 on 11/24/2016.
//  Copyright (c) 2016 钟凡. All rights reserved.
//

import UIKit
import BaseFramework
import CoreMotion

class ViewController: UIViewController {
    lazy var accelerometer: CMMotionManager = {
        let mgr = CMMotionManager()
        mgr.accelerometerUpdateInterval = 1/10.0
        return mgr
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let wave = WaveView(frame: CGRect(x: 0, y: 0, width: view.width, height: 100))
//        wave.direction = .up
//        view.addSubview(wave)
//        wave.start()
//        
//        accelerometer.startAccelerometerUpdates(to: OperationQueue.main) { (accelerometerData, err) in
//            let x = Float(accelerometerData?.acceleration.x ?? 0)
//            if x < 0.0 {
//                wave.startY += 1
//                wave.endY -= 1
//            }else {
//                wave.startY -= 1
//                wave.endY += 1
//            }
//        }
        // Do any additional setup after loading the view, typically from a nib.
        let sinView = SinView(frame: CGRect(x: 0, y: 0, width: view.width, height: 100))
        view.addSubview(sinView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    func test() {
    }
}

