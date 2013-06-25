//
//  RemindCell.h
//  Umbrella
//
//  Created by Dawn on 13-6-25.
//  Copyright (c) 2013年 Dawn. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    RemindHeaderCell,
    RemindMiddleCell,
    RemindFooterCell,
    RemindNormalCell
} RemindCellType;


@interface RemindCell : UITableViewCell{
@private
    UIImageView *bgImageView;
    UIButton *detailButton;
}
@property (nonatomic,assign) RemindCellType cellType;
- (void) setDetail:(BOOL)detail;
@end
