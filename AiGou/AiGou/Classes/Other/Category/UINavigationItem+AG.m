//
//  UINavigationItem+AG.m
//  AiGou
//
//  Created by rimi on 14-12-23.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "UINavigationItem+AG.h"

@implementation UINavigationItem (AG)

- (void)copyFromItem:(UINavigationItem *)other
{
    self.leftBarButtonItem = other.leftBarButtonItem;
    self.leftBarButtonItems = other.leftBarButtonItems;
    self.rightBarButtonItem = other.rightBarButtonItem;
    self.rightBarButtonItems = other.rightBarButtonItems;
    self.titleView = other.titleView;
    self.title = other.title;
}

@end
