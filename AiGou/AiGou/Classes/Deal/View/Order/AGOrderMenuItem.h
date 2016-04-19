//
//  AGOrderMenuItem.h
//  AiGou
//
//  Created by rimi on 14/12/27.
//  Copyright (c) 2014年 AG. All rights reserved.
//

#import "AGDealBottomMenuItem.h"

@class AGOrder;

@interface AGOrderMenuItem : AGDealBottomMenuItem

@property (nonatomic, strong)AGOrder * order;

@end
