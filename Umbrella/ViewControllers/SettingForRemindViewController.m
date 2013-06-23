//
//  SettingForRemindViewController.m
//  Umbrella
//
//  Created by Dawn on 13-6-16.
//  Copyright (c) 2013年 Dawn. All rights reserved.
//

#import "SettingForRemindViewController.h"
#import "SettingCell.h"
#import "NumSelectorViewController.h"

@interface SettingForRemindViewController ()
@property (nonatomic,retain) NSMutableArray *configArray;
@end

@implementation SettingForRemindViewController
@synthesize dataIndex;
@synthesize configArray;

- (void) dealloc{
    self.configArray = nil;
    [super dealloc];
}

- (void)viewDidLoad{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    self.configArray = [Utils config];
	// Do any additional setup after loading the view.
    self.title = [[self.configArray objectAtIndex:dataIndex] objectForKey:@"Name"];
    
    //
    UITableView *settingList = [[UITableView alloc] initWithFrame:CGRectMake(0, 45, SCREEN_WIDTH, MAINCONTENTHEIGHT) style:UITableViewStyleGrouped];
    settingList.backgroundColor = [UIColor clearColor];
    settingList.backgroundView = nil;
    settingList.delegate = self;
    settingList.dataSource = self;
    settingList.sectionHeaderHeight = 30;
    settingList.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:settingList];
    [settingList release];
}

#pragma mark -
#pragma mark UITableViewDataSource
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *array = [[self.configArray objectAtIndex:dataIndex] objectForKey:@"Data"];
    return array.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"SettingCell";
    SettingCell *cell = (SettingCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[[SettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
        cell.textLabel.text = [[[[self.configArray objectAtIndex:dataIndex] objectForKey:@"Data"] objectAtIndex:indexPath.row] objectForKey:@"Name"];
        cell.backgroundView = [[[UIView alloc] init] autorelease];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.row == 0) {
        cell.cellType = HeaderCell;
    }else if(indexPath.row == self.configArray.count - 1){
        cell.cellType = FooterCell;
    }else{
        cell.cellType = MiddleCell;
    }
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NumSelectorViewController *numSelectorVC = [[NumSelectorViewController alloc] init];
    numSelectorVC.navTitle = [[[[self.configArray objectAtIndex:dataIndex] objectForKey:@"Data"] objectAtIndex:indexPath.row] objectForKey:@"Name"];
    numSelectorVC.num = [[[[[self.configArray objectAtIndex:dataIndex] objectForKey:@"Data"] objectAtIndex:indexPath.row] objectForKey:@"Data"] intValue];
    
    switch (indexPath.row) {
        case 0:{
            numSelectorVC.tips = @"您希望在此事件前几天进行提醒？设备会发出弹出窗口来提醒您";
            numSelectorVC.num_min = UMB_REMIND_MIN;
            numSelectorVC.num_max = UMB_REMIND_MIN;
            break;
        }
        case 1:{
            numSelectorVC.tips = @"您希望在此事件前几天进行提醒？设备会发出弹出窗口来提醒您";
            numSelectorVC.num_min = UMB_REMIND_MIN;
            numSelectorVC.num_max = UMB_REMIND_MIN;
            break;
        }
        case 2:{
            numSelectorVC.tips = @"您希望在此事件前几天进行提醒？设备会发出弹出窗口来提醒您";
            numSelectorVC.num_min = UMB_REMIND_MIN;
            numSelectorVC.num_max = UMB_REMIND_MIN;
            break;
        }
            
        default:
            break;
    }
    [self.navigationController pushViewController:numSelectorVC animated:YES];
    [numSelectorVC release];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
