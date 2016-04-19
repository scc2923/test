//
//  AGSettingItem.m
//  AiGou
//
//  Created by rimi on 14/12/31.
//  Copyright (c) 2014年 AG. All rights reserved.
//  一个Item对应一个Cell
// 用来描述当前cell里面显示的内容，描述点击cell后做什么事情

#import "AGSettingItem.h"

@implementation AGSettingItem

+ (id)itemWithIcon:(NSString *)icon title:(NSString *)title
{
    AGSettingItem *item = [[self alloc] init];
    item.icon = icon;
    item.title = title;
    return item;
}

+ (id)itemWithTitle:(NSString *)title
{
    return [self itemWithIcon:nil title:title];
}

@end
