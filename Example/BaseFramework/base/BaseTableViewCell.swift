//
//  BaseTableViewCell.swift
//  Pods
//
//  Created by 钟凡 on 2017/2/22.
//
//

import UIKit

open class BaseTableViewCell: UITableViewCell {
    
    var baseModel:BaseModel?

    lazy var redBadge: UILabel = {
        let red = UILabel()
        red.textColor = UIColor.white
        red.textAlignment = NSTextAlignment.center
        red.font = UIFont.systemFont(ofSize: 14)
        red.layer.cornerRadius = 9
        red.layer.masksToBounds = true
        red.backgroundColor = UIColor.red
        return red
    }()
    lazy var separatorLine: CALayer = {
        let line = CALayer()
        line.backgroundColor = StyleManager.separatorColor?.cgColor
        return line
    }()

    override open func awakeFromNib() {
        super.awakeFromNib()
    }
    override open func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    open func showSeperatorLine(lineFrame:CGRect) {
        separatorLine.frame = lineFrame
        if !layer.sublayers!.contains(separatorLine) {
            layer.addSublayer(separatorLine)
        }
    }
    open func cellHeight(model:BaseModel) -> CGFloat {
        self.baseModel = model
        layoutIfNeeded()
        let height = contentView.subviews.last?.frame.maxY ?? 44
        return  height + 8
    }
    open func showBadge(_ title:String, frame:CGRect) {
        redBadge.frame = frame
        redBadge.text = title
        if !contentView.subviews.contains(redBadge) {
            contentView.addSubview(redBadge)
        }
    }
    open func hideBadge() {
        redBadge.removeFromSuperview()
    }
}
