//
//  SwitchBtn.swift
//  MyRill
//
//  Created by 钟凡 on 16/3/4.
//
//

import UIKit

public class SwitchBtn: UIButton {
    override public func awakeFromNib() {
        super.awakeFromNib()
        let image = UIImage(from: UIColor(r: 28, g: 167, b: 221, a: 1))
        
        titleLabel?.font = UIFont.systemFont(ofSize: 17)
        titleLabel?.textAlignment = NSTextAlignment.center
        setTitleColor(UIColor(r: 28, g: 167, b: 221, a: 1), for: UIControlState.selected)
        setTitleColor(UIColor(r: 157, g: 167, b: 181, a: 1), for: UIControlState())
        setImage(image, for: UIControlState.selected)
        setImage(nil, for: UIControlState())
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        let image = UIImage(from: UIColor(r: 28, g: 167, b: 221, a: 1))
        
        titleLabel?.font = UIFont.systemFont(ofSize: 17)
        titleLabel?.textAlignment = NSTextAlignment.center
        setTitleColor(UIColor(r: 28, g: 167, b: 221, a: 1), for: UIControlState.selected)
        setTitleColor(UIColor(r: 157, g: 167, b: 181, a: 1), for: UIControlState())
        setImage(image, for: UIControlState.selected)
        setImage(nil, for: UIControlState())
    }
    override public func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        return CGRect(x: 0, y: contentRect.height - 1.5, width: self.width, height: 1.5)
    }
    override public func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        return CGRect(x: 0, y: 0, width: contentRect.width, height: 30)
    }
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
}
