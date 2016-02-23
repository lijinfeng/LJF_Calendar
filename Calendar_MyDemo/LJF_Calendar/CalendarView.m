//
//  CalendarView.m
//  Calendar_MyDemo
//
//  Created by lijinfeng on 16/2/19.
//  Copyright © 2016年 lijinfeng. All rights reserved.
//

#define HeaderHeight 100

#import "CalendarView.h"
#import "CalendarManage.h"
#import "CalendarCollectionViewCell.h"
#import "CalendarHeaderCollectionReusableView.h"

@interface CalendarView()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    
}

@end

@implementation CalendarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.calendarCV];
        
        [self updateConstraintsIfNeeded];
    }
    return self;
}

- (void)updateConstraints
{
    [super updateConstraints];
    
    _calendarCV.frame = self.bounds;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self selectRow];
}

#pragma mark - Get

- (UICollectionView *)calendarCV
{
    if (!_calendarCV) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        _calendarCV = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [_calendarCV registerClass:[CalendarCollectionViewCell class] forCellWithReuseIdentifier:CalendarCollectionViewCellIdentifier];
        _calendarCV.dataSource = self;
        _calendarCV.delegate = self;
        _calendarCV.backgroundColor = [UIColor clearColor];
        
        [_calendarCV registerClass:[CalendarHeaderCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CalendarHeaderCollectionReusableViewIdentifier];
        
        _calendarCV.showsVerticalScrollIndicator = NO;

    }
    return _calendarCV;
    
}

#pragma mark - Method

- (void)selectRow
{
    
    NSDateComponents *components;
    
    if (_selectDate) {
        components = [CalendarManage getDateComponentsWithDate:_selectDate];
    }
    else
    {
        components = [CalendarManage getNowDate];
    }
    
    NSInteger iCurYear = [components year];  //当前的年份
    
    NSInteger iCurMonth = [components month];  //当前的月份
    
    NSInteger iCurDay = [components day];  // 当前的号数
    
    [self.calendarArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSInteger section = idx;
    
        CalendarModel *calendarModel = obj;
        if (calendarModel.year==iCurYear && calendarModel.month == iCurMonth) {
            [calendarModel.monthOfDaysArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                DayModel *model = obj;
                NSInteger row = idx;
                if ([model.day integerValue] == iCurDay) {
                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
                    [self.calendarCV selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionBottom];
                }
            }];
        }
    }];
}


#pragma mark - UICollectionViewDataSource
#pragma mark -
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    CalendarModel *calendarModel = self.calendarArray[section];
    
    CalendarManage *cM =  [[CalendarManage alloc] init];
    NSInteger weekNum = [cM getWeekFromAMonthUseYear:calendarModel.year UserMonth:calendarModel.month];
    return (weekNum+1)*7;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.calendarArray.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CalendarCollectionViewCell *calendarCell = [collectionView dequeueReusableCellWithReuseIdentifier:CalendarCollectionViewCellIdentifier forIndexPath:indexPath];
    if (self.calendarArray.count>0) {
        CalendarModel *calendarModel = self.calendarArray[indexPath.section];
        
        DayModel *dayModel = calendarModel.monthOfDaysArray[indexPath.row];
        [calendarCell setCalendarModel:dayModel];
        
    }
    
    return calendarCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.calendarArray.count>0) {
        CalendarModel *calendarModel = self.calendarArray[indexPath.section];
        DayModel *dayModel = calendarModel.monthOfDaysArray[indexPath.row];
        
        NSString *timeStr = [NSString stringWithFormat:@"%zi-%zi-%@",calendarModel.year,calendarModel.month,dayModel.day];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *date = [dateFormatter dateFromString:timeStr];
        
        if (self.selectDay) {
            self.selectDay(date,dayModel);
        }
        
        
    }
    
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    CalendarHeaderCollectionReusableView *headerV = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CalendarHeaderCollectionReusableViewIdentifier forIndexPath:indexPath];
    
    if (self.calendarArray.count>0) {
        CalendarModel *calendarModel = self.calendarArray[indexPath.section];
        NSString *headerStr = [NSString stringWithFormat:@"%zi年%zi月",calendarModel.year,calendarModel.month];
        [headerV setTitle:headerStr];
    }
    
    return headerV;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(collectionView.frame.size.width, 130);
}

#pragma mark - UICollectionViewDelegateFlowLayout
#pragma mark -
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = CGSizeMake(collectionView.frame.size.width/7.0, 50);
    return size;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return  UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return -0.01;
}

@end
