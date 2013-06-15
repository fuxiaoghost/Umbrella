//
//  RootViewController.h
//  Umbrella
//
//  Created by Wang Shuguang on 13-6-14.
//  Copyright (c) 2013年 Dawn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BeginningViewController.h"
#import "CalendarViewController.h"

@interface RootViewController : UIViewController{
@private
    UIScrollView *contentScrollView;
    BeginningViewController *beginningVC;
    CalendarViewController *calendarVC;
}

@end
