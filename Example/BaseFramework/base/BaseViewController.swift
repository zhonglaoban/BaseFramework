//
//  BaseViewController.swift
//  MyRill
//
//  Created by 钟凡 on 16/3/23.
//
//

import UIKit
import AVFoundation

open class BaseViewController: UIViewController {

    override open func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        initViews()
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.endEditing(true)
    }
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadData() {
        
    }
    func initViews() {
        
    }
}
