//
//  CalendarManage.m
//  Calendar_MyDemo
//
//  Created by lijinfeng on 16/1/19.
//  Copyright © 2016年 lijinfeng. All rights reserved.
//

#import "CalendarManage.h"

#import "CalendarModel.h"

@implementation CalendarManage

//判断year年month月有多少天
-(NSInteger)howManyDaysInThisMonth:(NSInteger)year month:(NSInteger)imonth {
    if((imonth == 1)||(imonth == 3)||(imonth == 5)||(imonth == 7)||(imonth == 8)||(imonth == 10)||(imonth == 12))
        return 31;
    if((imonth == 4)||(imonth == 6)||(imonth == 9)||(imonth == 11))
        return 30;
    if((year%4 == 1)||(year%4 == 2)||(year%4 == 3))
    {
        return 28;
    }
    if(year%400 == 0)
        return 29;
    if(year%100 == 0)
        return 28;
    return 29;
}


-(NSInteger)getWeekFromAMonthUseYear:(NSInteger)Year UserMonth:(NSInteger)Month
{
    NSString *monthStr = [NSString stringWithFormat:@"%zi",Month];
    monthStr = monthStr.length == 1?[NSString stringWithFormat:@"0%@",monthStr]:monthStr;
    NSString *timeString = [NSString stringWithFormat:@"%zi%@01",Year,monthStr];
    int week = [self dayOfWeekTypeFromDay:timeString];
    
    week = (week==7?0:week);

    NSInteger days  = [self howManyDaysInThisMonth:Year month:Month];

    if (days == 31)
    {
//        if (week == 4 || week == 5)
        if (week>4)
        {
            return 5;
        }
        else
            return 4;
    }
    if (days == 30)
    {
//        if (week == 5)
        if (week>5)
        {
            return 5;
        }
        else
            return  4;
    }
    if (days == 29)
    {
        return  4;
    }
    if (days == 28)
    {
//        if (week == 7)
        if (week == 0)
        {
            return 3;
        }
        else
            return 4;
    }
    return 5;
    
}


///**
// * day of week (narrow name)
// */
-(NSString*)dayOfWeekFromDay:(NSString *)aDay
{
    NSDateFormatter *fmtter =[[NSDateFormatter alloc] init];
    [fmtter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [fmtter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    [fmtter setDateFormat:@"EEE"];
    
    //    NSDate *day = [[NSDate alloc] init];
    //    NSString *str = [[NSString alloc] init];
    
    
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    
    [inputFormatter setDateFormat:@"yyyyMMdd"];
    
    NSDate* day = [inputFormatter dateFromString:aDay];
    
    return [fmtter stringFromDate:day];
}
/**
 * day of week type
 */
-(DayOfWeekType)dayOfWeekTypeFromDay:(NSString *)aDay
{
    NSString* dayString = [self dayOfWeekFromDay:aDay];
    if (nil == dayString) {
        return DayOfWeekUnknown;
    }
    
    if ([dayString hasPrefix:@"Mon"]) {
        return DayOfWeekMon;
    }
    if ([dayString hasPrefix:@"Tue"]) {
        return DayOfWeekTue;
    }
    if ([dayString hasPrefix:@"Wed"]) {
        return DayOfWeekWed;
    }
    if ([dayString hasPrefix:@"Thu"]) {
        return DayOfWeekThu;
    }
    if ([dayString hasPrefix:@"Fri"]) {
        return DayOfWeekFri;
    }
    if ([dayString hasPrefix:@"Sat"]) {
        return DayOfWeekSat;
    }
    if ([dayString hasPrefix:@"Sun"]) {
        return DayOfWeekSun;
    }
    
    return DayOfWeekUnknown;
}

//得到当前时间
+ (NSDateComponents *)getNowDate
{
    NSDate* now = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    comps = [calendar components:unitFlags fromDate:now];
    return comps;
}

//date变NSDateComponents
+(NSDateComponents *)getDateComponentsWithDate:(NSDate *)date
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    comps = [calendar components:unitFlags fromDate:date];
    return comps;

}
//NSDatedate变NSString
+(NSString *)getTimeStringWithDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *strDate = [dateFormatter stringFromDate:date];
    return strDate;
}
//NSString变NSDatedate
+(NSDate *)getDateWithTimeString:(NSString *)str
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:str];
    return date;
}
//获取两个
+ (NSInteger)getMonthWithDate:(NSString *)dateStr withDate:(NSString *)otherDateStr
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[dateStr integerValue]];
    NSDate *otherDate = [NSDate dateWithTimeIntervalSince1970:[otherDateStr integerValue]];
    NSDateComponents *components = [self getDateComponentsWithDate:date];
    NSDateComponents *otherComponents = [self getDateComponentsWithDate:otherDate];
    NSInteger totalMonth = ([otherComponents year]-[components year])*12+([otherComponents month]-[components month]);
    return totalMonth;
}

