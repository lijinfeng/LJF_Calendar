//
//  FirstViewController.m
//  Calendar_MyDemo
//
//  Created by lijinfeng on 16/1/19.
//  Copyright © 2016年 lijinfeng. All rights reserved.
//

#import "FirstViewController.h"

#import "CalendarView.h"

@interface FirstViewController ()

@property (nonatomic, strong) CalendarView *calendarV;


@end

@implementation FirstViewController

#pragma mark - View cycle

- (void)loadView
{
    [super loadView];
    [self.view addSubview:self.calendarV];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.calendarV.frame = self.view.frame;
    
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
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CalendarModel *calendarModel = obj;
            [calendarModel.monthOfDaysArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                DayModel *dayModel = obj;
                NSInteger i = idx;
                if (i%6==0) {
                    dayModel.tagStatus = GrayTag;
                }
                if (i%10 == 0) {
                    dayModel.tagStatus = RedTag;
                }
                if (i%13 == 0) {
                    dayModel.tagStatus = GreenTag;
                }
            }];
        }];
        _calendarV.calendarArray = array;
        [_calendarV setSelectDay:^(NSDate *date,DayModel *dayModel) {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            NSString *strDate = [dateFormatter stringFromDate:date];
            NSString *messageStr = [[NSString alloc] initWithFormat:@"您确定要选择%@这个日期吗？",strDate];
            UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:@"提示" message:messageStr delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alertV show];
        }];
    }
    return _calendarV;
}

@end
