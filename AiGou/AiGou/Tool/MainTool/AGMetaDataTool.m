//
//  AGMetaDataTool.m
//  AiGou
//
//  Created by rimi on 14/12/25.
//  Copyright (c) 2014年 AG. All rights reserved.
//

#import "AGMetaDataTool.h"
#import "AGCitySection.h"
#import "NSObject+Value.h"
#import "AGCity.h"
#import "AGCategory.h"
#import "AGOrder.h"
#import "Defines.h"

#define kFilePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"visitedCityNames.data"]

@interface AGMetaDataTool()
{
    NSMutableArray *_visitedCityNames; // 存储曾经访问过城市的名称
    NSMutableDictionary *_totalCities; // 存放所有的城市 key 是城市名  value 是城市对象
    AGCitySection *_visitedSection; // 最近访问的城市组数组
}

@end

@implementation AGMetaDataTool

singleton_implementation(AGMetaDataTool)


- (id)init
{
    if (self = [super init]) {
        // 初始化项目中的所有元数据
        
        // 1.初始化城市数据
        [self loadCityData];
        
        // 2.初始化分类数据
        [self loadCategoryData];
        
        // 3.初始化排序数据
        [self loadOrderData];
    }
    return self;
}

#pragma mark 初始化排序数据
- (void)loadOrderData
{
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Orders.plist" ofType:nil]];
    NSInteger count = array.count;
    NSMutableArray *temp = [NSMutableArray array];
    for (int i = 0; i<count; i++){
        AGOrder *o = [[AGOrder alloc] init];
        o.name = array[i];
        o.index = i + 1;
        [temp addObject:o];
    }
    _totalOrders = temp;
}

- (AGOrder *)orderWithName:(NSString *)name
{
    for (AGOrder *order in _totalOrders) {
        if ([name isEqualToString:order.name]) {
            return order;
        }
    }
    return nil;
}

#pragma mark 通过分类名称取得图标
- (NSString *)iconWithCategoryName:(NSString *)name
{
    for (AGCategory *c in _totalCategories) {
        // 1.分类名称一致
        if ([c.name isEqualToString:name]) return c.icon;
        
        // 2.有这个子分类
        if ([c.subcategories containsObject:name]) return c.icon;
    }
    return nil;
}

#pragma mark 初始化分类数据
- (void)loadCategoryData
{
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Categories.plist" ofType:nil]];
    
    NSMutableArray *temp = [NSMutableArray array];
    
    // 1.添加全部分类
    AGCategory *all = [[AGCategory alloc] init];
    all.name = kAllCategory;
    all.icon = @"ic_filter_category_-1.png";
    [temp addObject:all];
    
    for (NSDictionary *dict in array) {
        AGCategory *c = [[AGCategory alloc] init];
        [c setValues:dict];
        [temp addObject:c];
    }
    
    _totalCategories = temp;
}

#pragma mark 初始化城市数据
- (void)loadCityData
{
    // 存放所有的城市
    _totalCities = [NSMutableDictionary dictionary];
    // 存放所有的城市组
    NSMutableArray *tempSections = [NSMutableArray array];
    
    // 1.添加热门城市组
    AGCitySection *hotSection = [[AGCitySection alloc] init];
    hotSection.name = @"热门城市";
    hotSection.cities = [NSMutableArray array];
    [tempSections addObject:hotSection];
    
    // 2.添加A-Z组
    // 加载plist数据
    NSArray *azArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Cities.plist" ofType:nil]];
    for (NSDictionary *azDict in azArray) {
        // 创建城市组
        AGCitySection *section = [[AGCitySection alloc] init];
        [section setValues:azDict];
        [tempSections addObject:section];
        
        // 遍历这组的所有城市
        for (AGCity *city in section.cities) {
            if (city.hot) { // 添加热门城市
                [hotSection.cities addObject:city];
            }
            [_totalCities setObject:city forKey:city.name];
        }
    }
    // 3.从沙盒中读取之前访问过的城市名称
    _visitedCityNames = [NSKeyedUnarchiver unarchiveObjectWithFile:kFilePath];
    if (_visitedCityNames == nil) {
        _visitedCityNames = [NSMutableArray array];
    }
    
    // 4.添加最近访问城市组
    AGCitySection *visitedSection = [[AGCitySection alloc] init];
    visitedSection.name = @"最近访问";
    visitedSection.cities = [NSMutableArray array];
    _visitedSection = visitedSection;
    
    for (NSString *name in _visitedCityNames) {
        AGCity *city = _totalCities[name];
        [visitedSection.cities addObject:city];
    }
    
    if (_visitedCityNames.count) {
        [tempSections insertObject:visitedSection atIndex:0];
    }
    
    _totalCitySections = tempSections;
#warning _currentCity -setting
//    _currentCity = _totalCities[@"成都"];
}

- (void)setCurrentCity:(AGCity *)currentCity
{
    _currentCity = currentCity;
    
    // 修改当前选中的区域
    _currentDistrict = kAllDistrict;
    
    // 1.移除之前的城市名
    [_visitedCityNames removeObject:currentCity.name];
    
    // 2.将新的城市名放到最前面
    [_visitedCityNames insertObject:currentCity.name atIndex:0];
    
    // 3.将新的城市放到_visitedSection的最前面
    [_visitedSection.cities removeObject:currentCity];
    [_visitedSection.cities insertObject:currentCity atIndex:0];
    
    [NSKeyedArchiver archiveRootObject:_visitedCityNames toFile:kFilePath];
    
    // 发出通知
    [[NSNotificationCenter defaultCenter] postNotificationName:kCityChangeNote object:nil];
    
    // 固定添加“最近访问城市”
    if (![_totalCitySections containsObject:_visitedSection]) {
        NSMutableArray *allSections = (NSMutableArray *)_totalCitySections;
        [allSections insertObject:_visitedSection atIndex:0];
    }
}

- (void)setCurrentCategory:(NSString *)currentCategory
{
    _currentCategory = currentCategory;
    // 发出通知
    [[NSNotificationCenter defaultCenter] postNotificationName:kCategoryChangeNote object:nil];
}

- (void)setCurrentDistrict:(NSString *)currentDistrict
{
    _currentDistrict = currentDistrict;
    // 发出通知
    [[NSNotificationCenter defaultCenter] postNotificationName:kDistrictChangeNote object:nil];
}

- (void)setCurrentOrder:(AGOrder *)currentOrder
{
    _currentOrder = currentOrder;
    // 发出通知
    [[NSNotificationCenter defaultCenter] postNotificationName:kOrderChangeNote object:nil];
}

@end
