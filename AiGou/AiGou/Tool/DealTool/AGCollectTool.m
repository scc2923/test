//
//  AGCollectTool.m
//  AiGou
//
//  Created by rimi on 14/12/25.
//  Copyright (c) 2014年 AG. All rights reserved.
//

#import "AGCollectTool.h"
#import "AGDeal.h"

#define kFilePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"collects.data"]

@interface AGCollectTool()
{
    NSMutableArray *_collectedDeals;
}
@end

@implementation AGCollectTool

singleton_implementation(AGCollectTool)

// 从文件中读取了2个团购对象
//

- (id)init
{
    if (self = [super init]) {
        // 1.加载沙盒中的收藏数据
        _collectedDeals = [NSKeyedUnarchiver unarchiveObjectWithFile:kFilePath];
        
        // 2.第一次没有收藏数据
        if (_collectedDeals == nil) {
            _collectedDeals = [NSMutableArray array];
        }
    }
    return self;
}

- (void)handleDeal:(AGDeal *)deal
{
    deal.collected = [_collectedDeals containsObject:deal];
}

- (void)collectDeal:(AGDeal *)deal
{
    deal.collected = YES;
    [_collectedDeals insertObject:deal atIndex:0];
    [NSKeyedArchiver archiveRootObject:_collectedDeals toFile:kFilePath];
}

- (void)uncollectDeal:(AGDeal *)deal
{
    deal.collected = NO;
    [_collectedDeals removeObject:deal];
    [NSKeyedArchiver archiveRootObject:_collectedDeals toFile:kFilePath];
}

@end