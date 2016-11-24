//
//  Created by 周文超 on 15/4/26.
//  Copyright (c) 2015年 . All rights reserved.
//

#import "SNActionSheet.h"
#import "UIView+Extention.h"
#import "UIImage+Extention.h"
#import "UIColor+Extention.h"

/** 按钮高度 */
#define BUTTON_H 55.f

/** 屏幕尺寸 */
#define SCREEN_SIZE [UIScreen mainScreen].bounds.size

/** 颜色 */
#define LCColor(r, g, b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.0f]

@interface SNActionSheet () {
    
    UIView *_titleSeperateLineView;
    /** 所有按钮 */
    NSArray *_buttonTitles;
    
    /** 暗黑色的view */
    UIView *_maskView;
    
    /** 所有按钮的容器view */
    UIView *_containerView;
}

@end

@implementation SNActionSheet

+ (instancetype)actionSheetWithTitleView:(UIView *)titleView buttonTitles:(NSArray *)titles delegate:(id<SNActionSheetDelegate>)delegate
{
    return [[self alloc] initWithTitleView:titleView buttonTitles:titles delegate:delegate];
}

+ (instancetype)actionSheetWithTitleView:(UIView *)titleView buttonTitles:(NSArray *)titles hightlightIndex:(NSInteger)hightlightIndex hightlightColor:(UIColor *)hightlightColor buttonClickBlock:(SNActionSheetButtonClicked)buttonAtIndexBlock
{
    return [[self alloc] initWithTitleView:titleView buttonTitles:titles hightlightIndex:hightlightIndex hightlightColor:hightlightColor buttonClickBlock:buttonAtIndexBlock];
}

+ (instancetype)actionSheetWithTitle:(NSString *)title buttonTitles:(NSArray *)titles delegate:(id<SNActionSheetDelegate>)delegate {
    return [[self alloc] initWithTitle:title buttonTitles:titles delegate:delegate];
}

+ (instancetype)actionSheetWithTitle:(NSString *)title buttonTitles:(NSArray *)titles hightlightIndex:(NSInteger)hightlightIndex hightlightColor:(UIColor *)hightlightColor buttonClickBlock:(SNActionSheetButtonClicked)buttonAtIndexBlock{
    return [[self alloc] initWithTitle:title buttonTitles:titles hightlightIndex:hightlightIndex hightlightColor:hightlightColor buttonClickBlock:buttonAtIndexBlock];
}

- (instancetype)initWithTitleView:(UIView *)titleView buttonTitles:(NSArray *)titles delegate:(id<SNActionSheetDelegate>)delegate
{
    _delegate = delegate;
    return [self initWithTitleView:titleView buttonTitles:titles];
}

- (instancetype)initWithTitleView:(UIView *)titleView
                     buttonTitles:(NSArray *)titles
                  hightlightIndex:(NSInteger)hightlightIndex
                  hightlightColor:(UIColor *)hightlightColor
                 buttonClickBlock:(SNActionSheetButtonClicked)buttonAtIndexBlock
{
    _buttonClicked = buttonAtIndexBlock;
    _hignlightIndex = hightlightIndex;
    _hightlightColor = hightlightColor;
    return [self initWithTitleView:titleView buttonTitles:titles];
}

- (instancetype)initWithTitle:(NSString *)title buttonTitles:(NSArray *)titles hightlightIndex:(NSInteger)hightlightIndex hightlightColor:(UIColor *)hightlightColor  buttonClickBlock:(SNActionSheetButtonClicked)buttonAtIndexBlock{
    _hignlightIndex = hightlightIndex;
    _hightlightColor = hightlightColor;
    _buttonClicked = buttonAtIndexBlock;
   return [self initWithTitle:title buttonTitles:titles];
}

- (instancetype)initWithTitle:(NSString *)title
                 buttonTitles:(NSArray *)titles
                     delegate:(id<SNActionSheetDelegate>)delegate {
       _delegate = delegate;
    return [self initWithTitle:title buttonTitles:titles];
}

