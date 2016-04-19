//
//  AGRoundRectView.m
//  AiGou
//
//  Created by rimi on 14-12-30.
//  Copyright (c) 2014年 AG. All rights reserved.
//

#import "AGRoundRectView.h"
#import "UIImage+AG.h"

@implementation AGRoundRectView

- (void)drawRect:(CGRect)rect
{
    [[UIImage resizedImage:@"bg_order_cell.png"] drawInRect:rect];
}

@end
