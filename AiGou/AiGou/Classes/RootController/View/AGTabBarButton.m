//
//  AGTabBarButton.m
//  AiGou
//
//  Created by rimi on 14-12-23.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "AGTabBarButton.h"

#pragma mark - TabBar距离调整
#define TabBar_H 49
#define TabBarImage_H 26
#define TabBarImage_W 26
#define Space_Top 4 

@implementation AGTabBarButton

- (void)setHighlighted:(BOOL)highlighted { }

#pragma mark 设置Button内部的image的范围
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(contentRect.size.width/2 - TabBarImage_W/2, Space_Top, TabBarImage_W, TabBarImage_H);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(contentRect.size.width/2 - TabBarImage_W/2, TabBarImage_H + Space_Top, TabBarImage_W, TabBar_H-TabBarImage_H - Space_Top);
}

@end
