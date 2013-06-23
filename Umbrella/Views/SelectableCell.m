//
//  SelectableCell.m
//  Elong_Shake
//
//  可选择的通用Cell
//
//  Created by Wang Shuguang on 13-1-31.
//  Copyright (c) 2013年 elong. All rights reserved.
//

#import "SelectableCell.h"

@implementation SelectableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        //m_imageHidden = YES;
    }
    return self;
}

- (void)dealloc{
	[m_checkImageView release];
	m_checkImageView = nil;
    [super dealloc];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setCheckImageViewCenter:(CGPoint)pt alpha:(CGFloat)alpha animated:(BOOL)animated{
	if (animated){
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationBeginsFromCurrentState:YES];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
		[UIView setAnimationDuration:0.3];
		
		m_checkImageView.center = pt;
		m_checkImageView.alpha = alpha;
		
		[UIView commitAnimations];
	}
	else{
		m_checkImageView.center = pt;
		m_checkImageView.alpha = alpha;
	}
}

// 设置可编辑状态
- (void) setEditing:(BOOL)editting animated:(BOOL)animated{
	if (self.editing == editting){
		return;
	}
	
	[super setEditing:editting animated:animated];
	
	if (editting){
		self.selectionStyle = UITableViewCellSelectionStyleNone;
		self.backgroundView = [[[UIView alloc] init] autorelease];
		self.backgroundView.backgroundColor = [UIColor whiteColor];
		self.textLabel.backgroundColor = [UIColor clearColor];
		self.detailTextLabel.backgroundColor = [UIColor clearColor];
		
		if (m_checkImageView == nil){
			m_checkImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"checkbox_bg.png"]];
			[self addSubview:m_checkImageView];
		}
    
		
		[self setChecked:m_checked];
		m_checkImageView.center = CGPointMake(-CGRectGetWidth(m_checkImageView.frame) * 0.5, CGRectGetHeight(self.bounds) * 0.5);
		m_checkImageView.alpha = 0.0;
		[self setCheckImageViewCenter:CGPointMake(20.5, CGRectGetHeight(self.bounds) * 0.5)
								alpha:1.0
                             animated:animated];
	}
	else{
		m_checked = NO;
		self.selectionStyle = UITableViewCellSelectionStyleBlue;
		self.backgroundView = nil;
		
		if (m_checkImageView){
			[self setCheckImageViewCenter:CGPointMake(-CGRectGetWidth(m_checkImageView.frame) * 0.5, CGRectGetHeight(self.bounds) * 0.5)
									alpha:0.0
								 animated:animated];
		}
	}
    
     m_checkImageView.hidden = m_imageHidden;
}

// 隐藏或显示选择按钮
- (void) setEditImageHidden:(BOOL)hidden{
    m_imageHidden = hidden;
    
    m_checkImageView.hidden = m_imageHidden;
    
}

// 设置选中状态
- (void) setChecked:(BOOL)checked{
	if (checked){
		m_checkImageView.image = [UIImage imageNamed:@"checkbox.png"];
		//self.backgroundView.backgroundColor = CELLBGCOLOR;
	}
	else{
		m_checkImageView.image = [UIImage imageNamed:@"checkbox_bg.png"];
		//self.backgroundView.backgroundColor = [UIColor whiteColor];
	}
	m_checked = checked;
}

@end
