//
//  AGOrderMenu.m
//  AiGou
//
//  Created by rimi on 14/12/27.
//  Copyright (c) 2014年 AG. All rights reserved.
//

#import "AGOrderMenu.h"
#import "AGMetaDataTool.h"
#import "AGOrderMenuItem.h"
#import "Defines.h"

@implementation AGOrderMenu

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1.往UIScrollView添加内容
        NSArray *orders = [AGMetaDataTool sharedAGMetaDataTool].totalOrders;
        NSInteger count = orders.count;

        for (int i = 0; i<count; i++) {
            // 创建排序item
            AGOrderMenuItem *item = [[AGOrderMenuItem alloc] init];
            [item addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
            item.order = orders[i];
            item.frame = CGRectMake(i * kBottomMenuItemW, 0, 0, 0);
            [_scrollView addSubview:item];
            
            // 默认选中第0个item
            if (i == 0) {
                item.selected = YES;
                _selectedItem = item;
            }
        }
        _scrollView.contentSize = CGSizeMake(count * kBottomMenuItemW, 0);
    }
    return self;
}

@end
