//
//  CalendarModel.h
//  Calendar_MyDemo
//
//  Created by lijinfeng on 16/1/28.
//  Copyright © 2016年 lijinfeng. All rights reserved.
//

//////一个月中不同天数的枚举
typedef enum Day_type
{
    CurrentMonthDay, //当月的天
    CurrenDay,//今天
    LastMontnDay,//灰色部分上个月的天
    NextMonthDay,//灰色部分下个月的天
}Day_type;
//日期下的标记
typedef enum Tag_type
{
    notTag = 0, //没有标记
    GrayTag = 1,//灰色标记
    GreenTag = 2,//绿色标记
    RedTag = 3,//红色标记
}Tag_type;

#import <Foundation/Foundation.h>

@interface CalendarModel : NSObject

@property (nonatomic, assign) NSInteger year;
@property (nonatomic, assign) NSInteger month;
@property (nonatomic, strong) NSArray *monthOfDaysArray;

@end

@interface DayModel : NSObject

@property (nonatomic , strong) NSString *day;
@property (nonatomic , assign) Day_type status;
@property (nonatomic , assign) Tag_type tagStatus;

@end