//去掉日期后面的时分秒
+ (NSDate *)extractDate:(NSDate *)date {
     //get seconds since 1970
     NSTimeInterval interval = [date timeIntervalSince1970];
     int daySeconds = 24 * 60 * 60;
     //calculate integer type of days
     NSInteger allDays = interval / daySeconds;

     return [NSDate dateWithTimeIntervalSince1970:allDays * daySeconds];
}

//获取日期数据
+ (NSArray *)loadDataWithYear:(NSInteger)iCurYear withMonth:(NSInteger)iCurMonth withTotalMonth:(NSInteger)totalMonth
{
    
    NSMutableArray *muArray = [NSMutableArray new];
    for (int i = 0; i<=totalMonth; i++) {
        
        if(iCurMonth == 13)
        {
            iCurYear++;iCurMonth = 1;
        }
        CalendarModel *calendarModel = [[CalendarModel alloc] init];
        calendarModel.year = iCurYear;
        calendarModel.month = iCurMonth;
        NSArray *monthOfDaysArray = [self getAMonthOfDaysWithYear:iCurYear withMonth:iCurMonth];
        calendarModel.monthOfDaysArray = monthOfDaysArray;
        
        [muArray addObject:calendarModel];
        iCurMonth++;
    }
    return muArray;
}
//获取月份数据
+ (NSArray *)getAMonthOfDaysWithYear:(NSInteger)year withMonth:(NSInteger)month
{
    CalendarManage *cm = [[CalendarManage alloc] init];
    NSDateComponents *dateComponents = [CalendarManage getNowDate];
    
    NSMutableArray *dayMuArray = [[NSMutableArray alloc] initWithCapacity:35];
    
    //一个月的天数
    NSInteger monthOfDays = [cm howManyDaysInThisMonth:year month:month];
    
    //    NSLog(@"month:***%zi-%zi***天数%zi",year,month,monthOfDays);
    
    //月份的第一天是周几
    NSString *monthStr = [NSString stringWithFormat:@"%zi",month];
    monthStr = monthStr.length == 1?[NSString stringWithFormat:@"0%@",monthStr]:monthStr;
    NSString *timeString = [NSString stringWithFormat:@"%zi%@01",year,monthStr];
    int oneDay = [cm dayOfWeekTypeFromDay:timeString];
    //    NSLog(@"month:***%zi-%zi***星期%zi",year,month,oneDay);
    
    oneDay = (oneDay==7?0:oneDay);
    //补月前的几天
    for (int m = oneDay-1; m>=0; m--)
    {
        NSInteger newYear = year;
        NSInteger newMonth = month-1;
        if (newMonth == 0) {
            newMonth = 12;
            newYear--;
        }
        NSInteger lastdayNum = [cm howManyDaysInThisMonth:newYear month:newMonth];
        
        NSString *d = [NSString stringWithFormat:@"%zi",lastdayNum-m];
        
        //        NSLog(@"lastmonth:**%zi-%zi**----%zi---%@",newYear,newMonth,lastdayNum,d);
        DayModel *calendaModel = [[DayModel alloc] init];
        calendaModel.day = d;
        calendaModel.status = LastMontnDay;
        
        [dayMuArray addObject:calendaModel];
    }
    for (int j=1; j<=monthOfDays; j++) {
        
        DayModel *calendaModel = [[DayModel alloc] init];
        calendaModel.day = [NSString stringWithFormat:@"%zi",j];
        calendaModel.status = CurrentMonthDay;
        if ([dateComponents year] == year && [dateComponents month] == month && [dateComponents day]== j) {
            calendaModel.status = CurrenDay;
        }
        [dayMuArray addObject:calendaModel];
    }
    
    //补月后的几天
    NSString *timeString1 = [NSString stringWithFormat:@"%zi%@%zi",year,monthStr,monthOfDays];
    int endDay = [cm dayOfWeekTypeFromDay:timeString1];
    endDay = (endDay==7?0:endDay);
    for (int m=1;m<=(7-endDay);m++) {
        
        DayModel *calendaModel = [[DayModel alloc] init];
        calendaModel.day = [NSString stringWithFormat:@"%zi",m];
        calendaModel.status = NextMonthDay;
        calendaModel.tagStatus = notTag;
        
        [dayMuArray addObject:calendaModel];
    }
    
    return dayMuArray;
}




@end
