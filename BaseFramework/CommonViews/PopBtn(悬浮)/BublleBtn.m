//
//  BublleBtn.m
//  PopView
//
//  Created by 钟凡 on 16/4/6.
//  Copyright © 2016年 钟凡. All rights reserved.
//

#import "BublleBtn.h"
#import "FilePath.h"


typedef NS_ENUM (NSUInteger, LocationTag)
{
    kLocationTag_top = 1,
    kLocationTag_left,
    kLocationTag_bottom,
    kLocationTag_right
};

@implementation BublleBtn
{
    BOOL _bClick;//是否在展开了菜单，展开时不允许移动浮标
    BOOL _bMoving;//是否在移动浮标
    
    LocationTag _locationTag;
    CGPoint _startP;
    CGPoint _endP;
    
    CGRect _lastFrame;
    
    float _w;
    float _h;
    float width;
    float height;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _w = [UIScreen mainScreen].bounds.size.width;
        _h = [UIScreen mainScreen].bounds.size.height - 44;
        width = frame.size.width;
        height = frame.size.height;
        NSString *path = [FilePath getFilePath:@"btn.png"];
        UIImage *img = [UIImage imageWithContentsOfFile:path];
        [self setBackgroundImage:img forState:UIControlStateNormal];
        [self addSubview:self.toolbar];
    }
    return self;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesBegan");
    _bClick = YES;
    NSString *path2 = [FilePath getFilePath:@"btn.png"];
    UIImage *img2 = [UIImage imageWithContentsOfFile:path2];
    [self setBackgroundImage:img2 forState:UIControlStateNormal];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesCancelled");
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    _lastFrame = self.frame;
    if (_bClick) {
        if (_toolbar.bounds.size.width > 0) {
            [self hideMenu];
        }else {
            [self showMenu];
        }
    }
    [self computeOfLocation];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesMoved");
    UITouch *touch = [touches anyObject];
    CGPoint movedPT = [touch locationInView:[self superview]];
    if (!CGRectContainsPoint(_lastFrame, movedPT)) {
        _bClick = NO;
    }
    
    if (movedPT.x - self.frame.size.width/2 < 0.f ||
        movedPT.x + self.frame.size.width/2 > _w ||
        movedPT.y - self.frame.size.height/2 < 0.f ||
        movedPT.y + self.frame.size.height/2 > _h)
    {
        return;
    }
    
    [self setCenter:movedPT];
}
- (void)itemClick:(UIBarButtonItem *)sender {
    if (_bublleClick) {
        _bublleClick(self);
    }
}
- (void)showMenu {
    [UIView animateWithDuration:2 delay:0.5 usingSpringWithDamping:0.5 initialSpringVelocity:1 options:UIViewAnimationOptionLayoutSubviews animations:^{
        _toolbar.frame = CGRectMake(width, 0, _w - width, height);
    } completion:nil];
}
- (void)hideMenu {
    [UIView animateWithDuration:1.0 animations:^{
        _toolbar.frame = CGRectMake(width, 0, 0, height);
    }];
}
- (void)computeOfLocation
{
    float x = self.center.x;
    float y = self.center.y;
    CGPoint m = CGPointZero;
    m.x = x;
    m.y = y;
    
    //这里是可以根据上左下右边距，取近的位置靠边-------------------
    if (x < _w/2 && y <= _h/2)
    {
        if (x < y)
            _locationTag = kLocationTag_left;
        else
            _locationTag = kLocationTag_top;
    }else if (x > _w/2 && y < _h/2)
    {
        if (_w - x < y)
            _locationTag = kLocationTag_right;
        else
            _locationTag = kLocationTag_top;
    }else if (x < _w/2 && y > _h/2)
    {
        if (x < _h - y)
            _locationTag = kLocationTag_left;
        else
            _locationTag = kLocationTag_bottom;
    }else //if (x > __w/2 && y > _h/2)//在中间就归为第四象限
    {
        if (_w - x < _h - y)
            _locationTag = kLocationTag_right;
        else
            _locationTag = kLocationTag_bottom;
    }
    
    //由于这里要展开菜单，所以只取两边就好--------------------------
//    if (x < _w/2)
//    {
//        _locationTag = kLocationTag_left;
//    }else
//    {
//        _locationTag = kLocationTag_right;
//    }
    
    //---------------------------------------------------------
    
    switch (_locationTag)
    {
        case kLocationTag_top:
            m.y = 0 + self.frame.size.width/2;
            break;
        case kLocationTag_left:
            m.x = 0 + self.frame.size.height/2;
            break;
        case kLocationTag_bottom:
            m.y = _h - self.frame.size.height/2;
            break;
        case kLocationTag_right:
            m.x = _w - self.frame.size.width/2;
            break;
    }
    
    //这个是在旋转是微调浮标出界时
    if (m.x > _w - self.frame.size.width/2)
        m.x = _w - self.frame.size.width/2;
    if (m.y > _h - self.frame.size.height/2)
        m.y = _h - self.frame.size.height/2;
    
    [UIView animateWithDuration:0.1 animations:^
     {
         [self setCenter:m];
     } completion:^(BOOL finished)
     {
         NSString *path = [FilePath getFilePath:@"btn.png"];
         UIImage *img = [UIImage imageWithContentsOfFile:path];
         [self setBackgroundImage:img forState:UIControlStateNormal];
     }];
}
- (UIToolbar *)toolbar {
    if (!_toolbar) {
        UIImage *backImg = [UIImage imageNamed:@"btn_back"];
        backImg = [backImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIBarButtonItem *backItem   = [[UIBarButtonItem alloc] initWithImage:backImg
                                                                       style:UIBarButtonItemStylePlain
                                                                      target:self
                                                                      action:@selector(itemClick:)];
        backItem.tag = 301;
        
        UIImage *forwardImg = [UIImage imageNamed:@"btn_home"];
        forwardImg = [forwardImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIBarButtonItem *forwardItem = [[UIBarButtonItem alloc] initWithImage:forwardImg
                                                                        style:UIBarButtonItemStylePlain
                                                                       target:self
                                                                       action:@selector(itemClick:)];
        forwardItem.tag = 302;
        
        UIImage *addTaskImg = [UIImage imageNamed:@"btn_share"];
        addTaskImg = [addTaskImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIBarButtonItem *addTaskItem = [[UIBarButtonItem alloc] initWithImage:addTaskImg
                                                                        style:UIBarButtonItemStylePlain
                                                                       target:self
                                                                       action:@selector(itemClick:)];
        addTaskItem.tag = 303;
        
        UIImage *quitImage = [UIImage imageNamed:@"btn_quit"];
        quitImage = [quitImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIBarButtonItem *quitItem = [[UIBarButtonItem alloc] initWithImage:quitImage
                                                                     style:UIBarButtonItemStylePlain
                                                                    target:self
                                                                    action:@selector(itemClick:)];
        quitItem.tag = 304;
        
        UIImage *refreshImage = [UIImage imageNamed:@"btn_refresh"];
        refreshImage = [refreshImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIBarButtonItem *refreshItem = [[UIBarButtonItem alloc] initWithImage:refreshImage
                                                                        style:UIBarButtonItemStylePlain
                                                                       target:self
                                                                       action:@selector(itemClick:)];
        refreshItem.tag = 305;
        UIBarButtonItem *placeHolderItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                         target:self
                                                                                         action:nil];
        _toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(width, 0, 0, height)];
        _toolbar.backgroundColor = [UIColor whiteColor];
        _toolbar.barStyle = UIBarStyleDefault;
        _toolbar.items = @[backItem, placeHolderItem, forwardItem, placeHolderItem, addTaskItem, placeHolderItem, refreshItem, placeHolderItem, quitItem];
    }
    
    return _toolbar;
}
@end
