//
//  BeginningViewController.m
//  Umbrella
//
//  Created by Dawn on 13-6-15.
//  Copyright (c) 2013年 Dawn. All rights reserved.
//

#import "BeginningViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "ActionButton.h"
#import "SettingViewController.h"

@interface BeginningViewController ()

@end

@implementation BeginningViewController


- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = UMB_LIGHTPINK;
    
	// Do any additional setup after loading the view.
    
    // 重要信息提示
    UILabel *tipsLbl = [[UILabel alloc] initWithFrame:CGRectMake(40, 60, SCREEN_WIDTH - 80, 60)];
    tipsLbl.backgroundColor = RGBACOLOR(255, 255, 255, 0.4);
    tipsLbl.layer.cornerRadius = 5.0f;
    tipsLbl.textAlignment = NSTextAlignmentCenter;
    tipsLbl.text = @"经期日2";
    tipsLbl.font = [UIFont boldSystemFontOfSize:36.0f];
    [self.view addSubview:tipsLbl];
    [tipsLbl release];
    
    // 事件触发按钮
    ActionButton *actionButton  = [ActionButton buttonWithType:UIButtonTypeCustom];
    actionButton.frame = CGRectMake(50, 200, SCREEN_WIDTH - 100, 50);
    actionButton.radius = 5.0f;
    [actionButton setTitle:@"经期结束" forState:UIControlStateNormal];
    [actionButton.titleLabel setFont:[UIFont boldSystemFontOfSize:24.0f]];
    [actionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:actionButton];
    
    
    // 配置按钮
    UIButton *settingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    settingButton.frame = CGRectMake(SCREEN_WIDTH - 60, SCREEN_HEIGHT - 20 - 60, 60, 60);
    [settingButton setImage:[UIImage imageNamed:@"setting_icon.png"] forState:UIControlStateNormal];
    [self.view addSubview:settingButton];
    [settingButton addTarget:self action:@selector(settingButtonClick:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark -
#pragma mark Actions

- (void) settingButtonClick:(id)sender{
    SettingViewController *settingVC = [[SettingViewController alloc] init];
    UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:settingVC];
    [settingVC release];
    
    if (IOSVersion_5) {
        [self presentViewController:navC animated:YES completion:^{
            
        }];
    }else{
        [self presentModalViewController:navC animated:YES];
    }
    
    [navC release];
}

@end
