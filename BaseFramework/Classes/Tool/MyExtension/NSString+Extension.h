//
//  NSString+Extension.h
//  MyRill
//
//  Created by 钟凡 on 16/3/28.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Extension)

+ (NSString *)base64StringFromImage:(UIImage *)image;
+ (NSString *)dateStrFromInt:(long long)time;
@end
