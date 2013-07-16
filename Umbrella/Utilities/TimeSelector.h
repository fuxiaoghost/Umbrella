//
//  TimeSelector.h
//  Umbrella
//
//  Created by Dawn on 13-7-13.
//  Copyright (c) 2013年 Dawn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeSelector : NSObject<UIPickerViewDataSource,UIPickerViewDelegate>{
@private
    UIView *contentView;
}
- (void) popOverView:(UIView *)view;
- (void) slideDown;
@end
