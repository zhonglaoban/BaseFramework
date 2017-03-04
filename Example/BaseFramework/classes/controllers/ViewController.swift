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
    @IBOutlet weak var yellowBtn: UIButton! {
        didSet {
            yellowBtn.clipToCircle()
        }
    }
    @IBOutlet weak var orangeBtn: UIButton! {
        didSet {
            orangeBtn.clipToCircle()
        }
    }
    @IBOutlet weak var brownBtn: UIButton! {
        didSet {
            brownBtn.clipToCircle()
        }
    }
    
    lazy var accelerometer: CMMotionManager = {
        let mgr = CMMotionManager()
        mgr.accelerometerUpdateInterval = 1/10.0
        return mgr
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let titles = ["1","2","3"]
        let alert = WXActionSheet(titles: titles, cancelTitle: "取消") { (btn) in
            print(btn.tag)
            ShowMessageTool.shareInstance().showTextMessage(btn.title(for: .normal)!)
        }
        alert.show()
    }
    func test() {
    }
}

