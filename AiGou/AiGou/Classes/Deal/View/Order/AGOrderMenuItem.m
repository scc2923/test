//
//  AGOrderMenuItem.m
//  AiGou
//
//  Created by rimi on 14/12/27.
//  Copyright (c) 2014年 AG. All rights reserved.
//

#import "AGOrderMenuItem.h"
#import "AGOrder.h"

@implementation AGOrderMenuItem

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setOrder:(AGOrder *)order
{
    _order = order;
    [self setTitle:order.name forState:UIControlStateNormal];
}

@end
