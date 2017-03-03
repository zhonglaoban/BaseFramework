//
//  CacheTool.swift
//  BaseFramework
//
//  Created by 钟凡 on 2017/3/2.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit

class CacheTool: NSObject {
    static let fileManager = FileManager.default
    
    static func fileSize(atPath:String) -> Float {
        if fileManager.fileExists(atPath: atPath) {
            do {
                let dict = try fileManager.attributesOfItem(atPath: atPath)
                return dict[FileAttributeKey.systemFreeSize] as! Float
            }catch let error {
                print(error.localizedDescription)
            }
        }
        return 0
    }
    static func folderSize(atPath:String) -> Float {
        var folderSize:Float = 0
        if fileManager.fileExists(atPath: atPath) {
            guard let childerFiles = fileManager.subpaths(atPath: atPath) else {
                return fileSize(atPath:atPath)
            }
            for fileName in childerFiles {
                let absolutePath = atPath.appending("/\(fileName)")
                folderSize += fileSize(atPath:absolutePath)
            }
            return folderSize
        }
        return 0
    }
    static func removeFile(atPath:String) {
        if fileManager.fileExists(atPath: atPath) {
            do {
                try fileManager.removeItem(atPath: atPath)
            }catch let error {
                print(error.localizedDescription)
            }
        }
    }
    static func removeFolder(atPath:String) {
        if fileManager.fileExists(atPath: atPath) {
            guard let childerFiles = fileManager.subpaths(atPath: atPath) else {
                removeFolder(atPath: atPath)
                return
            }
            for fileName in childerFiles {
                let absolutePath = atPath.appending("/\(fileName)")
                removeFolder(atPath: absolutePath)
            }
        }
    }
}