- (instancetype)initWithTitle:(NSString *)title
                 buttonTitles:(NSArray *)titles
{
    UILabel *label = nil;
    if (title) {
        label = [[UILabel alloc] init];
        [label setText:title];
        [label setTextColor:[UIColor blackColor]];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setFont:[UIFont systemFontOfSize:14.0f]];
        [label setBackgroundColor:[UIColor whiteColor]];
        [label setFrame:CGRectMake(0, 0, SCREEN_SIZE.width, BUTTON_H)];
    }
    return [self initWithTitleView:label buttonTitles:titles];
}

- (instancetype)initWithTitleView:(UIView *)titleView buttonTitles:(NSArray *)titles
{
    if (self = [super init]) {
        
        // 暗黑色的view
        UIView *maskView = [[UIView alloc] init];
        [maskView setAlpha:0];
        [maskView setUserInteractionEnabled:NO];
        [maskView setFrame:(CGRect){0, 0, SCREEN_SIZE}];
        [maskView setBackgroundColor:LCColor(46, 49, 50)];
        [self addSubview:maskView];
        _maskView = maskView;
        
        // 添加手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss:)];
        [maskView addGestureRecognizer:tap];
        
        // 所有按钮的容器view
        UIView *containerView = [[UIView alloc] init];
        [containerView setBackgroundColor:[UIColor colorWithR:240 G:242 B:246 A:1]];
        [self addSubview:containerView];
        _containerView = containerView;
    
        if (titleView) {
            // 标题
            [titleView setFrame:CGRectMake(0, 0, titleView.width, titleView.height)];
            [containerView addSubview:titleView];
            
            _titleSeperateLineView = [[UIView alloc] init];
            _titleSeperateLineView.backgroundColor = [UIColor blueColor];
            _titleSeperateLineView.alpha = 0.5;
            CGFloat lineY = CGRectGetMaxY(titleView.frame);
            [_titleSeperateLineView setFrame:CGRectMake(0, lineY - 0.5, SCREEN_SIZE.width, 0.5f)];
            [containerView addSubview:_titleSeperateLineView];
        }
        
        if (titles.count)
        {
            _buttonTitles = titles;
            for (int i = 0; i < titles.count; i++)
            {
                // 所有按钮
                UIButton *btn = [[UIButton alloc] init];
                [btn setTag:i];
                [btn setBackgroundColor:[UIColor whiteColor]];
                [btn setTitle:titles[i] forState:UIControlStateNormal];
                [[btn titleLabel] setFont:[UIFont systemFontOfSize:20.0f]];
                UIColor *titleColor = nil;
                if (i == self.hignlightIndex)
                {
                    titleColor = self.hightlightColor;
                }
                else
                {
                    titleColor = [UIColor colorWithR:74 G:83 B:94 A:1];
                }
                [btn setTitleColor:titleColor forState:UIControlStateNormal];
                [btn setBackgroundImage:[UIImage imageFromColor:[UIColor colorWithR:235 G:235 B:235 A:1]] forState:UIControlStateHighlighted];
                [btn addTarget:self action:@selector(didClickBtn:) forControlEvents:UIControlEventTouchUpInside];
                CGFloat btnY = BUTTON_H * i + titleView.height;
                [btn setFrame:CGRectMake(0, btnY, SCREEN_SIZE.width, BUTTON_H)];
                [containerView addSubview:btn];
            }
            
            for (int i = 0; i < titles.count - 1; i++) {
                UIView *lineView = [[UIView alloc] init];
                lineView.backgroundColor = [UIColor colorWithR:218 G:224 B:231 A:1];
                CGFloat lineY = BUTTON_H * (i + 1) + titleView.height;
                // 所有线条
                [lineView setFrame:CGRectMake(0, lineY, SCREEN_SIZE.width, 0.5f)];
                [containerView addSubview:lineView];
            }
        }
        
        // 取消按钮
        UIButton *cancelBtn = [[UIButton alloc] init];
        [cancelBtn setTag:titles.count];
        [cancelBtn setBackgroundColor:[UIColor whiteColor]];
        [cancelBtn setTitle:NSLocalizedString(@"取消", nil) forState:UIControlStateNormal];
        [[cancelBtn titleLabel] setFont:[UIFont systemFontOfSize:20.0f]];
        [cancelBtn setTitleColor:[UIColor colorWithR:74 G:83 B:94 A:1] forState:UIControlStateNormal];
        [cancelBtn setBackgroundImage:[UIImage imageFromColor:[UIColor colorWithR:235 G:235 B:235 A:1]] forState:UIControlStateHighlighted];
        [cancelBtn addTarget:self action:@selector(didClickCancelBtn) forControlEvents:UIControlEventTouchUpInside];
        
        CGFloat btnY = BUTTON_H * titles.count + titleView.height + 5.0f;
        [cancelBtn setFrame:CGRectMake(0, btnY + 5, SCREEN_SIZE.width, BUTTON_H)];
        [containerView addSubview:cancelBtn];
        
        CGFloat bottomH = titleView.height + BUTTON_H * titles.count + BUTTON_H + 5.0f;
        [containerView setFrame:CGRectMake(0, SCREEN_SIZE.height, SCREEN_SIZE.width, bottomH)];
        [self setFrame:(CGRect){0, 0, SCREEN_SIZE}];
    }
    return self;
}


