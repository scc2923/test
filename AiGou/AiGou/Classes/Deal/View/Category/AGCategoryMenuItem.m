//
//  AGCategoryMenuItem.m
//  AiGou
//
//  Created by rimi on 14/12/26.
//  Copyright (c) 2014年 AG. All rights reserved.
//

#import "AGCategoryMenuItem.h"
#import "AGCategory.h"
#import "Defines.h"

#define kTitleRatio 0.5

@implementation AGCategoryMenuItem

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1.文字
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        // 2.图片
        self.imageView.contentMode = UIViewContentModeCenter;
    }
    return self;
}

#pragma mark 设置按钮标题的frame
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleHeight = contentRect.size.height * kTitleRatio;
    CGFloat titleY = contentRect.size.height - titleHeight;
    return CGRectMake(0, titleY, contentRect.size.width, titleHeight);
}

#pragma mark 设置按钮图片的fram
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, 0, contentRect.size.width, contentRect.size.height * (1 - kTitleRatio));
}

- (void)setCategory:(AGCategory *)category
{
    _category = category;
    // 1.图标
    [self setImage:[UIImage imageNamed:category.icon] forState:UIControlStateNormal];
    // 2.标题
    [self setTitle:category.name forState:UIControlStateNormal];
}

- (NSArray *)titles
{
    return _category.subcategories;
}

@end
