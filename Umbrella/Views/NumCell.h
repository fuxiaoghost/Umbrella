//
//  NumCell.h
//  Umbrella
//
//  Created by Dawn on 13-6-22.
//  Copyright (c) 2013年 Dawn. All rights reserved.
//

#import "SelectableCell.h"

typedef enum{
    HeaderCell,
    MiddleCell,
    FooterCell,
    NormalCell
} NumCellType;

@interface NumCell : UITableViewCell{
@private
    UIImageView *bgImageView;
    UIImageView *checkImageView;
}
@property (nonatomic,assign) NumCellType cellType;
- (void) setChecked:(BOOL)checked;
- (void) setCellType:(NumCellType)cellType;
@end
