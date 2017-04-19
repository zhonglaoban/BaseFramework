//
//  Array+Extension.swift
//  Pods
//
//  Created by 钟凡 on 2017/4/19.
//
//


extension Array {
    public func indexOf(index:Int) -> Element {
        return self[self.index(self.startIndex, offsetBy: index)]
    }
}
