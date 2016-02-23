                                         //
//  CalendarCollectionViewCell.m
//  Calendar_MyDemo
//
//  Created by lijinfeng on 16/1/19.
//  Copyright © 2016年 lijinfeng. All rights reserved.
//



#define statusWidth 6

#import "CalendarCollectionViewCell.h"

@interface CalendarCollectionViewCell() 

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *statusImgV;
@property (nonatomic, strong) UIImageView *lineImgV;

@end


@implementation CalendarCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.lineImgV];
        [self.contentView addSubview:self.statusImgV];
        [self updateConstraintsIfNeeded];
    }
    return self;
}

- (void)updateConstraints
{
    [super updateConstraints];
    self.backgroundColor = [UIColor clearColor];
    
    CGFloat titleHeight = CGRectGetHeight(self.frame)*0.6;
    
    _titleLabel.frame = CGRectMake((CGRectGetWidth(self.frame)-titleHeight)/2, (CGRectGetHeight(self.frame)-titleHeight)/2, titleHeight, titleHeight);
    
    _statusImgV.frame = CGRectMake(self.frame.size.width/2-3, CGRectGetMaxY(_titleLabel.frame)+3, statusWidth, statusWidth);
    
    _lineImgV.frame = CGRectMake(0, CGRectGetHeight(self.frame)-0.5, self.frame.size.width, 0.5);
    
    
    
}


- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if (selected) {
//        self.backgroundColor = [UIColor redColor];
        _titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.backgroundColor = UIColorFromRGBA(mainColor, 1);
        self.titleLabel.layer.masksToBounds = YES;
        self.titleLabel.layer.cornerRadius = (CGRectGetHeight(self.frame)*0.6)/2.0;
    }
    else
    {
//        self.backgroundColor = [UIColor whiteColor];
        _titleLabel.textColor = [UIColor blackColor];
        self.titleLabel.backgroundColor = [UIColor clearColor];
    }
}

#pragma mark - Get

- (UILabel *)titleLabel
{
    if (!_titleLabel) {                                                                                                                                                                                                                                                   
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.backgroundColor = [UIColor clearColor];
    }
    return _titleLabel;
}

- (UIImageView *)lineImgV
{
    if (!_lineImgV) {
        _lineImgV = [[UIImageView alloc] initWithFrame:CGRectZero];
        _lineImgV.backgroundColor = [UIColor lightGrayColor];
    }
    return _lineImgV;
}

- (UIImageView *)statusImgV
{
    if (!_statusImgV) {
        _statusImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, statusWidth, statusWidth)];
        _statusImgV.backgroundColor = [UIColor lightGrayColor];
        _statusImgV.layer.cornerRadius = statusWidth/2.0;
        _statusImgV.hidden = YES;
    }
    return _statusImgV;
}

- (void)setModel:(NSString *)title
{
    self.titleLabel.text = title;
    
}

- (void)setCalendarModel:(DayModel *)calendarModel
{
    _calendarModel = calendarModel;
    
    self.statusImgV.hidden = YES;
    self.titleLabel.layer.borderWidth = 0;
    self.userInteractionEnabled = YES;
    
    self.titleLabel.text = calendarModel.day;
    UIColor *titleColor = [UIColor blackColor];
    switch (calendarModel.status) {
        case CurrentMonthDay: {
            
            break;
        }
        case LastMontnDay: {
            titleColor = [UIColor lightGrayColor];
            self.userInteractionEnabled = NO;
            break;
        }
        case NextMonthDay: {
            titleColor = [UIColor lightGrayColor];
            self.userInteractionEnabled = NO;
            break;
        }
        case CurrenDay: {
            self.titleLabel.layer.borderWidth = 2;
            self.titleLabel.layer.borderColor = UIColorFromRGBA(mainColor, 1).CGColor;
            self.titleLabel.layer.cornerRadius = self.titleLabel.frame.size.width/2;
            break;
        }
    }
    self.titleLabel.textColor = titleColor;
    switch (calendarModel.tagStatus) {
            
        
            
        case RedTag: {
            self.statusImgV.hidden = NO;
            self.statusImgV.backgroundColor = [UIColor redColor];
            break;
        }
        case GrayTag: {
            self.statusImgV.hidden = NO;
            self.statusImgV.backgroundColor = [UIColor lightGrayColor];
            break;
        }
        case GreenTag: {
            self.statusImgV.hidden = NO;
            self.statusImgV.backgroundColor = UIColorFromRGBA(mainColor, 1);
            break;
        }
        case notTag:
        {
            self.statusImgV.hidden = YES;
            break;
        }
        default:
            break;
         
    }

}


- (void)settitle:(NSString *)title withStatus:(Day_type)status
{
    self.statusImgV.hidden = YES;
    self.titleLabel.layer.borderWidth = 0;
    self.userInteractionEnabled = YES;
    
    self.titleLabel.text = title;
    UIColor *titleColor = [UIColor blackColor];
    switch (status) {
        case CurrentMonthDay: {
            
            break;
        }
        case LastMontnDay: {
            titleColor = [UIColor lightGrayColor];
            self.userInteractionEnabled = NO;
            break;
        }
        case NextMonthDay: {
            titleColor = [UIColor lightGrayColor];
            self.userInteractionEnabled = NO;
            break;
        }
        case CurrenDay: {
            self.titleLabel.layer.borderWidth = 2;
            self.titleLabel.layer.borderColor = UIColorFromRGBA(mainColor, 1).CGColor;
            self.titleLabel.layer.cornerRadius = self.titleLabel.frame.size.width/2;
            break;
        }
    }
    self.titleLabel.textColor = titleColor;
    
    
}


@end

