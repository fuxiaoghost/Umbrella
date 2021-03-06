//
//  CalendarViewController.m
//  Umbrella
//
//  Created by Dawn on 13-6-15.
//  Copyright (c) 2013年 Dawn. All rights reserved.
//

#import "CalendarViewController.h"
#import "TSQTACalendarRowCell.h"
#import "TimesSquare.h"

@interface CalendarViewController ()

@property (nonatomic, retain) NSTimer *timer;

@end

#pragma mark -
#pragma mark TSQCalendarView
@interface TSQCalendarView (AccessingPrivateStuff)

@property (nonatomic, readonly) UITableView *tableView;

@end

@implementation CalendarViewController

- (void) dealloc{
    self.calendar = nil;
    [super dealloc];
}

- (void)loadView;{
    TSQCalendarView *calendarView = [[TSQCalendarView alloc] init];
    calendarView.calendar = self.calendar;
    calendarView.rowCellClass = [TSQTACalendarRowCell class];
    calendarView.firstDate = [NSDate date];
    calendarView.pinsHeaderToTop = YES;
    calendarView.lastDate = [NSDate dateWithTimeIntervalSinceNow:60 * 60 * 24 * 365 * 5];
    calendarView.backgroundColor = UMB_LIGHTPINK;
    calendarView.pagingEnabled = YES;
    CGFloat onePixel = 1.0f / [UIScreen mainScreen].scale;
    calendarView.contentInset = UIEdgeInsetsMake(0.0f, onePixel, 0.0f, onePixel);
    
    self.view = calendarView;
}

- (void)viewDidLoad{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [self.timer invalidate];
    self.timer = nil;
}

#pragma mark -
#pragma mark Private Methods

- (void)setCalendar:(NSCalendar *)calendar{
    [_calendar release];
    _calendar = calendar;
    [_calendar retain];
    
    self.navigationItem.title = calendar.calendarIdentifier;
    self.tabBarItem.title = calendar.calendarIdentifier;
}



- (void)scroll{
    static BOOL atTop = YES;
    TSQCalendarView *calendarView = (TSQCalendarView *)self.view;
    UITableView *tableView = calendarView.tableView;
    
    [tableView setContentOffset:CGPointMake(0.f, atTop ? 10000.f : 0.f) animated:YES];
    atTop = !atTop;
}

@end
