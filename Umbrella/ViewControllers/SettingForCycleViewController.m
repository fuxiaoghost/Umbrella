//
//  SettingForCycleViewController.m
//  Umbrella
//
//  Created by Dawn on 13-6-16.
//  Copyright (c) 2013年 Dawn. All rights reserved.
//

#import "SettingForCycleViewController.h"
#import "SettingCell.h"
#import "NumSelectorViewController.h"

@interface SettingForCycleViewController ()
@property (nonatomic,retain) NSMutableArray *configArray;
@property (nonatomic,assign) NSInteger selectedIndex;
@end

@implementation SettingForCycleViewController
@synthesize dataIndex;
@synthesize selectedIndex;
@synthesize configArray;

- (void) dealloc{
    self.configArray = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
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
    NSString *name = cell.textLabel.text = [[[[self.configArray objectAtIndex:dataIndex] objectForKey:@"Data"] objectAtIndex:indexPath.row] objectForKey:@"Name"];
    cell.textLabel.text = name;
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NumSelectorViewController *numSelectorVC = [[NumSelectorViewController alloc] init];
    numSelectorVC.navTitle = [[[[self.configArray objectAtIndex:dataIndex] objectForKey:@"Data"] objectAtIndex:indexPath.row] objectForKey:@"Name"];
    
    NSString *key = [[[[self.configArray objectAtIndex:dataIndex] objectForKey:@"Data"] objectAtIndex:indexPath.row] objectForKey:@"Tag"];
    if ([Utils settingValueForKey:key]) {
        numSelectorVC.num = [[Utils settingValueForKey:key] intValue];
    }else{
        numSelectorVC.num = [[[[[self.configArray objectAtIndex:dataIndex] objectForKey:@"Data"] objectAtIndex:indexPath.row] objectForKey:@"Data"] intValue];
    }

    NSInteger min = [[[[[self.configArray objectAtIndex:dataIndex] objectForKey:@"Data"] objectAtIndex:indexPath.row] objectForKey:@"Min"] intValue];
    NSInteger max = [[[[[self.configArray objectAtIndex:dataIndex] objectForKey:@"Data"] objectAtIndex:indexPath.row] objectForKey:@"Max"] intValue];
    
    numSelectorVC.num_min = min;
    numSelectorVC.num_max = max;
    switch (indexPath.row) {
        case 0:{
            numSelectorVC.tips = @"月经周期只针对于没有用户使用数据的情况下的临时配置参数，在使用一段时间之后我们会以用户真实数据为准";
            break;
        }
        case 1:{
            numSelectorVC.tips = @"您的月经通常会持续多久？";
            break;
        }
        case 2:{
            numSelectorVC.tips = @"从下次月经日期开始往前数至排卵日。当前默认为下月经前14天";
            break;
        }
        
        default:
            break;
    }
    self.selectedIndex = indexPath.row;
    [self.navigationController pushViewController:numSelectorVC animated:YES];
    [numSelectorVC release];
    numSelectorVC.delegate = self;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark -
#pragma mark NumSelectorViewControllerDelegate
- (void) numSelector:(NumSelectorViewController *)numSelector didSelected:(id)obj{
    NSString *key = [[[[self.configArray objectAtIndex:dataIndex] objectForKey:@"Data"] objectAtIndex:self.selectedIndex] objectForKey:@"Tag"];
    [Utils setSettingValue:obj forKey:key];
}
@end
