//
//  CalendarCollectionViewCell.h
//  Calendar_MyDemo
//
//  Created by lijinfeng on 16/1/19.
//  Copyright © 2016年 lijinfeng. All rights reserved.
//



#import <UIKit/UIKit.h>
#import "CalendarModel.h"


static NSString *CalendarCollectionViewCellIdentifier = @"CalendarCollectionViewCellIdentifier";

@interface CalendarCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) DayModel *calendarModel;

- (void)settitle:(NSString *)title withStatus:(Day_type)status;

@end


