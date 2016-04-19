//
//  AGCollectTool.h
//  AiGou
//
//  Created by rimi on 14/12/25.
//  Copyright (c) 2014年 AG. All rights reserved.
//  专门用来处理收藏业务

#import <Foundation/Foundation.h>
#import "Singleton.h"

@class AGDeal;

@interface AGCollectTool : NSObject

singleton_interface(AGCollectTool)

// 获得所有的收藏信息
@property (nonatomic, strong, readonly) NSArray *collectedDeals;

// 处理团购是否收藏
- (void)handleDeal:(AGDeal *)deal;

// 添加收藏
- (void)collectDeal:(AGDeal *)deal;

// 取消收藏
- (void)uncollectDeal:(AGDeal *)deal;

@end
