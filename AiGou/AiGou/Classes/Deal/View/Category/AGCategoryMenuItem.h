//
//  AGCategoryMenuItem.h
//  AiGou
//
//  Created by rimi on 14/12/26.
//  Copyright (c) 2014年 AG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AGDealBottomMenuItem.h"

@class AGCategory;

@interface AGCategoryMenuItem : AGDealBottomMenuItem

// 需要显示的分类数据
@property (nonatomic, strong)AGCategory * category;

@end
