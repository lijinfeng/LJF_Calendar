//
//  SecondViewController.m
//  Calendar_MyDemo
//
//  Created by lijinfeng on 16/2/2.
//  Copyright © 2016年 lijinfeng. All rights reserved.
//

#import "SecondViewController.h"

#import "CalendarView.h"

@interface SecondViewController ()<UIAlertViewDelegate>

@property (nonatomic, strong) CalendarView *calendarV;

@end

@implementation SecondViewController

- (void)loadView
{
    [super loadView];
    [self.view addSubview:self.calendarV];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    _calendarV.frame = self.view.bounds;
}

- (void)updateViewConstraints
{
    [super updateViewConstraints];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Get

-(CalendarView *)calendarV
{
    if (!_calendarV) {
        _calendarV = [[CalendarView alloc] initWithFrame:self.view.bounds];
        
        NSDateComponents *components = [CalendarManage getNowDate];
        NSArray *array = [CalendarManage loadDataWithYear:[components year] withMonth:[components month] withTotalMonth:12];
        _calendarV.calendarArray = array;
        __weak typeof(self) weakSelf = self;
        [_calendarV setSelectDay:^(NSDate *date,DayModel *dayModel) {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            NSString *strDate = [dateFormatter stringFromDate:date];
            NSString *messageStr = [[NSString alloc] initWithFormat:@"您确定要选择%@这个日期吗？",strDate];
            UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:@"提示" message:messageStr delegate:weakSelf cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alertV show];
            dayModel.tagStatus = GrayTag;
            
        }];
        
//        _calendarV.layer.borderColor = [UIColor cyanColor].CGColor;
//        _calendarV.layer.borderWidth = 2;
    }
    return _calendarV;
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [_calendarV.calendarCV reloadData];
    }
}

@end
