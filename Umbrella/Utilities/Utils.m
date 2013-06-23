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

+ (NSMutableArray *) config{
    //配置文件夹路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *cPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:CONFIG_PATH];
    
    // 创建Config目录
    if (![[NSFileManager defaultManager] fileExistsAtPath:cPath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:cPath withIntermediateDirectories:NO attributes:nil error:nil];
    }
    
    cPath = [cPath stringByAppendingPathComponent:@"Config.plist"];
    
    //检测配置文件夹是否存在，如果不存在就创建
    if (![[NSFileManager defaultManager] fileExistsAtPath:cPath]){
        
        NSError *error;
        [[NSFileManager defaultManager] copyItemAtPath:RESOURCEFILE(@"Config", @"plist") toPath:cPath error:&error];
    }else{
        NSDictionary *currentDict = [NSDictionary dictionaryWithContentsOfFile:RESOURCEFILE(@"Config", @"plist")];
        NSDictionary *formerDict = [NSDictionary dictionaryWithContentsOfFile:cPath];
        if (![[formerDict objectForKey:@"Version"] isEqualToString:[currentDict objectForKey:@"Version"]]) {
            NSError *error;
            // 移除
            [[NSFileManager defaultManager] removeItemAtPath:cPath error:&error];
            
            // 拷贝
            [[NSFileManager defaultManager] copyItemAtPath:RESOURCEFILE(@"Config", @"plist") toPath:cPath error:&error];
        }
    }
    NSDictionary *formerDict = [NSDictionary dictionaryWithContentsOfFile:cPath];
    return [NSMutableArray arrayWithArray:[formerDict objectForKey:@"Data"]];
}
@end
