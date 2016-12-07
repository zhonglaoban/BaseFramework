//
//  ViewController.swift
//  BaseFramework
//
//  Created by 钟凡 on 11/24/2016.
//  Copyright (c) 2016 钟凡. All rights reserved.
//

import UIKit
import BaseFramework

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let waveView = SinView(frame: view.frame)
        waveView.backgroundColor = UIColor.white
        
        waveView.start()
        view.addSubview(waveView)
        let v = Bundle(for: PopView.self).loadNibNamed("PopView", owner: self, options: nil)?.first as! PopView
        v.backgroundColor = UIColor.blue
//        view.addSubview(v)
        let btn = BublleBtn(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        btn.backgroundColor = UIColor.blue
        view.addSubview(btn)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }

}

