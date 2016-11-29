//
//  BaseViewController.swift
//  MyRill
//
//  Created by 钟凡 on 16/3/23.
//
//

import UIKit
import AVFoundation

open class BaseViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    override open func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
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
    
    func selectImage(){
        let alertTitles = ["拍照","从相册选取"]
        let alert = SNActionSheet(title: nil, buttonTitles: alertTitles, hightlightIndex: -1, hightlightColor: nil) { (action, buttonIndex, title) in
            if title == "拍照" {
                let authorizationStatus = AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo)
                switch(authorizationStatus) {
                case .notDetermined:
                    break
                case .authorized:
                    break
                case .denied:
                    let alertView = UIAlertView(title: "您拒绝了使用相机的授权", message: "请在设备的'设置-隐私-相机'中允许应用访问相机。", delegate: self, cancelButtonTitle: "确定")
                    alertView.show()
                case .restricted:
                    let alertView = UIAlertView(title: "相机设备无法访问", message: "请在设备的'设置-隐私-相机'中允许应用访问相机。", delegate: self, cancelButtonTitle: "确定")
                    alertView.show()
                }
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.allowsEditing = true
                imagePicker.sourceType = UIImagePickerControllerSourceType.camera
                
                self.present(imagePicker, animated: true, completion: nil)
            }
            if title == "从相册选取" {
                let authStatus = AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo)
                if authStatus == AVAuthorizationStatus.restricted || authStatus == AVAuthorizationStatus.denied {
                    let alertView = UIAlertView(title: "相册无法访问", message: "请在设备的'设置-隐私-照片'中允许应用访问。", delegate: self, cancelButtonTitle: "确定")
                    alertView.show()
                    return
                }
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.allowsEditing = true
                imagePicker.sourceType = UIImagePickerControllerSourceType.savedPhotosAlbum
                
                self.present(imagePicker, animated: true, completion: nil)
            }
        }
        alert?.show()
    }
    func loadData() {
        
    }
    // MARK: -  imagePickerController delegate
    open func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
    }
}
