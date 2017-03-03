//
//  BaseModel.swift
//  Relax
//
//  Created by 钟凡 on 2016/11/15.
//  Copyright © 2016年 钟凡. All rights reserved.
//

import UIKit

open class BaseModel: NSObject {
    public init(dict: [String: Any]) {
        // 实例化对象
        super.init()
        
        let propties = Mirror(reflecting: self)
        for child in propties.children {
            // 使用 KVC 设置数值
            if dict[child.0!] != nil {
                // 在 swift 中，如果在 构造函数中使用 KVC，需要先 super.init，确保对象被实例化
                setValue(dict[child.0!], forKeyPath: child.0!)
            }
        }
    }
    public override init() {
        super.init()
    }
}
