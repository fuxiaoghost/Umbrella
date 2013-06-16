//
//  BaseViewController.m
//  ToyFinder
//
//  Created by Dawn on 13-5-28.
//  Copyright (c) 2013年 Dawn. All rights reserved.
//

#import "BaseViewController.h"
#import "ActionButton.h"

@interface BaseViewController ()

@end

@implementation BaseViewController


- (void)viewDidLoad{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = RGBACOLOR(250, 250, 250, 1);
    
    // 导航栏标题
    if (LAYOUT_PORTRAIT || LAYOUT_UPSIDEDOWN) {
        titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    }else{
        titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_HEIGHT, 44)];
    }
    
    titleLbl.backgroundColor = UMB_LIGHTPINK;
    titleLbl.font = [UIFont boldSystemFontOfSize:22.0f];
    titleLbl.textAlignment = NSTextAlignmentCenter;
    titleLbl.textColor = UMB_PINK;
    [self.view addSubview:titleLbl];
    [titleLbl release];
    
    
    if (LAYOUT_PORTRAIT || LAYOUT_UPSIDEDOWN) {
        splitView = [[UIView alloc] initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, 1)];
    }else{
        splitView = [[UIView alloc] initWithFrame:CGRectMake(0, 44, SCREEN_HEIGHT, 1)];
    }
    
    splitView.backgroundColor = UMB_PINK;
    [self.view addSubview:splitView];
    [splitView release];
    
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
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) setTitle:(NSString *)title{
    [super setTitle:title];
    [titleLbl setText:[NSString stringWithFormat:@"%@",title]];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    switch (toInterfaceOrientation) {
        case UIInterfaceOrientationLandscapeLeft:{
        }
        case UIInterfaceOrientationLandscapeRight:{
            titleLbl.frame = CGRectMake(0, 0, SCREEN_HEIGHT, 44);
            splitView.frame = CGRectMake(0, 44, SCREEN_HEIGHT, 1);
            break;
        }
        case UIInterfaceOrientationPortrait:{
            titleLbl.frame = CGRectMake(0, 0, SCREEN_WIDTH, 44);
            splitView.frame = CGRectMake(0, 44, SCREEN_WIDTH, 1);
            break;
        }
        default:
            break;
    }
    
}


@end
