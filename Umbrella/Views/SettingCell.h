//
//  SettingCell.h
//  Umbrella
//
//  Created by Dawn on 13-6-16.
//  Copyright (c) 2013年 Dawn. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    HeaderCell,
    MiddleCell,
    FooterCell,
    NormalCell
} SettingCellType;

@interface SettingCell : UITableViewCell{
@private
    UIImageView *bgImageView;
    UIImageView *arrowView;
    UIView *hightlightView;
}

@property (nonatomic,assign) SettingCellType cellType;
- (void) setArrowHidden:(BOOL)hidden;
@end
