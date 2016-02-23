//
//  CalendarManage.h
//  Calendar_MyDemo
//
//  Created by lijinfeng on 16/1/19.
//  Copyright © 2016年 lijinfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    DayOfWeekUnknown = 0,
    DayOfWeekMon = 1,
    DayOfWeekTue = 2,
    DayOfWeekWed = 3,
    DayOfWeekThu = 4,
    DayOfWeekFri = 5,
    DayOfWeekSat = 6,
    DayOfWeekSun = 7
}DayOfWeekType;

@interface CalendarManage : NSObject

-(NSInteger)getWeekFromAMonthUseYear:(NSInteger)Year UserMonth:(NSInteger)Month;

//-(int)GetNumberOfDayByYera:(int)year andByMonth:(int)month;
-(NSInteger)howManyDaysInThisMonth:(NSInteger)year month:(NSInteger)imonth;
-(DayOfWeekType)dayOfWeekTypeFromDay:(NSString *)aDay;
+ (NSDateComponents *)getNowDate;
+(NSDateComponents *)getDateComponentsWithDate:(NSDate *)date;
+ (NSInteger)getMonthWithDate:(NSString *)dateStr withDate:(NSString *)otherDateStr;
//去掉日期后面的时分秒
+ (NSDate *)extractDate:(NSDate *)date ;
//获取日期数据
+ (NSArray *)loadDataWithYear:(NSInteger)iCurYear withMonth:(NSInteger)iCurMonth withTotalMonth:(NSInteger)totalMonth;

@end
