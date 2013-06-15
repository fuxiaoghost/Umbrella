//
//  SettingViewController.m
//  Umbrella
//
//  Created by Dawn on 13-6-15.
//  Copyright (c) 2013年 Dawn. All rights reserved.
//

#import "SettingViewController.h"
#import "ActionButton.h"

@interface SettingViewController ()

@end

@implementation SettingViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"设置";
    
    ActionButton *closeButton = [ActionButton buttonWithType:UIButtonTypeCustom];
    closeButton.frame = CGRectMake(10, 7, 50, 30);
    [closeButton setTitle:@"返回" forState:UIControlStateNormal];
    [closeButton.titleLabel setFont:[UIFont boldSystemFontOfSize:16.0f]];
    [self.view addSubview:closeButton];
    closeButton.radius = 2.0f;
    [closeButton addTarget:self action:@selector(closeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark -
#pragma Actions
- (void) closeButtonClick:(id)sender{
    if (IOSVersion_5) {
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }else{
        [self dismissModalViewControllerAnimated:YES];
    }
}

@end
