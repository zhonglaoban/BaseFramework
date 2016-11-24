//
//  Created by 周文超 on 15/4/26.
//  Copyright (c) 2015年 . All rights reserved.
//

#import <UIKit/UIKit.h>

@class SNActionSheet;

typedef void (^SNActionSheetButtonClicked)(SNActionSheet *actionSheet, NSInteger buttonIndex, NSString *title);

@protocol SNActionSheetDelegate <NSObject>

@optional
- (void)actionSheet:(SNActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;

@end

@interface SNActionSheet : UIView

@property (nonatomic, assign) NSUInteger hignlightIndex;
@property (nonatomic, strong) UIColor *hightlightColor;

/** 添加block */
@property (nonatomic, copy)  SNActionSheetButtonClicked buttonClicked;

/**
 *  返回一个ActionSheet对象, 类方法
 *  @param titleView 标题View,显示在顶部
 *  @param titles 所有按钮的标题
 *  @param delegate 代理
 *  Tip: 如果没有红色按钮, redButtonIndex给`-1`即可
 */
+ (instancetype)actionSheetWithTitleView:(UIView *)titleView
                        buttonTitles:(NSArray *)titles
                            delegate:(id<SNActionSheetDelegate>)delegate;

/**
 *  返回一个ActionSheet对象, 类方法
 *  @param titleView 标题View
 *  @param titles 所有按钮的标题
 *  @param buttonClickBlock 回调
 *  Tip: 如果没有红色按钮, redButtonIndex给`-1`即可
 */
+ (instancetype)actionSheetWithTitleView:(UIView *)titleView
                        buttonTitles:(NSArray *)titles
                     hightlightIndex:(NSInteger)hightlightIndex
                     hightlightColor:(UIColor *)hightlightColor
                    buttonClickBlock:(SNActionSheetButtonClicked)buttonAtIndexBlock;

/**
 *  返回一个ActionSheet对象, 类方法
 *  @param title 提示标题
 *  @param titles 所有按钮的标题
 *  @param delegate 代理
 *  Tip: 如果没有红色按钮, redButtonIndex给`-1`即可
 */
+ (instancetype)actionSheetWithTitle:(NSString *)title
                  buttonTitles:(NSArray *)titles
                      delegate:(id<SNActionSheetDelegate>)delegate;

/**
 *  返回一个ActionSheet对象, 类方法
 *  @param title 提示标题
 *  @param titles 所有按钮的标题
 *  @param buttonClickBlock 回调
 *  Tip: 如果没有红色按钮, redButtonIndex给`-1`即可
 */
+ (instancetype)actionSheetWithTitle:(NSString *)title
                        buttonTitles:(NSArray *)titles
                     hightlightIndex:(NSInteger)hightlightIndex
                     hightlightColor:(UIColor *)hightlightColor
              buttonClickBlock:(SNActionSheetButtonClicked)buttonAtIndexBlock;

/**
 *  返回一个ActionSheet对象, 类方法
 *  @param titleView 标题View,显示在顶部
 *  @param titles 所有按钮的标题
 *  @param delegate 代理
 *  Tip: 如果没有红色按钮, redButtonIndex给`-1`即可
 */
- (instancetype)initWithTitleView:(UIView *)titleView
                            buttonTitles:(NSArray *)titles
                                delegate:(id<SNActionSheetDelegate>)delegate;

/**
 *  返回一个ActionSheet对象, 实例方法
 *  @param titleView 标题View
 *  @param titles 所有按钮的标题
 *  @param redButtonIndex 红色按钮的index
 *  @param buttonClickBlock 回调
 *  Tip: 如果没有红色按钮, redButtonIndex给`-1`即可
 */
- (instancetype)initWithTitleView:(UIView *)titleView
                     buttonTitles:(NSArray *)titles
                  hightlightIndex:(NSInteger)hightlightIndex
                  hightlightColor:(UIColor *)hightlightColor
             buttonClickBlock:(SNActionSheetButtonClicked)buttonAtIndexBlock;

/**
 *  返回一个ActionSheet对象, 实例方法
 *  @param title 提示标题
 *  @param titles 所有按钮的标题
 *  @param delegate 代理
 *  Tip: 如果没有红色按钮, redButtonIndex给`-1`即可
 */
- (instancetype)initWithTitle:(NSString *)title
                 buttonTitles:(NSArray *)titles
                     delegate:(id<SNActionSheetDelegate>)delegate;

/**
 *  返回一个ActionSheet对象, 实例方法
 *  @param title 提示标题
 *  @param titles 所有按钮的标题
 *  @param redButtonIndex 红色按钮的index
 *  @param buttonClickBlock 回调
 *  Tip: 如果没有红色按钮, redButtonIndex给`-1`即可
 */
- (instancetype)initWithTitle:(NSString *)title
                 buttonTitles:(NSArray *)titles
              hightlightIndex:(NSInteger)hightlightIndex
              hightlightColor:(UIColor *)hightlightColor
             buttonClickBlock:(SNActionSheetButtonClicked)buttonAtIndexBlock;

@property (nonatomic, weak) id<SNActionSheetDelegate> delegate;

@property (nonatomic, assign) BOOL seperateLineHidden;

@property (nonatomic, strong) UIWindow *containerWindow;
/**
 *  显示
 */
- (void)show;

/**
 *  消失
 */
- (void)dismiss:(UITapGestureRecognizer *)tap;

- (void)didClickCancelBtn;

@end
