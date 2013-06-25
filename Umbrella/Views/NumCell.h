//
//  NumCell.h
//  Umbrella
//
//  Created by Dawn on 13-6-22.
//  Copyright (c) 2013年 Dawn. All rights reserved.
//

#import "SelectableCell.h"

typedef enum{
    NumHeaderCell,
    NumMiddleCell,
    NumFooterCell,
    NumNormalCell
} NumCellType;

@interface NumCell : UITableViewCell{
@private
    UIImageView *bgImageView;
    UIImageView *checkImageView;
}
@property (nonatomic,assign) NumCellType cellType;
- (void) setChecked:(BOOL)checked;
@end
