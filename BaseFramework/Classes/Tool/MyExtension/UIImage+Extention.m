//
//  UIImage+Extention.m
//  MyRill
//
//  Created by 钟凡 on 16/1/22.
//
//

#import "UIImage+Extention.h"

@implementation UIImage (Extention)

+(UIImage *)imageFromColor:(UIColor *)color {
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}
+(UIImage *)imageFromRect:(CGRect)rect {
    
    UIGraphicsBeginImageContext(rect.size);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}
+(UIImage *)imageWithBase64String:(NSString *)string {
    NSData *data = [[NSData alloc] initWithBase64EncodedString:string options:0];
    UIImage *image = [UIImage imageWithData:data];
    return image;
}

@end
