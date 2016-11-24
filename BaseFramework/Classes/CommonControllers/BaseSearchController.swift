//
//  BaseSearchController.swift
//  MyRill
//
//  Created by 钟凡 on 16/4/25.
//
//

import UIKit

public class BaseSearchController: UISearchController {

    override public func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.tintColor = StyleManager.tintColor
    }
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
