//
//  CalendarHeaderCollectionReusableView.m
//  Calendar_MyDemo
//
//  Created by lijinfeng on 16/1/19.
//  Copyright © 2016年 lijinfeng. All rights reserved.
//

#import "CalendarHeaderCollectionReusableView.h"

@interface CalendarHeaderCollectionReusableView()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *weekV;

@end

@implementation CalendarHeaderCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.titleLabel];
        [self addSubview:self.weekV];
        [self updateConstraintsIfNeeded];
    }
    return self;
}

- (void)updateConstraints
{
    [super updateConstraints];
    
    self.titleLabel.frame = CGRectMake(0, 0, self.frame.size.width, 70);
    self.weekV.frame = CGRectMake(0, CGRectGetMaxY(self.titleLabel.frame), self.frame.size.width, 50);
}

#pragma mark - Get

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = UIColorFromRGBA(mainColor, 1);
        _titleLabel.font = [UIFont systemFontOfSize:18];
    }
    return _titleLabel;
}

- (UIView *)weekV
{
    if (!_weekV) {
        _weekV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 50)];
        
        UIImageView *topLineImgV = [[UIImageView alloc] initWithFrame:CGRectZero];
        topLineImgV.backgroundColor = [UIColor lightGrayColor];
        [_weekV addSubview:topLineImgV];
        topLineImgV.frame = CGRectMake(0, 0, _weekV.frame.size.width, 0.5);
        
        UIImageView *bottomLineImgV = [[UIImageView alloc] initWithFrame:CGRectZero];
        bottomLineImgV.backgroundColor = [UIColor lightGrayColor];
        [_weekV addSubview:bottomLineImgV];
        bottomLineImgV.frame = CGRectMake(0, CGRectGetMaxY(_weekV.frame)-0.5, _weekV.frame.size.width, 0.5);
        
        
        NSArray *weekArray = @[@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日"];
        CGFloat width = _weekV.frame.size.width/weekArray.count;
        [weekArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UILabel *weekLabel = [[UILabel alloc] init];
            weekLabel.text = obj;
            weekLabel.textColor = [UIColor lightGrayColor];
            weekLabel.textAlignment = NSTextAlignmentCenter;
            weekLabel.font = [UIFont systemFontOfSize:17];
            weekLabel.adjustsFontSizeToFitWidth = YES;
            weekLabel.minimumFontSize = 6;
            [_weekV addSubview:weekLabel];
            weekLabel.frame = CGRectMake(width*idx, 0.5, width, _weekV.frame.size.height-1);
        }];
    }
    return _weekV;
}

#pragma mark - Set
- (void)setTitle:(NSString *)title
{
    self.titleLabel.text = title;
}

@end
