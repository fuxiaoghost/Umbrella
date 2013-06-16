//
//  RootViewController.m
//  Umbrella
//
//  Created by Wang Shuguang on 13-6-14.
//  Copyright (c) 2013年 Dawn. All rights reserved.
//

#import "RootViewController.h"


@interface RootViewController ()


@end

@implementation RootViewController

- (void) dealloc{
    [beginningVC release];
    [calendarVC release];
    [super dealloc];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    // 两页的容器
    contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 20)];
    contentScrollView.pagingEnabled = YES;
    contentScrollView.contentSize = CGSizeMake(contentScrollView.frame.size.width * 2, contentScrollView.frame.size.height);
    contentScrollView.showsHorizontalScrollIndicator = NO;
    contentScrollView.showsVerticalScrollIndicator = NO;
    contentScrollView.bounces = NO;
    contentScrollView.scrollsToTop = NO;
    [self.view addSubview:contentScrollView];
    [contentScrollView release];
    
    // 启动页面
    beginningVC = [[BeginningViewController alloc] init];
    beginningVC.view.frame = CGRectMake(0, 0, contentScrollView.frame.size.width, contentScrollView.frame.size.height);
    [contentScrollView addSubview:beginningVC.view];
    
    // 日历页面
    calendarVC = [[CalendarViewController alloc] init];
    calendarVC.view.frame = CGRectMake(contentScrollView.frame.size.width, 0, contentScrollView.frame.size.width, contentScrollView.frame.size.height);
    [contentScrollView addSubview:calendarVC.view];
    
}

@end
