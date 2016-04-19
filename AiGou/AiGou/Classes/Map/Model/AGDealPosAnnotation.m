//
//  AGDealPosAnnotation.m
//  AiGou
//
//  Created by rimi on 14/12/25.
//  Copyright (c) 2014年 AG. All rights reserved.
//

#import "AGDealPosAnnotation.h"
#import "AGMetaDataTool.h"
#import "AGDeal.h"

@implementation AGDealPosAnnotation

- (void)setDeal:(AGDeal *)deal
{
    _deal = deal;
    
    for (NSString *c in deal.categories) {
        NSString *icon = [[AGMetaDataTool sharedAGMetaDataTool] iconWithCategoryName:c];
        if (icon) {
            _icon = [icon stringByReplacingOccurrencesOfString:@"filter_" withString:@""];
            break;
        }
    }
}

@end
