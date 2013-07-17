//
//  NumSelectorViewController.m
//  Umbrella
//
//  Created by Dawn on 13-6-22.
//  Copyright (c) 2013年 Dawn. All rights reserved.
//

#import "NumSelectorViewController.h"
#import "NumCell.h"
#import "RemindCell.h"
#import "ActionButton.h"
#import "TimeSelector.h"

@interface NumSelectorViewController ()

@end

@implementation NumSelectorViewController
@synthesize num;
@synthesize navTitle;
@synthesize tips;
@synthesize num_min;
@synthesize num_max;
@synthesize delegate;
@synthesize remindArray;
@synthesize selectedRow;

- (void) dealloc{
    self.num_min = 0;
    self.num_max = 0;
    self.num = 0;
    self.navTitle = nil;
    self.tips = nil;
    self.remindArray = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = self.navTitle;
    
    numList = [[UITableView alloc] initWithFrame:CGRectMake(0, 45, SCREEN_WIDTH, MAINCONTENTHEIGHT - 1) style:UITableViewStyleGrouped];
    numList.separatorStyle = UITableViewCellSeparatorStyleNone;
    numList.delegate = self;
    numList.dataSource = self;
    numList.backgroundView = nil;
    numList.backgroundColor = [UIColor clearColor];
    numList.rowHeight = 44;
    [self.view addSubview:numList];
    [numList release];
    
    
    // header view
    UILabel *tipsLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH - 20, 10)];
    tipsLbl.font = [UIFont systemFontOfSize:14.0f];
    tipsLbl.numberOfLines = 0;
    tipsLbl.lineBreakMode = NSLineBreakByCharWrapping;
    tipsLbl.backgroundColor = [UIColor clearColor];
    
    CGSize tipsSize = CGSizeMake(tipsLbl.frame.size.width, 10000);
    CGSize newTipsSize = [self.tips sizeWithFont:tipsLbl.font constrainedToSize:tipsSize lineBreakMode:NSLineBreakByCharWrapping];
    tipsLbl.frame = CGRectMake(10, 10, SCREEN_WIDTH - 20, newTipsSize.height + 10);
    tipsLbl.text = self.tips;
    
    UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, tipsLbl.frame.size.height + tipsLbl.frame.origin.y)];
    [tableHeaderView addSubview:tipsLbl];
    [tipsLbl release];
    
    numList.tableHeaderView = tableHeaderView;
    [tableHeaderView release];
    
    // footer view
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
    
    ActionButton *actionButton  = [ActionButton buttonWithType:UIButtonTypeCustom];
    actionButton.frame = CGRectMake(50, 10, SCREEN_WIDTH - 100, 40);
    actionButton.radius = 5.0f;
    [actionButton setTitle:@"确定" forState:UIControlStateNormal];
    [actionButton.titleLabel setFont:[UIFont boldSystemFontOfSize:18.0f]];
    [actionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [footerView addSubview:actionButton];
    
    [actionButton addTarget:self action:@selector(actionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    numList.tableFooterView = footerView;
    [footerView release];
    
}

#pragma mark -
#pragma mark Actions
- (void) actionButtonClick:(id)sender{
    if (self.remindArray) {
        
    }else{
        
        if ([delegate respondsToSelector:@selector(numSelector:didSelected:)]) {
            [delegate numSelector:self didSelected:[NSNumber numberWithInt:self.num]];
        }
    }

    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark UITableViewDataSource
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.num_max - self.num_min + 1;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.remindArray) {
        static NSString *cellIdentifier = @"RemindCell";
        RemindCell *remindCell = (RemindCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!remindCell) {
            remindCell = [[[RemindCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier] autorelease];
            remindCell.backgroundView = [[[UIView alloc] init] autorelease];
            remindCell.backgroundColor = [UIColor clearColor];
            remindCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        remindCell.index = indexPath.row;
        remindCell.delegate = self;
        remindCell.textLabel.text = [NSString stringWithFormat:@"%d天",self.num_min + indexPath.row];
        remindCell.detailTextLabel.text = @"";
        if (self.remindArray.count <= indexPath.row) {
            [remindCell setDetail:NO];
        }else{
            if ([[self.remindArray objectAtIndex:indexPath.row] longValue]) {
                [remindCell setDetail:YES];
                long timeout = [[self.remindArray objectAtIndex:indexPath.row] longValue];
                NSInteger clock = (int)(timeout/60);
                NSInteger minute = (int)(timeout%60);
                if (minute < 10) {
                    remindCell.detailTextLabel.text = [NSString stringWithFormat:@"%d:0%d      ",clock,minute];
                }else{
                    remindCell.detailTextLabel.text = [NSString stringWithFormat:@"%d:%d      ",clock,minute];
                }
                remindCell.timeout = timeout;
            }else{
                [remindCell setDetail:NO];
            }
        }
        
        if (indexPath.row == 0) {
            remindCell.cellType = RemindHeaderCell;
        }else if(indexPath.row == self.num_max - self.num_min){
            remindCell.cellType = RemindFooterCell;
        }else{
            remindCell.cellType = RemindMiddleCell;
        }
        
        return remindCell;
    }else{
        static NSString *cellIdentifier = @"NumCell";
        NumCell *numCell = (NumCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!numCell) {
            numCell = [[[NumCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
            numCell.backgroundView = [[[UIView alloc] init] autorelease];
            numCell.backgroundColor = [UIColor clearColor];
            numCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if (self.num_min + indexPath.row == self.num) {
            [numCell setChecked:YES];
        }else{
            [numCell setChecked:NO];
        }
        if (indexPath.row == 0) {
            numCell.cellType = NumHeaderCell;
        }else if(indexPath.row == self.num_max - self.num_min){
            numCell.cellType = NumFooterCell;
        }else{
            numCell.cellType = NumMiddleCell;
        }
        
        numCell.textLabel.text = [NSString stringWithFormat:@"%d天",self.num_min + indexPath.row];
        return numCell;
    }
}

#pragma mark -
#pragma mark RemindCellDelegate
- (void) remindCellDidClickDetail:(RemindCell *)remindCell{
    if(remindCell.detail){
        TimeSelector *timeSelector = [[TimeSelector alloc] init];
        [timeSelector popOverView:nil];
        [timeSelector autorelease];
        [timeSelector setTime:remindCell.timeout];
        timeSelector.delegate = self;
        self.selectedRow = remindCell.index;
    }
}

#pragma mark -
#pragma UITableViewDelegate
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.remindArray) {
        long timeout = [[self.remindArray objectAtIndex:indexPath.row] longValue];
        if (timeout == 0) {
            [self.remindArray replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithLong:7*60]];
        }else{
            [self.remindArray replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithLong:0]];
        }
        [tableView reloadData];
    }else{
        self.num = indexPath.row + self.num_min;
        [tableView reloadData];
    }
}

#pragma mark -
#pragma mark TimeSelectorDelegate
- (void) timeSelectorConfirm:(TimeSelector *)timeSelector{
    [self.remindArray replaceObjectAtIndex:self.selectedRow withObject:[NSNumber numberWithInt:timeSelector.time]];
    [numList reloadData];
}

- (void) timeSelectorCancel:(TimeSelector *)timeSelector{
    
}
@end
