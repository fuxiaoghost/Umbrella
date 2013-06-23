//
//  SettingViewController.m
//  Umbrella
//
//  Created by Dawn on 13-6-15.
//  Copyright (c) 2013年 Dawn. All rights reserved.
//

#import "SettingViewController.h"
#import "ActionButton.h"
#import "SettingCell.h"
#import "SettingForCycleViewController.h"
#import "SettingForDataViewController.h"
#import "SettingForDisplayViewController.h"
#import "SettingForLockViewController.h"
#import "SettingForRemindViewController.h"

@interface SettingViewController ()
@property (nonatomic,retain) NSArray *configArray;
@end

@implementation SettingViewController
@synthesize configArray;

- (void) dealloc{
    self.configArray = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.title = @"设置";
    self.navigationController.navigationBarHidden = YES;
    
    // 获取配置文件，默认配置文件
    self.configArray = [Utils config];
    
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
#pragma Actions
- (void) closeButtonClick:(id)sender{
    if (IOSVersion_5) {
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }else{
        [self dismissModalViewControllerAnimated:YES];
    }
}

#pragma mark -
#pragma mark UITableViewDataSource
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.configArray.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"SettingCell";
    SettingCell *cell = (SettingCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[[SettingCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier] autorelease];
        cell.textLabel.text = [[self.configArray objectAtIndex:indexPath.row] objectForKey:@"Name"];
        cell.detailTextLabel.text = [[self.configArray objectAtIndex:indexPath.row] objectForKey:@"SubName"];
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
    switch (indexPath.row) {
        case 0:{
            SettingForDisplayViewController *settingForDisplayVC = [[SettingForDisplayViewController alloc] init];
            [self.navigationController pushViewController:settingForDisplayVC animated:YES];
            [settingForDisplayVC release];
            break;
        }
        case 1:{
            SettingForCycleViewController *settingForCycleVC = [[SettingForCycleViewController alloc] init];
            settingForCycleVC.dataIndex = indexPath.row;
            [self.navigationController pushViewController:settingForCycleVC animated:YES];
            [settingForCycleVC release];
            break;
        }
        case 2:{
            SettingForRemindViewController *settingForRemindVC = [[SettingForRemindViewController alloc] init];
            settingForRemindVC.dataIndex = indexPath.row;
            [self.navigationController pushViewController:settingForRemindVC animated:YES];
            [settingForRemindVC release];
            break;
        }
        case 3:{
            SettingForLockViewController *settingForLockVC = [[SettingForLockViewController alloc] init];
            [self.navigationController pushViewController:settingForLockVC animated:YES];
            [settingForLockVC release];
            break;
        }
        case 4:{
            SettingForDataViewController *settingForDataVC = [[SettingForDataViewController alloc] init];
            [self.navigationController pushViewController:settingForDataVC animated:YES];
            [settingForDataVC release];
            break;
        }
        default:
            break;
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
