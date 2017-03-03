//
//  BackBtn.swift
//  MyRill
//
//  Created by 钟凡 on 16/2/22.
//
//

import UIKit

open class BackBtn: UIButton {

    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 10, width: 80, height: 24))
        setTitle("返回", for: UIControlState())
        setTitleColor(UIColor(r: 28, g: 167, b: 221, a: 1), for: UIControlState())
        setImage(UIImage(named: "back_btn_white"), for: UIControlState())
        titleLabel?.font = UIFont.systemFont(ofSize: 17)
    }
    override open func awakeFromNib() {
        super.awakeFromNib()
        setTitle("返回", for: UIControlState())
        setTitleColor(UIColor(r: 28, g: 167, b: 221, a: 1), for: UIControlState())
        setImage(UIImage(named: ""), for: UIControlState())
        titleLabel?.font = UIFont.systemFont(ofSize: 17)
    }
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override open func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        return CGRect(x: 11, y: 0, width: 70, height: 24)
    }
    override open func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        return CGRect(x: -5, y: 2, width: 12, height: 20);
    }
}
