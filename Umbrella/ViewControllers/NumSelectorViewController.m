//
//  NumSelectorViewController.m
//  Umbrella
//
//  Created by Dawn on 13-6-22.
//  Copyright (c) 2013年 Dawn. All rights reserved.
//

#import "NumSelectorViewController.h"
#import "NumCell.h"

@interface NumSelectorViewController ()

@end

@implementation NumSelectorViewController
@synthesize num;
@synthesize navTitle;
@synthesize tips;
@synthesize num_min;
@synthesize num_max;
@synthesize delegate;

- (void) dealloc{
    self.num_min = 0;
    self.num_max = 0;
    self.num = 0;
    self.navTitle = nil;
    self.tips = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = self.navTitle;
    
    UITableView *numList = [[UITableView alloc] initWithFrame:CGRectMake(0, 45, SCREEN_WIDTH, MAINCONTENTHEIGHT - 1) style:UITableViewStyleGrouped];
    numList.separatorStyle = UITableViewCellSeparatorStyleNone;
    numList.delegate = self;
    numList.dataSource = self;
    numList.backgroundView = nil;
    numList.backgroundColor = [UIColor clearColor];
    numList.rowHeight = 44;
    [self.view addSubview:numList];
    [numList release];
    
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
        numCell.cellType = HeaderCell;
    }else if(indexPath.row == self.num_max - self.num_min){
        numCell.cellType = FooterCell;
    }else{
        numCell.cellType = MiddleCell;
    }

    numCell.textLabel.text = [NSString stringWithFormat:@"%d天",self.num_min + indexPath.row];
    return numCell;
}

#pragma mark -
#pragma UITableViewDelegate
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.num = indexPath.row + self.num_min;
    [tableView reloadData];
    
    if ([delegate respondsToSelector:@selector(numSelector:didSelected:)]) {
        [delegate numSelector:self didSelected:[NSNumber numberWithInt:self.num]];
    }
}
@end
