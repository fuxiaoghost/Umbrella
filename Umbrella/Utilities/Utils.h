//
//  Utils.h
//  Umbrella
//
//  Created by Dawn on 13-6-15.
//  Copyright (c) 2013年 Dawn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject{
    
}
+ (NSMutableArray *) config;
+ (id) settingValueForKey:(NSString *)key;
+ (void) setSettingValue:(id)obj forKey:(NSString *)key;
@end
