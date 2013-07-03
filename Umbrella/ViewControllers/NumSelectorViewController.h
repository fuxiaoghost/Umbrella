//
//  NumSelectorViewController.h
//  Umbrella
//
//  Created by Dawn on 13-6-22.
//  Copyright (c) 2013年 Dawn. All rights reserved.
//

#import "BaseViewController.h"
#import "RemindCell.h"

@protocol NumSelectorViewControllerDelegate;
@interface NumSelectorViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,RemindCellDelegate>{
    id delegate;
}
@property (nonatomic,assign) NSInteger num;
@property (nonatomic,copy) NSString *navTitle;
@property (nonatomic,copy) NSString *tips;
@property (nonatomic,assign) NSInteger num_min;
@property (nonatomic,assign) NSInteger num_max;
@property (nonatomic,retain) NSMutableArray *remindArray;
@property (nonatomic,assign) id<NumSelectorViewControllerDelegate> delegate;
@end


@protocol NumSelectorViewControllerDelegate <NSObject>

- (void) numSelector:(NumSelectorViewController *)numSelector didSelected:(id)obj;

@end