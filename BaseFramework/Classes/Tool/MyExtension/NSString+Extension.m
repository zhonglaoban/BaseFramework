//
//  NSString+Extension.m
//  MyRill
//
//  Created by 钟凡 on 16/3/28.
//
//

#import "NSString+Extension.h"
 
@implementation NSString (Extension)
+ (NSString *)base64StringFromImage:(UIImage *)image {
    
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
    NSString *base64Str = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    return base64Str;
}
+ (NSString *)dateStrFromInt:(long long)intTime {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:intTime / 1000];
    NSDateFormatter *dfmt =  [[NSDateFormatter alloc] init];
    NSDate *now = [[NSDate alloc] init];
    NSTimeInterval time = [now timeIntervalSinceDate:date];
    if (time < 60) {
        return @"刚刚";
    }else if(time < 60 * 60){
        return [NSString stringWithFormat:@"%.f分钟前", time/60];
    }else if(time < 60 * 60 * 24){
        return [NSString stringWithFormat:@"%.f小时前", time/3600];
    }else if(time < 60 * 60 * 24 * 2){
        return @"昨天";
    }else{
        dfmt.dateFormat = @"yyyy-MM-dd";
        return [dfmt stringFromDate:date];
    }
}
@end
