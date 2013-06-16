//
//  SettingCell.m
//  Umbrella
//
//  Created by Dawn on 13-6-16.
//  Copyright (c) 2013年 Dawn. All rights reserved.
//

#import "SettingCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation SettingCell
@synthesize cellType = _cellType;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 20, 44)];
        [self.contentView addSubview:bgImageView];
        bgImageView.clipsToBounds = YES;
        [bgImageView release];
        
        // 高亮层
        hightlightView = [[UIView alloc] initWithFrame:bgImageView.bounds];
        [bgImageView addSubview:hightlightView];
        hightlightView.backgroundColor = UMB_LIGHTPINK;
        hightlightView.clipsToBounds = YES;
        hightlightView.hidden = YES;
        hightlightView.layer.cornerRadius = 2;
        [hightlightView release];
        
        // 箭头
        arrowView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 40, 14, 9, 15)];
        arrowView.image = [UIImage noCacheImageNamed:@"table_arrow.png"];
        [self.contentView addSubview:arrowView];
        [arrowView release];
    }
    return self;
}

- (void) setArrowHidden:(BOOL)hidden{
    arrowView.hidden = hidden;
}

- (void) setCellType:(SettingCellType)cellType{
    _cellType = cellType;
    switch (cellType) {
        case HeaderCell:{
            bgImageView.image = [UIImage stretchableImageWithPath:@"table_upside_normal.png"];
            hightlightView.frame = CGRectMake(0, 0, bgImageView.frame.size.width, bgImageView.frame.size.height+4);
            break;
        }
        case MiddleCell:{
            bgImageView.image = [UIImage stretchableImageWithPath:@"table_middle_normal.png"];
            hightlightView.frame = CGRectMake(0, -4, bgImageView.frame.size.width, bgImageView.frame.size.height + 8);
            break;
        }
        case FooterCell:{
            bgImageView.image = [UIImage stretchableImageWithPath:@"table_below_normal.png"];
            hightlightView.frame = CGRectMake(0, -4, bgImageView.frame.size.width, bgImageView.frame.size.height+4);
            break;
        }
        case NormalCell:{
            bgImageView.image = [UIImage stretchableImageWithPath:@"table_normal.png"];
            hightlightView.frame = CGRectMake(0, 0, bgImageView.frame.size.width, bgImageView.frame.size.height);
            break;
        }
        default:
            break;
    }
}

- (void) setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    [super setHighlighted:highlighted animated:animated];
    
    hightlightView.hidden = !highlighted;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected animated:animated];
    
    if (animated) {
        if (!selected) {
            [hightlightView performSelector:@selector(setHidden:) withObject:[NSNumber numberWithBool:!selected] afterDelay:.4];
        }else{
            hightlightView.hidden = !selected;
        }
    }else{
        hightlightView.hidden = !selected;
    }
}

@end
