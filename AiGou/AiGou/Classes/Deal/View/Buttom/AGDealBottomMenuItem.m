//
//  AGDealBottomMenuItem.m
//  AiGou
//
//  Created by rimi on 14/12/26.
//  Copyright (c) 2014年 AG. All rights reserved.
//

#import "AGDealBottomMenuItem.h"
#import "UIImage+AG.h"
#include "Defines.h"

@implementation AGDealBottomMenuItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1.右边的分割线
        UIImage *img = [UIImage imageNamed:@"separator_topbar_item.png"];
        UIImageView *divider = [[UIImageView alloc] initWithImage:img];
        divider.bounds = CGRectMake(0, 0, 1, kBottomMenuItemH * 0.9);
        divider.center = CGPointMake(kBottomMenuItemW, kBottomMenuItemH * 0.5);
        [self addSubview:divider];
        
        // 2.文字颜色
        [self setTitleColor:kBottomTintColorN forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:kTopFont];
        
        // 3.设置被选中时的背景
        [self setBackgroundImage:[UIImage resizedImage:@"bg_filter_toggle_hl.png"] forState:UIControlStateSelected];
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    frame.size = CGSizeMake(kBottomMenuItemW, kBottomMenuItemH);
    [super setFrame:frame];
}

- (void)setHighlighted:(BOOL)highlighted {}

- (NSArray *)titles
{
    return nil;
}

@end
