//
//  EmoticonKeyboardViewController.swift
//  01-表情键盘
//
//  Created by apple on 15/5/23.
//  Copyright (c) 2015年 heima. All rights reserved.
//

import UIKit

/**
    UI 组成 : UICollectionView + ToolBar

    自定义键盘的 frame 是需要考虑的
    */
private var cellIdentifier = "cellIdentifier"

class EmoticonKeyboardViewController: UIViewController {

    /// 选中表情回调闭包
    var selectedEmoticon: ((_ emoticon: Emoticons)->())?
    /// 发送表情回调闭包
    var sendBlock:((UIButton)->())?
    
    /// 实例化键盘控制器，并且指定选中表情的回调
    init(selectedEmoticon: @escaping (_ emoticon: Emoticons)->()) {
        super.init(nibName: nil, bundle: nil)
        
        // 记录闭包
        self.selectedEmoticon = selectedEmoticon
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    deinit {
        print("keyboard VC 88")
    }
    
    /// 表情数组
    lazy var emoticonsList: [Emoticons] = Emoticons.emoticonsArray
    
    lazy var toolBar: UIView = {
        // 键盘视图高度 216
        let tool = UIView(frame: CGRect(x: 0, y: 216 - 44, width: self.view.width, height: 44))
        tool.backgroundColor = UIColor(r: 239, g: 239, b: 244, a: 1)
        let sendBtn = UIButton(frame: CGRect(x: self.view.width - 60, y: 0, width: 60, height: 44))
        sendBtn.setTitle("发送", for: UIControlState())
        sendBtn.backgroundColor = UIColor(r: 28, g: 167, b: 221, a: 1)
        sendBtn.addTarget(self, action: #selector(EmoticonKeyboardViewController.send(_:)), for: UIControlEvents.touchUpInside)
        tool.addSubview(sendBtn)
        
        return tool
    }()
    
    // 因为所有的东西都是在bundle中的，此处可以适当偷懒，可以想更好的办法
    func send(_ btn:UIButton) {
        if sendBlock != nil {
            sendBlock!(btn)
        }
    }
    
    /// 表情集合视图
    lazy var collectionView: UICollectionView = {
       
        let layout = UICollectionViewFlowLayout()
        
        let w = UIScreen.main.bounds.width / 7
        layout.itemSize = CGSize(width: w, height: w)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.sectionInset = UIEdgeInsetsMake(4, 0, 0, 0)
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        
        let cv = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.view.width, height: 216 - 44), collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        cv.isPagingEnabled = true
        
        cv.dataSource = self
        cv.delegate = self
        
        // 注册原型cell
        cv.register(EmoticonCell.self, forCellWithReuseIdentifier: cellIdentifier)
        
        return cv
    }()
    
    override func loadView() {
        // 执行系统默认的方法创建 view
        super.loadView()
        setupUI()
        view.backgroundColor = UIColor.white
    }
    
    fileprivate func setupUI() {
        view.addSubview(collectionView)
        view.addSubview(toolBar)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

/**
    要交互的控件，最好保证有 40 个点，再小就不好交互了
*/
extension EmoticonKeyboardViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 根据 indexPath 取到用户选中的表情
        if let cell = collectionView.cellForItem(at: indexPath) as? EmoticonCell {
            // 闭包回调
            self.selectedEmoticon!(cell.emoticons!)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return emoticonsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! EmoticonCell
        
        cell.emoticons = emoticonsList[(indexPath as NSIndexPath).item]
        
        return cell
    }
}

class EmoticonCell: UICollectionViewCell {
    
    // 表情模型
    var emoticons: Emoticons? {
        didSet {
            // 1. 设置图像
            if emoticons?.imagePath != nil {
                emoticonButton.setImage(UIImage(contentsOfFile: emoticons!.imagePath!), for: UIControlState())
            } else {
                emoticonButton.setImage(nil, for: UIControlState())
            }
            
            // 2. emoji
            emoticonButton.setTitle(emoticons?.emojiStr ?? "", for: UIControlState())
            
            // 3. 删除按钮
            if emoticons!.isRemoveButton {
                emoticonButton.setImage(UIImage(named: "compose_emotion_delete"), for: UIControlState())
                emoticonButton.setImage(UIImage(named: "compose_emotion_delete_highlighted"), for: UIControlState.highlighted)
            }
        }
    }
    
    var emoticonButton = UIButton()
    
    // frame 就是 cell 的准确大小
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 设置按钮大小
        emoticonButton.frame = bounds.insetBy(dx: 4, dy: 4)
        emoticonButton.backgroundColor = UIColor.white
        
        // 指定文本的字体大小与图像大小一致
        emoticonButton.titleLabel?.font = UIFont.systemFont(ofSize: 32)
        
        // 取消 button 的用户交互，就能够用 collevtionView 的代理方法拦截
        emoticonButton.isUserInteractionEnabled = false
        
        addSubview(emoticonButton)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
}
