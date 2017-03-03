//
//  ShakeCollectionView.swift
//  Relax
//
//  Created by 钟凡 on 16/9/7.
//  Copyright © 2016年 钟凡. All rights reserved.
//

import UIKit
protocol ShakeCollectionViewDelegate: NSObjectProtocol {
    func cellPositionChanged(_ colleciontView: ShakeCollectionView, position: CGPoint, cell: UICollectionViewCell)
    func collectionView(_ collectionView: ShakeCollectionView, moveItem sourceIndexPath: IndexPath, toIndexPath destinationIndexPath: IndexPath)
    func collectionView(_ collectionView: ShakeCollectionView, deleteAtIndexPath: IndexPath)
    func collectionView(_ collectionView: ShakeCollectionView, insertAtIndexPath: IndexPath)
}
open class ShakeCollectionView: UICollectionView {
    var shouldUpdate:Bool = false
    weak var shakeDelegate:ShakeCollectionViewDelegate?
    var sourceIndexPath:IndexPath?
    var destIndexPath:IndexPath?
    
    func begin(_ location: CGPoint) {
//        shakeCel()
        sourceIndexPath = indexPathForItem(at: location)
    }
    fileprivate func shakeCel() {
        for cell in visibleCells {
            let animation = CAKeyframeAnimation()
            animation.keyPath = "transform.rotation"
            animation.values = [0.1,-0.1,0.1]
            animation.repeatCount = MAXFLOAT
            animation.duration = 0.2
            if cell.layer.animation(forKey: "shake") == nil {
                cell.layer.add(animation, forKey: "shake")
            }
        }
    }
    func update(_ position: CGPoint) {
        if (position.x.truncatingRemainder(dividingBy: width)) >= width - 10 {
            setContentOffset(CGPoint(x: (position.x / width) * width, y: 0), animated: true)
        }
        destIndexPath = indexPathForItem(at: position)
        
        if sourceIndexPath == nil && destIndexPath != nil{
            shakeDelegate?.collectionView(self, insertAtIndexPath: destIndexPath!)
            sourceIndexPath = destIndexPath
        }
        if sourceIndexPath != nil && destIndexPath == nil {
            shakeDelegate?.collectionView(self, deleteAtIndexPath: sourceIndexPath!)
            sourceIndexPath = nil
        }
        if sourceIndexPath != nil && destIndexPath != nil && sourceIndexPath != destIndexPath {
            shakeDelegate?.collectionView(self, moveItem: sourceIndexPath!, toIndexPath: destIndexPath!)
            sourceIndexPath = destIndexPath
        }
    }
    func end() {
        sourceIndexPath = nil
        destIndexPath = nil
    }
}
