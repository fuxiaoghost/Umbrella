//
//  Utils.m
//  Umbrella
//
//  Created by Dawn on 13-6-15.
//  Copyright (c) 2013年 Dawn. All rights reserved.
//

#import "Utils.h"
#define CONFIG_PATH @"Config"

@implementation Utils

+ (NSArray *) config{
    //配置文件夹路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *cPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:CONFIG_PATH];
    cPath = [cPath stringByAppendingPathComponent:@"Config.plist"];
    
    //检测配置文件夹是否存在，如果不存在就创建
    if (![[NSFileManager defaultManager] fileExistsAtPath:cPath]){
        
        [[NSFileManager defaultManager] copyItemAtPath:RESOURCEFILE(@"Config", @"plist") toPath:cPath error:NULL];
    }
    return [NSArray arrayWithContentsOfFile:cPath];
}
@end
