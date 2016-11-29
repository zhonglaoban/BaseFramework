//
//  ImageExtention.swift
//  Relax
//
//  Created by 钟凡 on 2016/11/10.
//  Copyright © 2016年 钟凡. All rights reserved.
//

import Foundation

extension UIImage {
    public func circleImage() -> UIImage? {
        let w = self.size.width
        let h = self.size.height
        let rect = CGRect(x: 0, y: 0, width: w, height: h)
        UIGraphicsBeginImageContextWithOptions(self.size, false, UIScreen.main.scale)
        let ctx = UIGraphicsGetCurrentContext()
        ctx?.addEllipse(in: rect)
        ctx?.clip()
        draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}
