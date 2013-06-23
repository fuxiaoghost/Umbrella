//
//  NumCell.m
//  Umbrella
//
//  Created by Dawn on 13-6-22.
//  Copyright (c) 2013年 Dawn. All rights reserved.
//

#import "NumCell.h"

@implementation NumCell
@synthesize cellType = _cellType;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 20, 44)];
        [self.contentView addSubview:bgImageView];
        bgImageView.clipsToBounds = YES;
        [bgImageView release];
        
        checkImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"checkbox_bg.png"]];
        [self.contentView addSubview:checkImageView];
        checkImageView.contentMode = UIViewContentModeCenter;
        [checkImageView release];
        checkImageView.frame = CGRectMake(SCREEN_WIDTH - 60,0,44,44);
    }
    return self;
}

- (void) setCellType:(NumCellType)cellType{
    _cellType = cellType;
    switch (cellType) {
        case HeaderCell:{
            bgImageView.image = [UIImage stretchableImageWithPath:@"table_upside_normal.png"];
            break;
        }
        case MiddleCell:{
            bgImageView.image = [UIImage stretchableImageWithPath:@"table_middle_normal.png"];
            break;
        }
        case FooterCell:{
            bgImageView.image = [UIImage stretchableImageWithPath:@"table_below_normal.png"];
            break;
        }
        case NormalCell:{
            bgImageView.image = [UIImage stretchableImageWithPath:@"table_normal.png"];
            break;
        }
        default:
            break;
    }
}

- (void) setChecked:(BOOL)checked{
    if (checked) {
        checkImageView.image = [UIImage imageNamed:@"checkbox.png"];
    }else{
        checkImageView.image = [UIImage imageNamed:@"checkbox_bg.png"];
    }
}

- (void) setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    [super setHighlighted:highlighted animated:animated];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected animated:animated];
}


@end
