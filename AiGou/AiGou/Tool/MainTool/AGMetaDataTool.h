//
//  AGMetaDataTool.h
//  AiGou
//
//  Created by rimi on 14/12/25.
//  Copyright (c) 2014年 AG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

@class AGCity, AGOrder;

@interface AGMetaDataTool : NSObject

singleton_interface(AGMetaDataTool)

@property (nonatomic, strong, readonly) NSDictionary *totalCities; // 所有的城市
@property (nonatomic, strong, readonly) NSArray *totalCitySections; // 所有的城市组数据
@property (nonatomic, strong, readonly) NSArray *totalCategories; // 所有的分类数据

// 所有的排序数据
@property (nonatomic, strong, readonly) NSArray *totalOrders;

- (AGOrder *)orderWithName:(NSString *)name;

- (NSString *)iconWithCategoryName:(NSString *)name;


@property (nonatomic, strong) AGCity *currentCity; // 当前选中的城市
@property (nonatomic, strong) NSString *currentCategory; // 当前选中的类别
@property (nonatomic, strong) NSString *currentDistrict; // 当前选中的区域
@property (nonatomic, strong) AGOrder *currentOrder; // 当前选中的排序

@end
