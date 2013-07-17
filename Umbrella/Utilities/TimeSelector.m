//
//  TimeSelector.m
//  Umbrella
//
//  Created by Dawn on 13-7-13.
//  Copyright (c) 2013年 Dawn. All rights reserved.
//

#import "TimeSelector.h"
#import "AppDelegate.h"
#import "ActionButton.h"

@implementation TimeSelector
@synthesize delegate;
@synthesize time = _time;

- (id) init{
    if (self = [super init]) {
        
    }
    return self;
}

- (void) popOverView:(UIView *)view{
    [self retain];
    
    // 容器
    contentView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 216)];
    contentView.backgroundColor = UMB_LIGHTPINK;
    
    // 分割颜色线
    UIView *splitView = [[UIView alloc] initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, 1)];
    splitView.backgroundColor = UMB_PINK;
    [contentView addSubview:splitView];
    [splitView release];
    
    // 确定
    ActionButton *confirmBtn = [ActionButton buttonWithType:UIButtonTypeCustom];
    confirmBtn.frame = CGRectMake(SCREEN_WIDTH - 60, 7, 50, 30);
    [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [confirmBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:16.0f]];
    [contentView addSubview:confirmBtn];
    confirmBtn.radius = 2.0f;
    [confirmBtn addTarget:self action:@selector(confirmBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // 取消
    ActionButton *cancelBtn = [ActionButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(10, 7, 50, 30);
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:16.0f]];
    [contentView addSubview:cancelBtn];
    cancelBtn.radius = 2.0f;
    [cancelBtn addTarget:self action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // 滚轮
    pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 45, SCREEN_WIDTH, 216-36)];
    pickerView.delegate = self;
    pickerView.dataSource =  self;
    pickerView.showsSelectionIndicator = YES;
    [contentView addSubview:pickerView];
    [pickerView release];
    
    if (view) {
        [view addSubview:contentView];
    }else{
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [appDelegate.window addSubview:contentView];
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        contentView.frame = CGRectMake(0, SCREEN_HEIGHT - 216, SCREEN_WIDTH, 216);
    }];
}

- (void) slideDown{
    [UIView animateWithDuration:0.3 animations:^{
        contentView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 216);
    } completion:^(BOOL finished) {
        [contentView removeFromSuperview];
        [self release];
    }];
}

- (void) setTime:(NSInteger)time_{
    NSInteger hour = time_/60;
    NSInteger minute = time_ % 60;
    NSInteger row = hour;
    NSInteger component = minute/5;
    _time = time_;
    [pickerView selectRow:row inComponent:component animated:YES];
}

- (NSInteger) time{
    NSInteger hour = [pickerView selectedRowInComponent:0];
    NSInteger minute = [pickerView selectedRowInComponent:1] * 5;
    _time = hour * 60 + minute;
    return _time;
}

#pragma mark -
#pragma mark UIPickerViewDataSource
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0) {
        return 24;
    }else if(component == 1){
        return 12;
    }
    return 0;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *numLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];
    numLbl.textColor = [UIColor blackColor];
    numLbl.font = [UIFont boldSystemFontOfSize:24.0f];
    numLbl.backgroundColor = [UIColor clearColor];
    
    if (component == 0) {
        numLbl.text = [NSString stringWithFormat:@"%d",row];
        numLbl.textAlignment = NSTextAlignmentRight;
    }else if(component == 1){
        if (row == 0) {
            numLbl.text = [NSString stringWithFormat:@"%d%d",row * 5,row * 5];
        }else if(row == 1){
            numLbl.text = [NSString stringWithFormat:@"%d%d",0,row * 5];
        }else{
            numLbl.text = [NSString stringWithFormat:@"%d",row * 5];
        }
        
        numLbl.textAlignment = NSTextAlignmentLeft;
    }
    return [numLbl autorelease];
}

#pragma mark -
#pragma mark UIPrickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == 0) {
        return [NSString stringWithFormat:@"%d",row];
    }else if(component == 1){
        return [NSString stringWithFormat:@"%d",row * 5];
    }
    return nil;
}


- (void) confirmBtnClick:(id)sender{
    [self slideDown];
    if ([delegate respondsToSelector:@selector(timeSelectorConfirm:)]) {
        [delegate timeSelectorConfirm:self];
    }
}

- (void) cancelBtnClick:(id)sender{
    [self slideDown];
    if ([delegate respondsToSelector:@selector(timeSelectorCancel:)]) {
        [delegate timeSelectorCancel:self];
    }
}
@end
