//
//  CalendarView.h
//  Calendar_MyDemo
//
//  Created by lijinfeng on 16/2/19.
//  Copyright © 2016年 lijinfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalendarModel.h"

@interface CalendarView : UIView

@property (nonatomic, strong) UICollectionView *calendarCV;
@property (nonatomic, strong) NSArray *calendarArray;
@property (nonatomic, strong) void (^selectDay)(NSDate *date,DayModel *dayModel);
@property (nonatomic, strong) NSDate *selectDate;


@end