- (void)setSeperateLineHidden:(BOOL)seperateLineHidden
{
    _seperateLineHidden = seperateLineHidden;
    _titleSeperateLineView.hidden = _seperateLineHidden;
}

//- (UIWindow *)containerWindow
//{
//    if (_containerWindow == nil) {
//        _containerWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//        _containerWindow.windowLevel       = UIWindowLevelStatusBar - 1;
//        _containerWindow.backgroundColor   = [UIColor clearColor];
//        _containerWindow.hidden = NO;
//    }
//    return _containerWindow;
//}


- (void)didClickBtn:(UIButton *)btn {
    [self dismiss:nil];
    if (self.buttonClicked) {
        self.buttonClicked(self, btn.tag, btn.currentTitle);
        self.buttonClicked = nil;
    }else{
        if ([_delegate respondsToSelector:@selector(actionSheet:clickedButtonAtIndex:)]) {
            [_delegate actionSheet:self clickedButtonAtIndex:btn.tag];
        }
    }
}

- (void)dismiss:(UITapGestureRecognizer *)tap {
    
    [self.containerWindow removeFromSuperview];
    self.containerWindow = nil;
    
    [UIView animateWithDuration:0.3f
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         [_maskView setAlpha:0];
                         [_maskView setUserInteractionEnabled:NO];
                         CGRect frame = _containerView.frame;
                         frame.origin.y += frame.size.height;
                         [_containerView setFrame:frame];
                         
                     } completion:^(BOOL finished) {
                         
                         [self removeFromSuperview];
                     }];
}

- (void)didClickCancelBtn
{
    [UIView animateWithDuration:0.3f
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         
                         [_maskView setAlpha:0];
                         [_maskView setUserInteractionEnabled:NO];
                         
                         CGRect frame = _containerView.frame;
                         frame.origin.y += frame.size.height;
                         [_containerView setFrame:frame];
                         
                     } completion:^(BOOL finished) {
                         [self removeFromSuperview];
                         if ([_delegate respondsToSelector:@selector(actionSheet:clickedButtonAtIndex:)]) {
                             
                             [_delegate actionSheet:self clickedButtonAtIndex:_buttonTitles.count];
                         }
                     }];
}

- (void)show {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    [UIView animateWithDuration:0.3f
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         [_maskView setAlpha:0.4f];
                         [_maskView setUserInteractionEnabled:YES];
                         CGRect frame = _containerView.frame;
                         frame.origin.y -= frame.size.height;
                         [_containerView setFrame:frame];
                         
                     } completion:nil];
}

@end
