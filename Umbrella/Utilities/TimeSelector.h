//
//  TimeSelector.h
//  Umbrella
//
//  Created by Dawn on 13-7-13.
//  Copyright (c) 2013年 Dawn. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol TimeSelectorDelegate;

@interface TimeSelector : NSObject<UIPickerViewDataSource,UIPickerViewDelegate>{
@private
    UIView *contentView;
    UIPickerView* pickerView;
    id delegate;
}
@property (nonatomic,assign) id<TimeSelectorDelegate> delegate;
@property (nonatomic,assign) NSInteger time;
- (void) popOverView:(UIView *)view;
- (void) slideDown;
@end

@protocol TimeSelectorDelegate <NSObject>
@optional
- (void) timeSelectorConfirm:(TimeSelector *)timeSelector;
- (void) timeSelectorCancel:(TimeSelector *)timeSelector;
@end