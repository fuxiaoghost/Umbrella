//
//  SelectableCell.h
//  Elong_Shake
//
//  Created by Wang Shuguang on 13-1-31.
//  Copyright (c) 2013年 elong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectableCell : UITableViewCell{
@private
	UIImageView*	m_checkImageView;
	BOOL			m_checked;
    BOOL            m_imageHidden;
}
- (void) setChecked:(BOOL)checked;              // 设置选中状态
- (void) setEditImageHidden:(BOOL)hidden;       // 设置选择框是否显示
@end
