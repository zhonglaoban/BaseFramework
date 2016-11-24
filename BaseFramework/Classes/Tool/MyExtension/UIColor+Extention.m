//
//  UIColor+Extention.m
//  MyRill
//
//  Created by 钟凡 on 16/2/1.
//
//

#import "UIColor+Extention.h"

@implementation UIColor (Extention)

+(UIColor *)colorWithR:(CGFloat)red G:(CGFloat)green B:(CGFloat)blue A:(CGFloat)alpa {
    return [UIColor colorWithRed:red / 255.0 green:green / 255.0 blue:blue / 255.0 alpha:alpa];
}

@end