//
//  SettingForRemindViewController.h
//  Umbrella
//
//  Created by Dawn on 13-6-16.
//  Copyright (c) 2013年 Dawn. All rights reserved.
//

#import "BaseViewController.h"
#import "NumSelectorViewController.h"

@interface SettingForRemindViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,NumSelectorViewControllerDelegate>{
    
}
@property (nonatomic,assign) NSInteger dataIndex;
@end
