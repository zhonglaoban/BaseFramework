//
//  CacheManager.h
//  MyRill
//
//  Created by 钟凡 on 16/3/19.
//
//

#import <Foundation/Foundation.h>

@interface CacheManager : NSObject
+(float)folderSizeAtPath:(NSString *)path;
+(void)clearCache:(NSString *)path;
@end
