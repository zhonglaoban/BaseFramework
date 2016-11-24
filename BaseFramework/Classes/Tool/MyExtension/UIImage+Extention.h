//
//  UIImage+Extention.h
//  MyRill
//
//  Created by 钟凡 on 16/1/22.
//
//

#import <UIKit/UIKit.h>

@interface UIImage (Extention)

+(UIImage *)imageFromColor:(UIColor *)color;
+(UIImage *)imageFromRect:(CGRect)rect;
+(UIImage *)imageWithBase64String:(NSString *)string;
@end
