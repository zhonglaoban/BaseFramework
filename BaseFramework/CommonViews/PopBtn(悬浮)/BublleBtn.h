//
//  BublleBtn.h
//  PopView
//
//  Created by 钟凡 on 16/4/6.
//  Copyright © 2016年 钟凡. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BublleBtn;
typedef void(^BublleClick)(BublleBtn *btn);

@interface BublleBtn : UIButton

@property (nonatomic, strong) BublleClick bublleClick;
@property (nonatomic, strong) UIToolbar *toolbar;
@end
