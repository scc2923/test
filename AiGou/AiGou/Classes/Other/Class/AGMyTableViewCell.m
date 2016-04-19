//
//  AGMyTableViewCell.m
//  AiGou
//
//  Created by rimi on 14/12/30.
//  Copyright (c) 2014年 AG. All rights reserved.
//

#import "AGMyTableViewCell.h"
#import "Defines.h"

#define VIEW_TAG 100

@implementation AGMyTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    CGRect f = self.frame;
    f.size.width = self.frame.size.width - 14;
    self.frame = f;
    if (self) {
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(7, 0, 200, 40)];
        label.tag = VIEW_TAG;
        label.font = [UIFont systemFontOfSize:16.0];
        [self.contentView addSubview:label];
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 40, CGRectGetWidth(self.contentView.bounds), 0.5)];
        lineView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.1];
        [self.contentView addSubview:lineView];
    }
    NSLog(@"%f", self.frame.size.width);
    return self;
}

- (void)setCellTitleName:(NSString *)cellTitleName
{
    if (_cellTitleName != cellTitleName) {
        _cellTitleName = [NSString stringWithString:cellTitleName];
    }
    [(UILabel *)[self.contentView viewWithTag:VIEW_TAG] setText:_cellTitleName];
}

- (void)setIsAddToView:(NSString *)isAddToView
{
    if (_isAddToView != isAddToView) {
        _isAddToView = [NSString stringWithString:isAddToView];
    }
    if ([_isAddToView isEqualToString:@"YES"]) {
        [self.contentView addSubview:_cellSwith];
    }
}

@end
