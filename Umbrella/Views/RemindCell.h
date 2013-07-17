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

@protocol RemindCellDelegate;
@interface RemindCell : UITableViewCell{
@private
    UIImageView *bgImageView;
    UIButton *detailButton;
    id delegate;
}
@property (nonatomic,assign) RemindCellType cellType;
@property (nonatomic,assign) id<RemindCellDelegate> delegate;
@property (nonatomic,assign) BOOL detail;
@property (nonatomic,assign) NSInteger timeout;
@property (nonatomic,assign) NSInteger index;
@end


@protocol RemindCellDelegate <NSObject>

@optional
- (void) remindCellDidClickDetail:(RemindCell *)remindCell;

@end