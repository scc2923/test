//
//  AGDealTopMenuItem.m
//  AiGou
//
//  Created by rimi on 14/12/26.
//  Copyright (c) 2014年 AG. All rights reserved.
//

#define kTitleScale 0.8

#import "AGDealTopMenuItem.h"
#import "UIImage+AG.h"
#import "Defines.h"

@implementation AGDealTopMenuItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1.文字颜色
        [self setTitleColor:kTopTintColorN forState:UIControlStateNormal];
        [self setTitleColor:kTopTintColorH forState:UIControlStateHighlighted];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:kTopFont];
        // 2.设置箭头
        [self setImage:[UIImage imageNamed:@"ic_arrow_down.png"] forState:UIControlStateNormal];
        self.imageView.contentMode = UIViewContentModeCenter;
        
        // 3.右边的分割线
        UIImage *img = [UIImage imageNamed:@"separator_topbar_item.png"];
        UIImageView *divider = [[UIImageView alloc] initWithImage:img];
        divider.layer.masksToBounds = NO;
        divider.bounds = CGRectMake(0, 0, 1, kTopMenuItemH * 0.8);
        divider.center = CGPointMake(kTopMenuItemW, kTopMenuItemH * 0.5);
        [self addSubview:divider];
        
        self.backgroundColor = [UIColor whiteColor];
        // 4.选中时的背景
        [self setBackgroundImage:[UIImage resizedImage:@"slider_filter_bg_normal.png"] forState:UIControlStateSelected];
//        [self setBackgroundImage:[UIImage resizedImage:@"slider_filter_bg_normal.png"] forState:UIControlStateHighlighted];

    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    
    [self setTitle:title forState:UIControlStateNormal];
}

- (void)setFrame:(CGRect)frame
{
    frame.size = CGSizeMake(kTopMenuItemW, kTopMenuItemH);
    [super setFrame:frame];
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat h = contentRect.size.height;
    CGFloat w = contentRect.size.width * kTitleScale;
    return CGRectMake(0, 0, w, h);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat h = contentRect.size.height;
    CGFloat x = contentRect.size.width * kTitleScale;
    CGFloat w = contentRect.size.width - x;
    return CGRectMake(x, 0, w, h);
}

@end
