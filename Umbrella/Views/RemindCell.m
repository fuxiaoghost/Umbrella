//
//  RemindCell.m
//  Umbrella
//
//  Created by Dawn on 13-6-25.
//  Copyright (c) 2013年 Dawn. All rights reserved.
//

#import "RemindCell.h"

@implementation RemindCell
@synthesize cellType = _cellType;
@synthesize delegate;
@synthesize detail = _detail;
@synthesize timeout;
@synthesize index;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 20, 44)];
        [self.contentView addSubview:bgImageView];
        bgImageView.clipsToBounds = YES;
        [bgImageView release];
        
        detailButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [detailButton setImage:[UIImage noCacheImageNamed:@"detail_icon.png"] forState:UIControlStateNormal];
        [self.contentView addSubview:detailButton];
        detailButton.frame = CGRectMake(SCREEN_WIDTH - 60,0,44,44);
        [detailButton addTarget:self action:@selector(detailButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void) detailButtonClick:(id)sender{
    if ([delegate respondsToSelector:@selector(remindCellDidClickDetail:)]) {
        [delegate remindCellDidClickDetail:self];
    }
}

- (void) setCellType:(RemindCellType)cellType{
    _cellType = cellType;
    switch (cellType) {
        case RemindHeaderCell:{
            bgImageView.image = [UIImage stretchableImageWithPath:@"table_upside_normal.png"];
            break;
        }
        case RemindMiddleCell:{
            bgImageView.image = [UIImage stretchableImageWithPath:@"table_middle_normal.png"];
            break;
        }
        case RemindFooterCell:{
            bgImageView.image = [UIImage stretchableImageWithPath:@"table_below_normal.png"];
            break;
        }
        case RemindNormalCell:{
            bgImageView.image = [UIImage stretchableImageWithPath:@"table_normal.png"];
            break;
        }
        default:
            break;
    }
}

- (void) setDetail:(BOOL)detail_{
    if (detail_) {
        [detailButton setImage:[UIImage noCacheImageNamed:@"detail_icon.png"] forState:UIControlStateNormal];
    }else{
        [detailButton setImage:nil forState:UIControlStateNormal];
    }
    _detail = detail_;
}
- (BOOL) detail{
    return _detail;
}

- (void) setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    [super setHighlighted:highlighted animated:animated];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected animated:animated];
}


@end
