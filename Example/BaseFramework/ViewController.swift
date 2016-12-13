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
        let image = UIImage(named: "btn")!
        let btn = PopButton(frame:CGRect(x: 0, y: 100, width: 50, height: 50))
        btn.clickBlock = { btn in
            let shareVC = UIActivityViewController(activityItems: [image], applicationActivities: nil)
//            let excludeActivities = [UIActivityType.airDrop, .copyToPasteboard, .message, .mail]
            self.present(shareVC, animated: true, completion: nil)
        }
        view.addSubview(btn)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }

}

